const url = "https://financialmodelingprep.com/api/v3/"
def  apiKey  [] {
    op item get duu6tzwif47tgodkylarheqtpi --vault dev-opps  --fields credential
}

def getCommodities [ledgerFile?: path] {
    if (which ledger | is-empty) {
        error make {
            msg: "ledger not found"
            help: "install ledger-cli from https://www.ledger-cli.org/"
        }
    }

    let ledgerFile = if ($ledgerFile | is-empty) { $env.LEDGER_FILE } else { $ledgerFile }

    if not ($ledgerFile | path exists) {
        let span = (metadata $ledgerFile).span
        error make {
            msg: "ledger file not found"
            label: {
                text: "file not fouind"  # not mandatory unless $.label exists
                # optional
                span: {
                    # if $.label.span exists, both start and end must be present
                    start: $span.start
                    end: $span.end
                }
            }
        }
    }

    let commodities = ledger --file $ledgerFile commodities | lines --skip-empty | uniq --ignore-case | par-each {|e|
        if ($e | str contains _) {
            let temp =  $e | split column _ type symbol | first
            if $temp.type == 'c' {
                $temp | upsert type 'crypto'
            } else {
                $temp | upsert type 'stock' | upsert exchange ($e | split column _ exchange | first | get exchange)
            } | upsert name $e
        } else {
            {type: 'currency', name: $e}
        }
    }
    $commodities
}

export def pricedb [path?: path] {
    let path = if ($path | is-empty) { $env.LEDGER_FILE | path expand | path dirname | path join prices.db } else { $path }
    let commodities = getCommodities
    let stocks = $commodities | where type == 'stock'| par-each {|e|
        fmp quote $e.symbol | upsert commodity $e.name
    } | where {|e| not ($e | is-empty) }
    let cryptos = $commodities | where type == 'crypto' | par-each {|e|
        let symbol = $e.symbol + 'USD'
        fmp quote $symbol | upsert commodity $e.name
    } | where {|e| not ($e | is-empty) }
    let baseCurrency = $commodities | where type == 'currency' | first | get name
    let forex = $commodities | where type == 'currency'| par-each {|e|
        let currency = $e.name
        fmp forex $baseCurrency $currency | upsert commodity $e.name
    } | where {|e| not ($e | is-empty) }

    $cryptos | table --expand | print
    $baseCurrency  | table --expand | print
    $forex  | table --expand | print
    $stocks | table --expand | print
    char newline | save --append $path

    let prices = $stocks | append ($cryptos ) | append ($forex ) | upsert timestamp {|e| ($e.timestamp | first) * 1_000_000_000  | into datetime}
    $prices | each {|e|
            let directive = $'P ($e.timestamp | format date "%Y-%m-%d %H:%M:%S" | first)'

            if ($e.price | is-empty) {
                let currencies = $e.name | split column / from to | first
                let t = $"($directive) ($currencies.from) ($e.price)($currencies.to)"
                print $t
                $t | save --append $path
            } else {
                let t = $"($directive) ($e.commodity | to text) ($e.price | to text)($baseCurrency)"
                print $t
                $t | save --append $path
            }

            $"    ; ($e.name | to text)" | save --append $path
            char newline | save --append $path
    }

    $prices  | table --expand | print
}

# get a stock or crypto quote
export def "fmp quote" [
    ticker: string
    --simple
    --real-time
]: nothing -> table {
    let symbol = $ticker | str upcase
    if $real_time {
        http get --allow-errors ($url + "real-time-price/" + $symbol + "?apikey=" + $apiKey)
    } else if (not $simple) {
        http get --allow-errors ($url + "quote/" + $symbol + "?apikey=" + $apiKey)
    } else {
        http get --allow-errors ($url + "quote-short/" + $symbol + "?apikey=" + $apiKey)
    }
}

export def "fmp forex" [
    from: string
    to: string
    --simple
]: nothing -> table {
    let from = $from | str upcase
    let to = $to | str upcase
    if (not $simple) {
        http get --allow-errors ($url + "quote/" + $from + $to + "?apikey=" + $apiKey)
    } else {
        http get --allow-errors ($url + "historical-price-full/" + $from + $to + "?apikey=" + $apiKey)
    }
}
