#!/usr/bin/env -S nu --stdin

def main [direction: string@[left, right] = "right"] {
	let $active_monitor = mmsg get all-monitors | from json | get monitors | where active | get 0
	let $tags = mmsg get tags $active_monitor.name | from json | get tags
	let $active_tags = $tags | where client_count > 0
	let $current_tag = $tags | where is_active | get 0.index

	if ($active_tags | is-empty) {
		return
	}

	let $last_tag = $active_tags.index | math max
	let $first_tag = $active_tags.index | math min
	# can't use matches because it doesn't support variable pattern (equality checking; turns into assignment) matching
	if $current_tag > $last_tag {
		if $direction == "right" { mmsg dispatch view, $first_tag } else { mmsg dispatch viewtoleft_have_client }
	} else if $current_tag == $last_tag {
		if $direction == "right" { mmsg dispatch view, $first_tag } else { mmsg dispatch viewtoleft_have_client }
	} else if $current_tag == $first_tag {
		if $direction == "left" { mmsg dispatch view, $last_tag } else { mmsg dispatch viewtoright_have_client }
	} else if $current_tag < $first_tag {
		if $direction == "left" { mmsg dispatch view, $last_tag } else { mmsg dispatch viewtoright_have_client }
	} else {
		# "moving $direction"
		mmsg dispatch $"viewto($direction)_have_client"
	}
}
