# free and open-source replacement for the Epic Games Launcher
export extern main [
    -h, --help(-h)            # show this help message and exit
    -H, --full-help(-H)       # Show full help (including individual command help)
    -v, --debug(-v)           # Set loglevel to debug
    -y, --yes(-y)             # Default to yes for all prompts
    -V, --version(-V)         # Print version and exit
    -J, --pretty-json(-J)     # Pretty-print JSON
    --api-timeout(-A)=<seconds> # API HTTP request timeout (default: 10 seconds)
]

# Activate games on third party launchers
export extern activate [
    --help(-h)    # show this help message and exit
    --uplay(-U)   # Activate Uplay/Ubisoft Connect titles on your Ubisoft account (Uplay install not required)
    --origin(-O)  # Activate Origin/EA App managed titles on your EA account (requires Origin to be installed)
]

#    ###    ##       ####    ###     ######
#   ## ##   ##        ##    ## ##   ##    ##
#  ##   ##  ##        ##   ##   ##  ##
# ##     ## ##        ##  ##     ##  ######
# ######### ##        ##  #########       ##
# ##     ## ##        ##  ##     ## ##    ##
# ##     ## ######## #### ##     ##  ######

# Manage aliases
export extern alias [
    --help(-h)            # show this help message and exit
]

# add alias(es)
export extern "alias add" [
    app_name: string@"nu completion game name"
    alias: string
]

# rename alias(es)
export extern "alias rename" [
    old_alias: string@"nu completion alias"
    new_alias: string
]

# remove alias(es)
export extern "alias remove" [
    alias: string@"nu completion alias"
]

# list alias(es)
export extern "alias list" [
    alias?: string@"nu completion alias"
]


# Authenticate with the Epic Games Store
export extern auth [
    --help(-h)            # show this help message and exit
    --import              # Import Epic Games Launcher authentication data (logs out of EGL)
    --code=<authorization code> # Use specified authorization code instead of interactive authentication
    --token=<exchange token> # Use specified exchange token instead of interactive authentication
    --sid=<session id>    # Use specified session id instead of interactive authentication
    --delete              # Remove existing authentication (log out)
    --disable-webview     # Do not use embedded browser for login
]

# Clean cloud saves
export extern clean-saves  [
    --help(-h)           # show this help message and exit
    --delete-incomplete  # Delete incomplete save files

    game?: string@"nu completion game name"
]

# Remove old temporary, metadata, and manifest files
export extern cleanup [
    --help(-h)        # show this help message and exit
    --keep-manifests  # Do not delete old manifests
]

# Setup CrossOver for launching games (macOS only)
export extern crossover [
    --help(-h)            # show this help message and exit
    --reset               # Reset default/app-specific crossover configuration
    --download            # Automatically download and set up a preconfigured bottle (experimental)
    --ignore-version      # Disable version check for available bottles when using --download
    --crossover-app=<path to .app> # Specify app to skip interactive selection
    --crossover-bottle=<bottle name> # Specify bottle to skip interactive selection

    app_name?: string
]

# Download all cloud saves
export extern download-saves [
    --help(-h)  # show this help message and exit

    game?: string@"nu completion game name"
]

# Setup or run Epic Games Launcher sync
export extern egl-sync [
    --help(-h)            # show this help message and exit
    --egl-manifest-path=EGL_MANIFEST_PATH # Path to the Epic Games Launcher's Manifests folder, should point to /ProgramData/Epic/EpicGamesLauncher/Data/Manifests
    --egl-wine-prefix=EGL_WINE_PREFIX # Path to the WINE prefix the Epic Games Launcher is installed in
    --enable-sync         # Enable automatic EGL <-> Legendary sync
    --disable-sync        # Disable automatic sync and exit
    --one-shot            # Sync once, do not ask to setup automatic sync
    --import-only         # Only import games from EGL (no export)
    --export-only         # Only export games to EGL (no import)
    --migrate             # Import games into legendary, then remove them from EGL (implies --import-only --one-shot --unlink)
    --unlink              # Disable sync and remove EGL metadata from installed games
]

# ########  #######   ######      #######  ##     ## ######## ########  ##          ###    ##    ##
# ##       ##     ## ##    ##    ##     ## ##     ## ##       ##     ## ##         ## ##    ##  ##
# ##       ##     ## ##          ##     ## ##     ## ##       ##     ## ##        ##   ##    ####
# ######   ##     ##  ######     ##     ## ##     ## ######   ########  ##       ##     ##    ##
# ##       ##     ##       ##    ##     ##  ##   ##  ##       ##   ##   ##       #########    ##
# ##       ##     ## ##    ##    ##     ##   ## ##   ##       ##    ##  ##       ##     ##    ##
# ########  #######   ######      #######     ###    ######## ##     ## ######## ##     ##    ##

