# The command-line interface for Komorebi, a tiling window manager for Windows
export extern main [
    --help(-h)     # Print help
    --version(-V)  # Print version
]


# Gather example configurations for a new-user quickstart
export extern quickstart [
    --help(-h)     # Print help
]

# Start komorebi.exe as a background process
export extern start [
    --help(-h)     # Print help
    --ffm(-f)                  # Allow the use of komorebi's custom focus-follows-mouse implementation
    --config(-c)=<CONFIG>: path      # Path to a static configuration JSON file
    --await-configuration(-a)  # Wait for 'komorebic complete-configuration' to be sent before processing events
    --tcp-port(-t)=<TCP_PORT>: int  # Start a TCP server on the given port to allow the direct sending of SocketMessages
    --whkd                 # Start whkd in a background process
    --ahk                  # Start autohotkey configuration file
]

# Stop the komorebi.exe process and restore all hidden windows
export extern stop [
    --help(-h)     # Print help
    --whkd  # Stop whkd if it is running as a background process
]

# Check komorebi configuration and related files for common errors
export extern check [
    --help(-h)     # Print help
]

# Show the path to komorebi.json
export extern configuration [
    --help(-h)     # Print help
]

# Show the path to whkdrc
export extern whkdrc [
    --help(-h)     # Print help
]
export alias whkd = whkdrc

# Show a JSON representation of the current window manager state
export extern state [
    --help(-h)     # Print help
]

# Show a JSON representation of visible windows
export extern visible-windows [
    --help(-h)     # Print help
]

# Query the current window manager state
export extern query [
    --help(-h)     # Print help

    STATE_QUERY: string@"state query" # [possible values: focused-monitor-index, focused-workspace-index, focused-container-index, focused-window-index]
]

# Subscribe to komorebi events using a Unix Domain Socket
export extern subscribe-socket [
    --help(-h)     # Print help

    SOCKET: string  # Name of the socket to send event notifications to
]

# Unsubscribe from komorebi events
export extern unsubscribe-socket [
    --help(-h)     # Print help

    SOCKET  # Name of the socket to stop sending event notifications to
]

# Subscribe to komorebi events using a Named Pipe
export extern subscribe-pipe [
    --help(-h)     # Print help
    NAMED_PIPE: string # Name of the pipe to send event notifications to (without "\\.\pipe\" prepended)
]
export alias subscribe = subscribe-pipe

# Unsubscribe from komorebi events
export extern unsubscribe-pipe [
    --help(-h)     # Print help

    NAMED_PIPE: string # Name of the pipe to stop sending event notifications to (without "\\.\pipe\" prepended)
]
export alias unsubscribe = unsubscribe-pipe

# Tail komorebi.exe's process logs (cancel with Ctrl-C)
export extern log [
    --help(-h)     # Print help
]

# Quicksave the current resize layout dimensions
export extern quick-save-resize [
    --help(-h)     # Print help
]
export alias quick-save = quick-save-resize

# Load the last quicksaved resize layout dimensions
export extern quick-load-resize [
    --help(-h)     # Print help
]
export alias quick-load = quick-load-resize

# Save the current resize layout dimensions to a file
export extern save-resize [
    --help(-h)     # Print help

    PATH: path # File to which the resize layout dimensions should be saved
]
export alias save = save-resize

# Load the resize layout dimensions from a file
export extern load-resize [
    --help(-h)     # Print help

    PATH: path # File from which the resize layout dimensions should be loaded
]
export alias load = load-resize

# Change focus to the window in the specified direction
export extern focus [
    --help(-h)     # Print help

    OPERATION_DIRECTION: string@"operation direction" # [possible values: left, right, up, down]
]

# Move the focused window in the specified direction
export extern move [
    --help(-h)     # Print help

    OPERATION_DIRECTION: string@"operation direction" # [possible values: left, right, up, down]
]

# Minimize the focused window
export extern minimize [
    --help(-h)     # Print help
]

# Close the focused window
export extern close [
    --help(-h)     # Print help
]

# Forcibly focus the window at the cursor with a left mouse click
export extern force-focus [
    --help(-h)     # Print help
]

