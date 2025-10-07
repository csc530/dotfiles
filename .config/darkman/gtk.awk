#! /usr/bin/awk -f
#
# change gtk settings file based on <theme> and <colour> variables


BEGIN {
	FS = "="
	OFS = "="

    section = "" # clear the current ini section being processed
    COLLOID_COLOURS["rosewater"] = "pink"
    COLLOID_COLOURS["flamingo"] = "pink"
    COLLOID_COLOURS["pink"] = "pink"
    COLLOID_COLOURS["mauve"] = "purple"
    COLLOID_COLOURS["red"] = "red"
    COLLOID_COLOURS["maroon"] = "pink"
    COLLOID_COLOURS["peach"] = "orange"
    COLLOID_COLOURS["yellow"] = "yellow"
    COLLOID_COLOURS["green"] = "green"
    COLLOID_COLOURS["teal"] = "teal"
    COLLOID_COLOURS["sky"] = ""
    COLLOID_COLOURS["sapphire"] = ""
    COLLOID_COLOURS["blue"] = ""
    COLLOID_COLOURS["lavender"] = "purple"

    THEMES["mocha"] = "mocha"
    THEMES["latte"] = "latte"
    THEMES["frappe"] = "frappe"
    THEMES["frappé"] = "frappé"
    THEMES["macchiato"] = "macchiato"

    COLOURS["rosewater"] = "rosewater"
    COLOURS["flamingo"] = "flamingo"
    COLOURS["pink"] = "pink"
    COLOURS["mauve"] = "mauve"
    COLOURS["red"] = "red"
    COLOURS["maroon"] = "maroon"
    COLOURS["peach"] = "peach"
    COLOURS["yellow"] = "yellow"
    COLOURS["green"] = "green"
    COLOURS["teal"] = "teal"
    COLOURS["sky"] = "sky"
    COLOURS["sapphire"] = "sapphire"
    COLOURS["blue"] = "blue"
    COLOURS["lavender"] = "lavender"


    shade = "light or dark"

	if(!theme || !colour) {
		if(!theme)
			print "variable theme required: assign with -v theme={theme} or theme={theme} argument"

		if(!colour)
			print "colour variable required: supply with -v colour={colour} or colour={colour} argument"

		exit 1
	}

	theme = THEMES[tolower(theme)]
    colour = COLOURS[tolower(colour)]
    if(!theme || !colour) {
        if(!theme){
    		print "Invalid theme: " theme
    		print "themes: " join(THEMES, ", ")
		}
		if(!colour) {
    		print "Invalid colour: " colour
    		print "colours: " join(COLOURS, ", ")
    		exit 2
        }
	}


	if(theme == THEMES["latte"])
	    shade = "light"
	else
	    shade = "dark"
}

# operate on ini field values
/\[.*]/ {
    section = substr($0, 2, length($0) - 1 - 1)
    # print join(THEMES)
}

{
    if(section == "Settings") {
        if($1 == "gtk-theme-name") {
            # $2 = "Catppuccin-" capitalize(colour) "-" capitalize(shade)
            $2 = "Colloid-" capitalize(COLLOID_COLOURS[colour]) "-" capitalize(shade) "-Catppuccin"
        }
        else if($1 == "gtk-color-scheme") {
            $2 = COLOURS[tolower(colour)]
        }
        else if($1 == "gtk-cursor-theme-name") {
            if(theme == THEMES["frappe"])
                theme = THEMES["frappé"]
            $2 = "Catppuccin " capitalize(theme) " " capitalize(colour)
        }
        else if($1 == "gtk-icon-theme-name") {
            $2 = "Colloid-" capitalize(COLLOID_COLOURS[colour]) "-" capitalize(shade)
            sub(/--/,"", $2)
        }
        else if($1 == "gtk-application-prefer-dark-theme") {
            $2 = (shade == "dark")
        }
    }
    print $0
}

function join(array, sep,       out) {
    out = ""
    for(key in array)
        out = out sep array[key]

    sub("^" sep,"",out) # delete beginning separator 🙄

    return out
}

function capitalize(str,       out) {
    if(length(str) == 0)
        return ""

    wordcount = split(str, words, /\W/)
    for(i = 1; i <= wordcount; i++)
        out[i] = toupper(substr(words[i], 1, 1)) substr(words[i], 2)
    return join(out,"")
}