# Manage EOS Overlay install
export extern eos-overlay [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.
]

# install the overlay
export extern "eos-overlay install" [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.

]
# update the overlay
export extern "eos-overlay update" [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.

]
# remove the overlay
export extern "eos-overlay remove" [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.

]
# enable the overlay
export extern "eos-overlay enable" [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.

]
# disable the overlay
export extern "eos-overlay disable" [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.

]
# print info about the overlay
export extern "eos-overlay info" [
    --help(-h)            # show this help message and exit
    --path=PATH: path           # Path to the EOS overlay folder to be enabled/installed to.

]

# Import an already installed game
export extern import [
    --help(-h)            # show this help message and exit
    --disable-check       # Disables completeness check of the to-be-imported game installation (useful if the imported game is a much older version or missing files)
    --with-dlcs           # Automatically attempt to import all DLCs with the base game
    --skip-dlcs           # Do not ask about importing DLCs.
    --platform=<Platform>: string@"nu completion platform" # Platform for import (default: Mac on macOS, otherwise Windows)
]

# Prints info about specified app name or manifest
export extern info [
    --help(-h)            # show this help message and exit
    --offline             # Only print info available offline
    --json                # Output information in JSON format
    --platform=<Platform>: string@"nu completion platform" # Platform to fetch info for (default: installed or Mac on macOS, Windows otherwise)

    app_name_or_manifestURI: string@"nu completion game"
]

# Install/download/update/repair a game
export extern install [
    --help(-h)            # show this help message and exit
    --base-path=<path>: path    # Path for game installations (defaults to ~/Games)
    --game-folder=<path>: path  # Folder for game installation (defaults to folder specified in metadata)
    --max-shared-memory=<size>: int # Maximum amount of shared memory to use (in MiB), default: 1 GiB
    --max-workers=<num>: int   # Maximum amount of download workers, default: min(2 * CPUs, 16)
    --manifest=<uri>: string      # Manifest URL or path to use instead of the CDN one (e.g. for downgrading)
    --old-manifest=<uri>: string  # Manifest URL or path to use as the old one (e.g. for testing patching)
    --delta-manifest=<uri>: string # Manifest URL or path to use as the delta one (e.g. for testing)
    --base-url=<url>: string      # Base URL to download from (e.g. to test or switch to a different CDNs)
    --force               # Download all files / ignore existing (overwrite)
    --disable-patching    # Do not attempt to patch existing installation (download entire changed files)

    --download-only # Do not install app and do not run prerequisite installers after download
    --no-install # Do not install app and do not run prerequisite installers after download

    --update-only         # Only update, do not do anything if specified app is not installed
    --dlm-debug           # Set download manager and worker processes' loglevel to debug
    --platform=<Platform>: string@"nu completion platform" # Platform for install (default: installed or Windows)
    --prefix=<prefix>: string     # Only fetch files whose path starts with <prefix> (case insensitive)
    --exclude=<prefix>: string    # Exclude files starting with <prefix> (case insensitive)
    --install-tag=<tag>: string   # Only download files with the specified install tag
    --enable-reordering   # Enable reordering optimization to reduce RAM requirements during download (may have adverse results for some titles)
    --dl-timeout=<sec>: int    # Connection timeout for downloader (default: 10 seconds)
    --save-path=<path>: path    # Set save game path to be used for sync-saves
    --repair              # Repair installed game by checking and redownloading corrupted/missing files
    --repair-and-update   # Update game to the latest version when repairing
    --ignore-free-space   # Do not abort if not enough free space is available
    --disable-delta-manifests # Do not use delta manifests when updating (may increase download size)
    --reset-sdl           # Reset selective downloading choices (requires repair to download new components)
    --skip-sdl            # Skip SDL prompt and continue with defaults (only required game data)
    --disable-sdl         # Disable selective downloading for title, reset existing configuration (if any)
    --preferred-cdn=<hostname>: string # Set the hostname of the preferred CDN to use when available
    --no-https            # Download games via plaintext HTTP (like EGS), e.g. for use with a lan cache
    --with-dlcs           # Automatically install all DLCs with the base game
    --skip-dlcs           # Do not ask about installing DLCs.
    --bind=<IPs>: string          # Comma-separated list of IPs to bind to for downloading

    game: string@"nu completion game name"
]

