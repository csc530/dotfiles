# create a cache file and return its path
#
# overwrite existing files is the default behavior
export def main [
    path?: string # file name/path (relative to cache directory)


    --preserve(-p) # preserve existing file
    --append(-a) # append to existing file
    --raw(-r) # save as raw binary
    ]: any -> string {
    let $contents = $in | default ""
    let path = $path | default (random chars)
    let cachePath = $nu.cache-dir | path join $path

    mkdir $nu.cache-dir
    $contents | save $cachePath --force=(not $preserve) --append=$append --raw=$raw

    return $cachePath
}