# Change focus to the window in the specified cycle direction
export extern cycle-focus [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Move the focused window in the specified cycle direction
export extern cycle-move [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Stack the focused window in the specified direction
export extern stack [
    --help(-h)     # Print help

    OPERATION_DIRECTION: string@"operation direction" # [possible values: left, right, up, down]
]

# Resize the focused window in the specified direction
export extern resize-edge [
    --help(-h)     # Print help

    EDGE: string@"operation direction" # [possible values: left, right, up, down]
    SIZING: string@"sizing" # [possible values: increase, decrease]
]
export alias resize = resize-edge

# Resize the focused window or primary column along the specified axis
export extern resize-axis [
    --help(-h)     # Print help

    AXIS: string@"axis" # [possible values: horizontal, vertical, horizontal-and-vertical]
    SIZING: string@"sizing" # [possible values: increase, decrease]
]

# Unstack the focused window
export extern unstack [
    --help(-h)     # Print help
]

# Cycle the focused stack in the specified cycle direction
export extern cycle-stack [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Move the focused window to the specified monitor
export extern move-to-monitor [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Move the focused window to the monitor in the given cycle direction
export extern cycle-move-to-monitor [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" #  [possible values: previous, next]
]

# Move the focused window to the specified workspace
export extern move-to-workspace [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Move the focused window to the specified workspace
export extern move-to-named-workspace [
    --help(-h)     # Print help

    WORKSPACE: string # Target workspace name
]

# Move the focused window to the workspace in the given cycle direction
export extern cycle-move-to-workspace [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Send the focused window to the specified monitor
export extern send-to-monitor [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Send the focused window to the monitor in the given cycle direction
export extern cycle-send-to-monitor [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Send the focused window to the specified workspace
export extern send-to-workspace [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Send the focused window to the specified workspace
export extern send-to-named-workspace [
    --help(-h)     # Print help

    WORKSPACE: string # Target workspace name
]

# Send the focused window to the workspace in the given cycle direction
export extern cycle-send-to-workspace [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Send the focused window to the specified monitor workspace
export extern send-to-monitor-workspace [
    --help(-h)     # Print help

    TARGET_MONITOR: int # Target monitor index (zero-indexed)
    TARGET_WORKSPACE: int # Workspace index on the target monitor (zero-indexed)
]

# Focus the specified monitor
export extern focus-monitor [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Focus the last focused workspace on the focused monitor
export extern focus-last-workspace [
    --help(-h)     # Print help
]

# Focus the specified workspace on the focused monitor
export extern focus-workspace [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Focus the specified workspace on all monitors
export extern focus-workspaces [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Focus the specified workspace on the target monitor
export extern focus-monitor-workspace [
    --help(-h)     # Print help

    TARGET_MONITOR: int # Target monitor index (zero-indexed)
    TARGET_WORKSPACE: int # Workspace index on the target monitor (zero-indexed)
]

# Focus the specified workspace
export extern focus-named-workspace [
    --help(-h)     # Print help

    WORKSPACE: string # Target workspace name
]

# Focus the monitor in the given cycle direction
export extern cycle-monitor [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Focus the workspace in the given cycle direction
export extern cycle-workspace [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Move the focused workspace to the specified monitor
export extern move-workspace-to-monitor [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Swap focused monitor workspaces with specified monitor
export extern swap-workspaces-with-monitor [
    --help(-h)     # Print help

    TARGET: int # Target index (zero-indexed)
]

# Create and append a new workspace on the focused monitor
export extern new-workspace [
    --help(-h)     # Print help
]

# Set the resize delta (used by resize-edge and resize-axis)
export extern resize-delta [
    --help(-h)     # Print help

    PIXELS: int # The delta of pixels by which to increase or decrease window dimensions when resizing
]

# Set the invisible border dimensions around each window
export extern invisible-borders [
    --help(-h)     # Print help

    LEFT: int # Size of the left invisible border
    TOP: int # Size of the top invisible border (usually 0)
    RIGHT: int # Size of the right invisible border (usually left * 2)
    BOTTOM: int # Size of the bottom invisible border (usually the same as left)
]

# Set offsets to exclude parts of the work area from tiling
export extern global-work-area-offset [
    --help(-h)     # Print help

    LEFT: int # Size of the left work area offset (set right to left * 2 to maintain right padding)
    TOP: int # Size of the top work area offset (set bottom to the same value to maintain bottom padding)
    RIGHT: int # Size of the right work area offset
    BOTTOM: int # Size of the bottom work area offset
]

# Set offsets for a monitor to exclude parts of the work area from tiling
export extern monitor-work-area-offset [
    --help(-h)     # Print help

    MONITOR: int # Monitor index (zero-indexed)
    LEFT: int # Size of the left work area offset (set right to left * 2 to maintain right padding)
    TOP: int # Size of the top work area offset (set bottom to the same value to maintain bottom padding)
    RIGHT: int # Size of the right work area offset
    BOTTOM: int # Size of the bottom work area offset
]

# Set container padding on the focused workspace
export extern focused-workspace-container-padding [
    --help(-h)     # Print help

    SIZE: int # Pixels size to set as an integer
]

# Set workspace padding on the focused workspace
export extern focused-workspace-padding [
    --help(-h)     # Print help

    SIZE: int # Pixels size to set as an integer
]

# Adjust container padding on the focused workspace
export extern adjust-container-padding [
    --help(-h)     # Print help

    SIZING: string@"sizing" # [possible values: increase, decrease]
    ADJUSTMENT: int # Pixels to adjust by as an integer
]

# Adjust workspace padding on the focused workspace
export extern adjust-workspace-padding [
    --help(-h)     # Print help

    SIZING: string@"sizing" # [possible values: increase, decrease]
    ADJUSTMENT: int # Pixels to adjust by as an integer
]

# Set the layout on the focused workspace
export extern change-layout [
    --help(-h)     # Print help

    DEFAULT_LAYOUT: string@"layout" # [possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack, grid]
]

# Cycle between available layouts
export extern cycle-layout [
    --help(-h)     # Print help

    CYCLE_DIRECTION: string@"cycle direction" # [possible values: previous, next]
]

# Load a custom layout from file for the focused workspace
export extern load-custom-layout [
    --help(-h)     # Print help

    PATH: path # JSON or YAML file from which the custom layout definition should be loaded
]

# Flip the layout on the focused workspace (BSP only)
export extern flip-layout [
    --help(-h)     # Print help

    AXIS: string@"axis" # [possible values: horizontal, vertical, horizontal-and-vertical]
]

# Promote the focused window to the top of the tree
export extern promote [
    --help(-h)     # Print help
]

# Promote the user focus to the top of the tree
export extern promote-focus [
    --help(-h)     # Print help
]

# Force the retiling of all managed windows
export extern retile [
    --help(-h)     # Print help
]

# Set the monitor index preference for a monitor identified using its size
export extern monitor-index-preference [
    --help(-h)     # Print help

    INDEX_PREFERENCE: int  # Preferred monitor index (zero-indexed)
    LEFT: int              # Left value of the monitor's size Rect
    TOP: int               # Top value of the monitor's size Rect
    RIGHT: int             # Right value of the monitor's size Rect
    BOTTOM: int            # Bottom value of the monitor's size Rect
]

# Set the display index preference for a monitor identified using its display name
export extern display-index-preference [
    --help(-h)     # Print help

    INDEX_PREFERENCE: int  # Preferred monitor index (zero-indexed)
    DISPLAY: string           # Display name as identified in komorebic state
]

# Create at least this many workspaces for the specified monitor
export extern ensure-workspaces [
    --help(-h)     # Print help

    MONITOR: int          # Monitor index (zero-indexed)
    WORKSPACE_COUNT: int  # Number of desired workspaces
]

# Create these many named workspaces for the specified monitor
export extern ensure-named-workspaces [
    --help(-h)     # Print help

    MONITOR: int        # Monitor index (zero-indexed)
    ...NAMES: string    # Names of desired workspaces
]

# Set the container padding for the specified workspace
export extern container-padding [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
    SIZE: int       # Pixels to pad with as an integer
]

# Set the container padding for the specified workspace
export extern named-workspace-container-padding [
    --help(-h)     # Print help

    WORKSPACE: string  # Target workspace name
    SIZE: int       # Pixels to pad with as an integer
]

# Set the workspace padding for the specified workspace
export extern workspace-padding [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
    SIZE: int       # Pixels to pad with as an integer
]

# Set the workspace padding for the specified workspace
export extern named-workspace-padding [
    --help(-h)     # Print help

    WORKSPACE: string  # Target workspace name
    SIZE: int       # Pixels to pad with as an integer
]

# Set the layout for the specified workspace
export extern workspace-layout [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
    VALUE: string@"layout"      # [ possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack, grid]
]

# Set the layout for the specified workspace
export extern named-workspace-layout [
    --help(-h)     # Print help

    WORKSPACE: string # Target workspace name
    VALUE: string@"layout"      # [possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack, grid]
]

# Set a custom layout for the specified workspace
export extern workspace-custom-layout [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
    PATH: path       # JSON or YAML file from which the custom layout definition should be loaded
]

# Set a custom layout for the specified workspace
export extern named-workspace-custom-layout [
    --help(-h)     # Print help

    WORKSPACE: string # Target workspace name
    PATH: path       # JSON or YAML file from which the custom layout definition should be loaded
]

# Add a dynamic layout rule for the specified workspace
export extern workspace-layout-rule [
    --help(-h)     # Print help

    MONITOR: int             # Monitor index (zero-indexed)
    WORKSPACE: int           # Workspace index on the specified monitor (zero-indexed)
    AT_CONTAINER_COUNT: int  # The number of window containers on-screen required to trigger this layout rule
    LAYOUT: string@"layout"              # [possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack, grid]
]

# Add a dynamic layout rule for the specified workspace
export extern named-workspace-layout-rule [
    --help(-h)     # Print help

    WORKSPACE: string           # Target workspace name
    AT_CONTAINER_COUNT: int  # The number of window containers on-screen required to trigger this layout rule
    LAYOUT: string@layout              # [possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack, grid]
]

# Add a dynamic custom layout for the specified workspace
export extern workspace-custom-layout-rule [
    --help(-h)     # Print help

    MONITOR: int             # Monitor index (zero-indexed)
    WORKSPACE: int           # Workspace index on the specified monitor (zero-indexed)
    AT_CONTAINER_COUNT: int  # The number of window containers on-screen required to trigger this layout rule
    PATH: path                # JSON or YAML file from which the custom layout definition should be loaded
]

# Add a dynamic custom layout for the specified workspace
export extern named-workspace-custom-layout-rule [
    --help(-h)     # Print help

    WORKSPACE: string           # Target workspace name
    AT_CONTAINER_COUNT: int  # The number of window containers on-screen required to trigger this layout rule
    PATH: path                # JSON or YAML file from which the custom layout definition should be loaded
]

# Clear all dynamic layout rules for the specified workspace
export extern clear-workspace-layout-rules [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
]

# Clear all dynamic layout rules for the specified workspace
export extern clear-named-workspace-layout-rules [
    --help(-h)     # Print help

    WORKSPACE: string  # Target workspace name
]

# Enable or disable window tiling for the specified workspace
export extern workspace-tiling [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
    VALUE: string@"activated"      # [possible values: enable, disable]
]

# Enable or disable window tiling for the specified workspace
export extern named-workspace-tiling [
    --help(-h)     # Print help

    WORKSPACE: string  # Target workspace name
    VALUE: string@activated      # [possible values: enable, disable]
]

# Set the workspace name for the specified workspace
export extern workspace-name [
    --help(-h)     # Print help

    MONITOR: int    # Monitor index (zero-indexed)
    WORKSPACE: int  # Workspace index on the specified monitor (zero-indexed)
    VALUE: string      # Name of the workspace as a String
]

# Toggle the behaviour for new windows (stacking or dynamic tiling)
export extern toggle-window-container-behaviour [
    --help(-h)     # Print help
]

# Toggle window tiling on the focused workspace
export extern toggle-pause [
    --help(-h)     # Print help
]

# Toggle window tiling on the focused workspace
export extern toggle-tiling [
    --help(-h)     # Print help
]

# Toggle floating mode for the focused window
export extern toggle-float [
    --help(-h)     # Print help
]

# Toggle monocle mode for the focused container
export extern toggle-monocle [
    --help(-h)     # Print help
]

# Toggle native maximization for the focused window
export extern toggle-maximize [
    --help(-h)     # Print help
]

# Restore all hidden windows (debugging command)
export extern restore-windows [
    --help(-h)     # Print help
]

# Force komorebi to manage the focused window
export extern manage [
    --help(-h)     # Print help
]

# Unmanage a window that was forcibly managed
export extern unmanage [
    --help(-h)     # Print help
]

# Reload ~/komorebi.ahk (if it exists)
export extern reload-configuration [
    --help(-h)     # Print help
]

# Enable or disable watching of ~/komorebi.ahk (if it exists)
export extern watch-configuration [
    --help(-h)     # Print help

    BOOLEAN_STATE: string@"activated" # [possible values: enable, disable]
]

# Signal that the final configuration option has been sent
export extern complete-configuration [
    --help(-h)     # Print help
]

# Set the window behaviour when switching workspaces / cycling stacks
export extern window-hiding-behaviour [
    --help(-h)     # Print help

    HIDING_BEHAVIOUR: string@"hide behaviour" # [possible values: hide, minimize, cloak]
]

# Set the behaviour when moving windows across monitor boundaries
export extern cross-monitor-move-behaviour [
    --help(-h)     # Print help

    MOVE_BEHAVIOUR: string@"move behaviour" # [possible values: swap, insert]
]

# Toggle the behaviour when moving windows across monitor boundaries
export extern toggle-cross-monitor-move-behaviour [
    --help(-h)     # Print help
]

# Set the operation behaviour when the focused window is not managed
export extern unmanaged-window-operation-behaviour [
    --help(-h)     # Print help

    OPERATION_BEHAVIOUR: string@"operation behaviour" # [possible values: op, no-op]
]

# Add a rule to always float the specified application
export extern float-rule [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier" # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
]

# Add a rule to always manage the specified application
export extern manage-rule [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
]

# Add a rule to associate an application with a workspace on first show
export extern initial-workspace-rule [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
    MONITOR: int     # Monitor index (zero-indexed)
    WORKSPACE: int   # Workspace index on the specified monitor (zero-indexed)
]

# Add a rule to associate an application with a named workspace on first show
export extern initial-named-workspace-rule [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
    WORKSPACE: string   # Name of a workspace
]
# Add a rule to associate an application with a workspace
export extern workspace-rule [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
    MONITOR: int     # Monitor index (zero-indexed)
    WORKSPACE: int   # Workspace index on the specified monitor (zero-indexed)
]

# Add a rule to associate an application with a named workspace
export extern named-workspace-rule [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
    WORKSPACE: string   # Name of a workspace
]

# Identify an application that sends EVENT_OBJECT_NAMECHANGE on launch
export extern identify-object-name-change-application [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
]

# Identify an application that closes to the system tray
export extern identify-tray-application [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
]

# Identify an application that has WS_EX_LAYERED, but should still be managed
export extern identify-layered-application [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
]

# Whitelist an application for title bar removal
export extern remove-title-bar [
    --help(-h)     # Print help

    IDENTIFIER: string@"identifier"  # [possible values: exe, class, title, path]
    ID: string          # Identifier as a string
]

# Toggle title bars for whitelisted applications
export extern toggle-title-bars [
    --help(-h)     # Print help
]

# Enable or disable the active window border
export extern active-window-border [
    --help(-h)     # Print help

    BOOLEAN_STATE: string@"activated" # [possible values: enable, disable]
]

# Set the colour for the active window border
export extern active-window-border-colour [
    --help(-h)     # Print help
    --window-kind(-w)=<WINDOW_KIND>: string@"window kind" # [default: single] [possible values: single, stack, monocle]

    R: int # Red
    G: int # Green
    B: int # Blue
]

# Set the width for the active window border
export extern active-window-border-width [
    --help(-h)     # Print help

    WIDTH: int # Desired width of the active window border
]

# Set the offset for the active window border
export extern active-window-border-offset [
    --help(-h)     # Print help

    OFFSET: int # Desired offset of the active window border
]

# Enable or disable focus follows mouse for the operating system
export extern focus-follows-mouse [
    --help(-h)     # Print help
    --implementation(-i)=<IMPLEMENTATION>: string@"implementation" # [default: windows] [possible values: komorebi, windows]

    BOOLEAN_STATE: string@"activated" # [possible values: enable, disable]
]

# Toggle focus follows mouse for the operating system
export extern toggle-focus-follows-mouse [
    --help(-h)     # Print help
    --implementation(-i)=<IMPLEMENTATION>: string@"implementation" # [default: windows] [possible values: komorebi, windows]
]

# Enable or disable mouse follows focus on all workspaces
export extern mouse-follows-focus [
    --help(-h)     # Print help

    BOOLEAN_STATE: string@"activated" # [possible values: enable, disable]
]


# Toggle mouse follows focus on all workspaces
export extern toggle-mouse-follows-focus [
    --help(-h)     # Print help
]

# Generate a library of AutoHotKey helper functions
export extern ahk-library [
    --help(-h)     # Print help
]

# Generate common app-specific configurations and fixes to use in komorebi.ahk
export extern ahk-app-specific-configuration [
    --help(-h)     # Print help

    PATH: path           # YAML file from which the application-specific configurations should be loaded
    OVERRIDE_PATH?: path # Optional YAML file of overrides to apply over the first file
]

# Generate common app-specific configurations and fixes in a PowerShell script
export extern pwsh-app-specific-configuration [
    --help(-h)     # Print help

    PATH: path           # YAML file from which the application-specific configurations should be loaded
    OVERRIDE_PATH?: path # Optional YAML file of overrides to apply over the first file
]

# Format a YAML file for use with the 'ahk-app-specific-configuration' command
export extern format-app-specific-configuration [
    --help(-h)     # Print help

    PATH: path           # YAML file from which the application-specific configurations should be loaded
]

# Fetch the latest version of applications.yaml from komorebi-application-specific-configuration
export extern fetch-app-specific-configuration [
    --help(-h)     # Print help
]

# Generate a JSON Schema for applications.yaml
export extern application-specific-configuration-schema [
    --help(-h)     # Print help
]

# Generate a JSON Schema of subscription notifications
export extern notification-schema [
    --help(-h)     # Print help
]

# Generate a JSON Schema of socket messages
export extern socket-schema [
    --help(-h)     # Print help
]

# Generate a JSON Schema of the static configuration file
export extern static-config-schema [
    --help(-h)     # Print help
]

# Generates a static configuration JSON file based on the current window manager state
export extern generate-static-config [
    --help(-h)     # Print help
]

# Generates the komorebi.lnk shortcut in shell:startup to autostart komorebi
export extern enable-autostart [
    --help(-h)     # Print help
    --config(-c)=<CONFIG>: path  # Path to a static configuration JSON file
    --ffm(-f)              # Enable komorebi's custom focus-follows-mouse implementation
    --whkd             # Enable autostart of whkd
    --ahk              # Enable autostart of ahk
]

# Deletes the komorebi.lnk shortcut in shell:startup to disable autostart
export extern disable-autostart [
    --help(-h)     # Print help
]

# Print this message or the help of the given subcommand(s)
export extern help []


# -------------------------------------

def "window kind" [] {
    [single, stack, monocle]
}

def "implementation" [] {
    [komorebi, windows]
}

def "activated" [] {
    [enable, disable]
}

def "identifier" [] {
    [exe, class, title, path]
}

def "hide behaviour" [] {
    [hide, minimize, cloak]
}

def "window state" [] {
    [maximized, fullscreen, hidden]
}

def "operation direction" [] {
    [left, right, up, down]
}

def "cycle direction" [] {
    [previous, next]
}

def "operation behaviour" [] {
    [op, no-op]
}

def layout [] {
    [bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack, grid]
}

def "move behaviour" [] {
    [swap, insert]
}

def axis [] {
    [horizontal, vertical, horizontal-and-vertical]
}

def sizing [] {
    [increase, decrease]
}

def "state query" [] {
    [focused-monitor-index, focused-workspace-index, focused-container-index, focused-window-index]
}