alias chafa = chafa --align mid --work 9 --animate on --margin-right 1 --label on
alias scoop-msearch = scoop-search-multisource
alias omp = oh-my-posh
alias pipes = pipes-rs
alias dsf = diff-so-fancy
alias csrepl = csharprepl
# i lose cd completely
# alias 'cd' = z
alias 'to yml' = to yaml
alias cols = columns
alias dto = dotnet-tools-outdated
alias inkcat =  deno run --allow-env --allow-read --allow-sys npm:@catppuccin/inkcat -- --no-copy # since copy does not work on linux
alias grep = grep --color


# nu-stuff

# convert single-row table to a record
def "to record" [] { transpose | transpose --as-record --header-row }
alias "to rec" = to record
alias to-rec = to record

alias desc = describe
