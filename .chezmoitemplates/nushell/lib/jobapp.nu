# a fuck all for this dumb world to manage "jOb" applications
export def main [
    --help(-h)  # the help text my guy
] {
    if $help {
        help jobapp
    }
}

export def add [] {
    let job = gum input --placeholder "job name/title..."
    let src = gum input --placeholder "source (url, method, idek -_-)..."
    let description = gum write --placeholder "description... jus"
}