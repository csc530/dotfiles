export alias chafa = chafa --align mid --work 9 --animate on --margin-right 1 --label on
export alias scoop-msearch = scoop-search-multisource
export alias omp = oh-my-posh
export alias pipes = pipes-rs
export alias dsf = diff-so-fancy
export alias csrepl = csharprepl
# i lose cd completely
# alias 'cd' = z
export alias 'to yml' = to yaml
export alias cols = columns
export alias dto = dotnet-tools-outdated
export alias inkcat =  deno run --allow-env --allow-read --allow-sys npm:@catppuccin/inkcat -- --no-copy # since copy does not work on linux
export alias grep = grep --color


# nu-stuff

# convert single-row table to a record
export def "to record" [] { transpose | transpose --as-record --header-row }
export alias "to rec" = to record
export alias to-rec = to record

export alias desc = describe
