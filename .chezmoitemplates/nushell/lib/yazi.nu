# yazi with actual teleports 🕳️
export def --env main [
    ...args # set the current working entry
    # --cwd-file: path           # Write the cwd on exit to this file
    # --chooser-file:path        # Write the selected files to this file on open fired
    # --clear-cache              # Clear the cache directory
    # --client-id: number        # Use the specified client ID, must be a globally unique number
    # --local-events: string     # Report the specified local events to stdout
    # --remote-events: string    # Report the specified remote events to stdout
    # --debug                    # Print debug information
    # --version(-V)              # Print version
] {
	let tmp = (mktemp --tmpdir "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

export alias y = main