export alias download = install
export alias repair = install
export alias update = install

# Launch a game
export extern launch [
    --help(-h)            # show this help message and exit
    --offline             # Skip login and launch game without online authentication
    --skip-version-check  # Skip version check when launching game in online mode
    --override-username=<username>: string # Override username used when launching the game (only works with some titles)
    --dry-run             # Print the command line that would have been used to launch the game and exit
    --language=<two letter language code>: string # Override language for game launch (defaults to system locale)
    --wrapper=<wrapper command>: string # Wrapper command to launch game with
    --set-defaults        # Save parameters used to launch to config (does not include env vars)
    --reset-defaults      # Reset config settings for app and exit
    --override-exe=<exe path>: path # Override executable to launch (relative path)
    --origin              # Launch Origin to activate or run the game.
    --json                # Print launch information as JSON and exit

    game: string@"nu completion installed game"
    ...args
]

# List available (installable) games
export extern list [
    --help(-h)            # show this help message and exit
    --platform=<Platform> # Platform to fetch game list for (default: Mac on macOS, otherwise Windows)
    --include-ue          # Also include Unreal Engine content (Engine/Marketplace) in list
    --third-party(-T),    # Include apps that are not installable (e.g. that have to be activated on Origin)
    --include-non-installable(-T) # Include apps that are not installable (e.g. that have to be activated on Origin)
    --csv                 # List games in CSV format
    --tsv                 # List games in TSV format
    --json                # List games in JSON format
    --force-refresh       # Force a refresh of all game metadata
]

# List files in manifest
export extern list-files [
    --help(-h)            # show this help message and exit
    --force-download      #     Always download instead of using on-disk manifest
    --platform=<Platform>: string@"nu completion platform" # Platform (default: Mac on macOS, otherwise Windows)
    --manifest=<uri>: string      # Manifest URL or path to use instead of the CDN one
    --csv                 # Output in CSV format
    --tsv                 # Output in TSV format
    --json                # Output in JSON format
    --hashlist            # Output file hash list in hashcheck/sha1sum -c compatible format
    --install-tag=<tag>   # Show only files with specified install tag

    game: string@"nu completion game"
]

# List installed games
export extern list-installed [
    --help(-h)       # show this help message and exit
    --check-updates  # Check for updates for installed games
    --csv            # List games in CSV format
    --tsv            # List games in TSV format
    --json           # List games in JSON format
    --show-dirs      # Print installation directory in output
]

# List available cloud saves
export extern list-saves [
    --help(-h)            # show this help message and exit

    game?: string@"nu completion game"
]

# Move specified app name to a new location
export extern move [
    --help(-h)       # show this help message and exit
    --skip-move      # Only change legendary database, do not move files (e.g. if already moved)

    game: string@"nu completion game" # Name of the app
    new_base_path: path # Directory to move game folder to
]

# Show legendary status information
export extern status [
    --help(-h)  # show this help message and exit
    --offline   # Only print offline status information, do not login
    --json      # Show status in JSON format
]

# Sync cloud saves
export extern sync-saves [
    --help(-h)          # show this help message and exit
    --skip-upload       # Only download new saves from cloud, don't upload
    --skip-download     # Only upload new saves from cloud, don't download
    --force-upload      # Force upload even if local saves are older
    --force-download    # Force download even if local saves are newer
    --save-path=<path>: path  # Override savegame path (requires single app name to be specified)
    --disable-filters   # Disable save game file filtering

    game?: string@"nu completion game"
]

# Uninstall (delete) a game
export extern uninstall [
    --help(-h)          # show this help message and exit
    --keep-files        # Keep files but remove game from Legendary database
    --skip-uninstaller  # Skip running the uninstaller

    game: string@"nu completion installed game"
]

# Verify a game's local files
export extern verify [
    --help(-h)  # show this help message and exit

    game: string@"nu completion game"
]


#  ######  ######## ########  ######  ########  ######

def "nu completion platform" [] {
    [Windows, Win32, Mac]
}

def "nu completion game name" [] {
    legendary list --json | from json | select app_name app_title | rename value description | str trim
}

def "nu completion alias" [] {
    legendary alias list | lines | skip | parse ' - {alias} => {game}' | rename value description | str trim
}

def "nu completion game" [] {
    nu completion game name | append (nu completion alias) | flatten
}

def "nu completion installed game" [] {
    legendary list-installed --json | from json | select app_name title | rename value description | str trim
}