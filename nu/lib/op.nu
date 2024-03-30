# 1Password CLI brings 1Password to your terminal.
export extern main [
    --account=account                                       # Select the account to execute the command by account shorthand, sign-in address, account ID, or user ID. For a list of available accounts, run 'op account list'. Can be set as the OP_ACCOUNT environment variable.
    --cache                                                 # Store and use cached information. Caching is enabled by default on UNIX-like systems. Caching is not available on Windows. Options: true, false. Can also be set with the OP_CACHE environment variable. (default true)
    --config=directory: path                                # Use this configuration directory.
    --debug                                                 # Enable debug mode. Can also be enabled by setting the OP_DEBUG environment variable to true.
    --encoding=type: string@"nu completion encoding"        # Use this character encoding type. Default: UTF-8. Supported: SHIFT_JIS, gbk.
    --format=string: string@"nu completion format"          # Use this output format. Can be 'human-readable' or 'json'. Can be set as the OP_FORMAT environment variable. (default "human-readable")
    --help(-h)                                              # Get help for op.
    --iso-timestamps                                        # Format timestamps according to ISO 8601 / RFC 3339. Can be set as the OP_ISO_TIMESTAMPS environment variable.
    --no-color                                              # Print output without color.
    --session=token                                         # Authenticate with this session token. 1Password CLI outputs session tokens for successful 'op signin' commands when 1Password app integration is not enabled.
    --version(-v)                                           # version for op
]

#   ##     ##    ###    ##    ##    ###     ######   ######## ##     ## ######## ##    ## ########     ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
#   ###   ###   ## ##   ###   ##   ## ##   ##    ##  ##       ###   ### ##       ###   ##    ##       ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
#   #### ####  ##   ##  ####  ##  ##   ##  ##        ##       #### #### ##       ####  ##    ##       ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
#   ## ### ## ##     ## ## ## ## ##     ## ##   #### ######   ## ### ## ######   ## ## ##    ##       ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
#   ##     ## ######### ##  #### ######### ##    ##  ##       ##     ## ##       ##  ####    ##       ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
#   ##     ## ##     ## ##   ### ##     ## ##    ##  ##       ##     ## ##       ##   ###    ##       ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
#   ##     ## ##     ## ##    ## ##     ##  ######   ######## ##     ## ######## ##    ##    ##        ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######

#                                                         dP
#                                                         88
# .d8888b. .d8888b. .d8888b. .d8888b. dP    dP 88d888b. d8888P
# 88'  `88 88'  `"" 88'  `"" 88'  `88 88    88 88'  `88   88
# 88.  .88 88.  ... 88.  ... 88.  .88 88.  .88 88    88   88
# `88888P8 `88888P' `88888P' `88888P' `88888P' dP    dP   dP



# Manage your locally configured 1Password accounts
export extern account [
    --help(-h)   # help for account
]

# Add an account to sign in to for the first time
export extern "account add" [
    --help(-h) help for add
    --address=string: string     # The sign-in address for your account.
    --email string               # The email address associated with your account.
    --raw                        # Only return the session token.
    --shorthand=string: string   # Set a custom account shorthand for your account.
    --signin                     # Immediately sign in to the added account.
]

# Get details about your account
export extern "account get" [
    --help(-h)                  # help for get
]

# List users and accounts set up on this device
export extern "account list" [
    --help(-h)                  # help for list
]

# Remove a 1Password account from this device
export extern "account forget" [
    --help(-h)                  # help for forget
    --all                       # Forget all authenticated accounts.

    account: string
]

#                                                         dP
#                                                         88
# .d8888b. .d8888b. 88d888b. 88d888b. .d8888b. .d8888b. d8888P
# 88'  `"" 88'  `88 88'  `88 88'  `88 88ooood8 88'  `""   88
# 88.  ... 88.  .88 88    88 88    88 88.  ... 88.  ...   88
# `88888P' `88888P' dP    dP dP    dP `88888P' `88888P'   dP



# Manage Connect server instances and tokens in your 1Password account
export extern connect [
    --help(-h)                  # help for connect
]

#                                   _
#                                  | |
#    ___ ___  _ __  _ __   ___  ___| |_    __ _ _ __ ___  _   _ _ __
#   / __/ _ \| '_ \| '_ \ / _ \/ __| __|  / _` | '__/ _ \| | | | '_ \
#  | (_| (_) | | | | | | |  __/ (__| |_  | (_| | | | (_) | |_| | |_) |
#   \___\___/|_| |_|_| |_|\___|\___|\__|  \__, |_|  \___/ \__,_| .__/
#                                          __/ |               | |
#                                         |___/                |_|

# Manage group access to Secrets Automation
export extern "connect group" [
    --help(-h)                  # help for group
]

# Grant a group access to manage Secrets Automation
export extern "connect group grant" [
    --help(-h)                                                      # help for grant
    --all-servers     # Grant access to all current and future servers in the authenticated account.
    --group=group: string@"nu completion group"     # The group to receive access.
    --server=server: string@"nu completion server"   # The server to grant access to.
]
# Revoke a group's access to manage Secrets Automation
export extern "connect group revoke" [
    --help(-h)                                                      # help for revoke
    --all-servers                                                   # Revoke access to all current and future servers in the authenticated account.
    --group=group: string@"nu completion group"                                                                  # The group to revoke access from.
    --server=server: string@"nu completion server"                                                                # The server to revoke access to.
]


#                                   _
#                                  | |
#    ___ ___  _ __  _ __   ___  ___| |_   ___  ___ _ ____   _____ _ __
#   / __/ _ \| '_ \| '_ \ / _ \/ __| __| / __|/ _ \ '__\ \ / / _ \ '__|
#  | (_| (_) | | | | | | |  __/ (__| |_  \__ \  __/ |   \ V /  __/ |
#   \___\___/|_| |_|_| |_|\___|\___|\__| |___/\___|_|    \_/ \___|_|



# Manage Connect servers
export extern "connect server" [
    --help(-h)                  # help for server
]

# Set up a Connect server
export extern "connect server create" [
    --force(-f)                             # Do not prompt for confirmation when overwriting credential files.
    --help(-h)                              # help for create
    --vaults=strings: string@"nu completion vault"                        # Grant the Connect server access to these vaults.

    name: string
]

# Get a Connect server
export extern "connect server get" [
    --help(-h)   # help for get

    server: string@"nu completion server" #  [{ <serverName> | <serverID> | - }]
]

# Rename a Connect server
export extern "connect server edit" [
    --help        # help for edit
    --name=name: string   # Change the server's name.

    server: string@"nu completion server" #  [{ <serverName> | <serverID> }
]


# Remove a Connect server
export extern "connect server delete" [
    --help(-h)   # help for delete

    server: string@"nu completion server" #  [{ <serverName> | <serverID> | - }]
]

alias "connect server rm" = connect server delete
alias "connect server remove" = connect server delete


# List Connect servers
export extern "connect server list" [
    --help(-h)   # help for list
]

alias "connect server ls" = connect server list



#                                   _     _        _
#                                  | |   | |      | |
#    ___ ___  _ __  _ __   ___  ___| |_  | |_ ___ | | _____ _ __
#   / __/ _ \| '_ \| '_ \ / _ \/ __| __| | __/ _ \| |/ / _ \ '_ \
#  | (_| (_) | | | | | | |  __/ (__| |_  | || (_) |   <  __/ | | |
#   \___\___/|_| |_|_| |_|\___|\___|\__|  \__\___/|_|\_\___|_| |_|

# Manage Connect server tokens
export extern "connect token" [
    --help(-h)                  # help for token
]

# Issue a token for a 1Password Connect server
export extern "connect token create" [
    --expires-in=duration: string@"nu completion duration"  # Set how long the Connect token is valid for in (s)econds, (m)inutes, (h)ours, (d)ays, and/or (w)eeks.
    --help(-h)                 # help for create
    --server=string: string                                 # Issue a token for this server.
    --vault=stringArray: string                             # Issue a token on these vaults.

    tokenName: string
]

# Rename a Connect server token
export extern "connect token edit" [
    --help(-h)            # help for edit
    --name=string: string  #   Change the token's name.
    --server=string: string@"nu completion server" #   Only look for tokens for this 1Password Connect server.

    token: string
]

# Revoke a token for a Connect server
export extern "connect token delete" [
    --help(-h)            # help for delete
    --server string: string@"nu completion server"   # Only look for tokens for this 1Password Connect server.

    token: string
]

alias "connect token rm" = connect token delete
alias "connect token remove" = connect token delete

# Get a list of tokens
export extern "connect token list" [
    --help(-h)            # help for list
    --server=server   # Only list tokens for this Connect server.
]

#                                   _                      _ _
#                                  | |                    | | |
#    ___ ___  _ __  _ __   ___  ___| |_  __   ____ _ _   _| | |_
#   / __/ _ \| '_ \| '_ \ / _ \/ __| __| \ \ / / _` | | | | | __|
#  | (_| (_) | | | | | | |  __/ (__| |_   \ V / (_| | |_| | | |_
#   \___\___/|_| |_|_| |_|\___|\___|\__|   \_/ \__,_|\__,_|_|\__|

# Manage Connect server vault access
export extern "connect vault" [
    --help(-h)                  # help for vault
]

# Grant a Connect server access to a vault
export extern "connect vault grant" [
    --help            # help for grant
    --server=string: string@"nu completion server"   # The server to be granted access.
    --vault=string: string@"nu completion vault"    # The vault to grant access to.
]
# Revoke a Connect server's access to a vault
export extern "connect vault revoke" [
    --help            # help for revoke
    --server=server: string@"nu completion server"   # The server to revoke access from.
    --vault=vault: string@"nu completion vault"     # The vault to revoke a server's access to.
]

#       dP                                                           dP
#       88                                                           88
# .d888b88 .d8888b. .d8888b. dP    dP 88d8b.d8b. .d8888b. 88d888b. d8888P
# 88'  `88 88'  `88 88'  `"" 88    88 88'`88'`88 88ooood8 88'  `88   88
# 88.  .88 88.  .88 88.  ... 88.  .88 88  88  88 88.  ... 88    88   88
# `88888P8 `88888P' `88888P' `88888P' dP  dP  dP `88888P' dP    dP   dP

# Perform CRUD operations on Document items in your vaults
export extern document [
    --help(-h)  # help for document
]

# Create a document item
export extern "document create" [
    --file-name=name: string   # Set the file's name.
    --help(-h)            # help for create
    --tags=tags: string@"nu completion tags"       # Set the tags to the specified (comma-separated) values.
    --title=title:  string      # Set the document item's title.
    --vault=vault: string@"nu completion vault"     # Save the document in this vault. Default: Private.

    file: string  # [{ <file> | - }]
]

# Download a document
export extern "document get" [
    --file-mode=filemode   # Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
    --force                # Forcibly print an unintelligible document to an interactive terminal. If --out-file is specified, save the document to a file without prompting for confirmation.
    --help                 # help for get
    --include-archive      # Include document items in the Archive. Can also be set using OP_INCLUDE_ARCHIVE environment variable.
    --out-file=path(-o): path        # Save the document to the file path instead of stdout.
    --vault=vault: string@"nu completion vault"          # Look for the document in this vault.

    item # { <itemName> | <itemID> }
]

# Edit a document item
export extern "document edit" [
    --file-name=name: string   # Set the file's name.
    --help(-h)             # help for edit
    --tags=tags: string@"nu completion tags"        # Set the tags to the specified (comma-separated) values. An empty value removes all tags.
    --title=title: string      # Set the document item's title.
    --vault=vault: string@"nu completion vault"      # Look up document in this vault.

    ...items # { <itemName> | <itemID> } [{ <file> | - }]
]

# Delete or archive a document item
export extern "document delete" [
    --archive       # Move the document to the Archive.
    --help(-h)          # help for delete
    --vault=vault: string@"nu completion vault"   # Delete the document in this vault.

    ...items # [{ <itemName> | <itemID> | - }]
]

alias "document rm" = document delete
alias "document remove" = document delete

# Get a list of documents
export extern "document list" [
    --help              # help for list
    --include-archive   # Include document items in the Archive. Can also be set using OP_INCLUDE_ARCHIVE environment variable.
    --vault=vault: string@"nu completion vault"       # Only list documents in this vault.
]

alias "document ls" = document list

#                                       dP                                       oo
#                                       88
# .d8888b. dP   .dP .d8888b. 88d888b. d8888P .d8888b.          .d8888b. 88d888b. dP
# 88ooood8 88   d8' 88ooood8 88'  `88   88   Y8ooooo. 88888888 88'  `88 88'  `88 88
# 88.  ... 88 .88'  88.  ... 88    88   88         88          88.  .88 88.  .88 88
# `88888P' 8888P'   `88888P' dP    dP   dP   `88888P'          `88888P8 88Y888P' dP
#                                                                       88
#                                                                       dP

# Manage Events API integrations in your 1Password connect
export extern events-api [
    --help(-h)   # help for events-api
]

# Create an Events API integration token.
export extern "events-api create" [
    --expires-in=duration: string@"nu completion duration"  # Set how the long the events-api token is valid for in (s)econds, (m)inutes, (h)ours, (d)ays, and/or (w)eeks.
    --features=features: string@"nu completion features"    # Set the comma-separated list of features the integration token can be used for. Options: 'signinattempts', 'itemusages', 'auditevents'.
    --help(-h)             # help for create

    name: string
]



# .d8888b. 88d888b. .d8888b. dP    dP 88d888b.
# 88'  `88 88'  `88 88'  `88 88    88 88'  `88
# 88.  .88 88       88.  .88 88.  .88 88.  .88
# `8888P88 dP       `88888P' `88888P' 88Y888P'
#      .88                            88
#  d8888P                             dP

# Manage the groups in your 1Password account
export extern group [
    --help(-h)   # help for group
]


# Create a group
export extern "group create" [
    --description=string: string   # Set the group's description.
    --help                 # help for create

    name: string
]

# Get details about a group
export extern "group get" [
    --help(-h)   # help for get

    ...groups # [{ <groupName> | <groupID> | - }]
]

# Edit a group's name or description
export extern "group edit" [
    --description=description: string   # Change the group's description.
    --help                      # help for edit
    --name=name: string                 # Change the group's name.

    ...groups # [{ <groupName> | <groupID> | - }]
]

# Remove a group
export extern "group delete" [
    --help(-h)   # help for delete

    ...groups # [{ <groupName> | <groupID> | - }]
]

alias "group rm" = group delete
alias "group remove" = group delete

# List groups
export extern "group list" [
    --help(-h)      # help for list
    --user=user: string@"nu completion user"     # List groups that a user belongs to.
    --vault=vault: string@"nu completion vault"   # List groups that have direct access to a vault.
]


#                                                                                        _                                                   _
#                                                                                       | |                                                 | |
#    __ _ _ __ ___  _   _ _ __    _ __ ___   __ _ _ __   __ _  __ _ _ __ ___   ___ _ __ | |_    ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
#   / _` | '__/ _ \| | | | '_ \  | '_ ` _ \ / _` | '_ \ / _` |/ _` | '_ ` _ \ / _ \ '_ \| __|  / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
#  | (_| | | | (_) | |_| | |_) | | | | | | | (_| | | | | (_| | (_| | | | | | |  __/ | | | |_  | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
#   \__, |_|  \___/ \__,_| .__/  |_| |_| |_|\__,_|_| |_|\__,_|\__, |_| |_| |_|\___|_| |_|\__|  \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
#    __/ |               | |                                   __/ |
#   |___/                |_|                                  |___/

#   _  _ ___ ___ _ _
#  | || (_-</ -_) '_|
#  \_,_/__/\___|_|


# Manage group membership
export extern "group user" [
    --help(-h)   # help for user
]

# Add a user to a group
export extern "group user grant" [
    --group=string: string@"nu completion group"   # Specify the group to add the user to.
    --help(-h)           # help for grant
    --role=string: string@"nu completion role"    # Specify the user's role as a member or manager. Default: member.
    --user=string: string@"nu completion user"    # Specify the user to add to the group.
]

# Remove a user from a group
export extern "group user revoke" [
    --group=string: string@"nu completion group"   # Specify the group to remove the user from.
    --help(-h)           # help for revoke
    --user=string: string@"nu completion user"    # Specify the user to remove from the group.
]

# Retrieve users that belong to a group
export extern "group user list" [
    --help(-h)   # help for list

    group: string@"nu completion group"
]

alias "group user ls" = group user list

# oo   dP
#      88
# dP d8888P .d8888b. 88d8b.d8b.
# 88   88   88ooood8 88'`88'`88
# 88   88   88.  ... 88  88  88
# dP   dP   `88888P' dP  dP  dP

# Perform CRUD operations on the 1Password items in your vaults
export extern item [
    --help(-h)   # help for item
]

# Create an item
export extern "item create" [
    --category=category: string@"nu completion category"                                           # Set the item's category.
    --dry-run                                         # Test the command and output a preview of the resulting item.
    --favorite                                        # Add item to favorites.
    --generate-password=recipe: string@"nu completion generate-password"                      # Add a randomly-generated password to a Login or Password item.
    --help(-h)                                        # help for create
    --ssh-generate-key: string@"nu completion ssh-generate-key"                                # The type of SSH key to create: Ed25519 or RSA. For RSA, specify 2048, 3072, or 4096 (default) bits. Possible values: 'ed25519', 'rsa', 'rsa2048', 'rsa3072', 'rsa4096'. (default Ed25519)
    --tags tags                                       # Set the tags to the specified (comma-separated) values.
    --template=string: string@"nu completion item-template"                                 # Specify the file path to read an item template from.
    --title=title: string                                     # Set the item's title.
    --url=URL: string                                         # Set the URL associated with the item
    --vault=vault: string@"nu completion vault"                                     # Save the item in this vault. Default: Private.

    ...assignments
]

# Get an item's details
export extern "item get" [
    --fields=strings: string    # Return data from specific fields. Use 'label=' to get the field by name or 'type=' to filter fields by type. Specify multiple in a comma-separated list.
    --help(-h)              # help for get
    --include-archive   # Include items in the Archive. Can also be set using OP_INCLUDE_ARCHIVE environment variable.
    --otp               # Output the primary one-time password for this item.
    --reveal            # Don't conceal the private SSH key when using human-readable output.
    --share-link        # Get a shareable link for the item.
    --vault=string: string@"nu completion vault"        # Look for the item in this vault.

    ...items # [{ <itemName> | <itemID> | <shareLink> | - }]
]

# Edit an item's details
export extern "item edit" [
    --dry-run                      # Perform a dry run of the command and output a preview of the resulting item.
    --favorite: string@"nu completion favourite"                      # Whether this item is a favorite item. Options: true, false
    --generate-password=recipe: string@"nu completion generate-password"   # Give the item a randomly generated password.
    --help(-h)                         # help for edit
    --tags=tags: string@"nu completion tags"                    # Set the tags to the specified (comma-separated) values. An empty value will remove all tags.
    --template string              # Specify the filepath to read an item template from.
    --title=title: string                  # Set the item's title.
    --url=URL: string                      # Set the URL associated with the item
    --vault=vault: string@"nu completion vault"                  # Edit the item in this vault.

    item    # { <itemName> | <itemID> | <shareLink> }
    ...assignments  # [ <assignment> ... ]
]

# Delete or archive an item
export extern "item delete" [
    --archive        # Move the item to the Archive.
    --help           # help for delete
    --vault string   # Look for the item in this vault.

    ...items    #  [{ <itemName> | <itemID> | <shareLink> | - }]
]

alias "item rm" = item delete
alias "item remove" = item delete

# List items
export extern "item list" [
    --categories=categories: string@"nu completion category"   # Only list items in these categories (comma-separated).
    --favorite                # Only list favorite items
    --help(-h)                # help for list
    --include-archive         # Include items in the Archive. Can also be set using OP_INCLUDE_ARCHIVE environment variable.
    --long                    # Output a more detailed item list.
    --tags=tags: string@"nu completion tags"               # Only list items with these tags (comma-separated).
    --vault=vault: string@"nu completion vault"             # Only list items in this vault.
]

alias "item ls" = item list

# Move an item between vaults
export extern "item move" [
    --current-vault=string: string@"nu completion vault"       # Vault where the item is currently saved.
    --destination-vault=string: string@"nu completion vault"   # The vault you want to move the item to.
    --help                       # help for move

    ...items    # [{ <itemName> | <itemID> | <shareLink> | - }]
]

alias "item mv" = item move

# Share an item
export extern "item share" [
    --emails=strings: string        # Email addresses to share with.
    --expires-in=duration: string@"nu completion duration"   # Expire link after the duration specified in (s)econds, (m)inutes, (h)ours, (d)ays, and/or (w)eeks. (default 7d)
    --help                  # help for share
    --vault=string: string@"nu completion vault"          # Look for the item in this vault.
    --view-once             # Expire link after a single view.
]

#   _ _                   __  __                                                   _      _____                                          _
#  (_) |                 |  \/  |                                                 | |    / ____|                                        | |
#   _| |_ ___ _ __ ___   | \  / | __ _ _ __   __ _  __ _  ___ _ __ ___   ___ _ __ | |_  | |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
#  | | __/ _ \ '_ ` _ \  | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '_ ` _ \ / _ \ '_ \| __| | |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
#  | | ||  __/ | | | | | | |  | | (_| | | | | (_| | (_| |  __/ | | | | |  __/ | | | |_  | |___| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
#  |_|\__\___|_| |_| |_| |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_| |_| |_|\___|_| |_|\__|  \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
#                                                   __/ |
#                                                  |___/

#   _                  _      _
#  | |_ ___ _ __  _ __| |__ _| |_ ___
#  |  _/ -_) '  \| '_ \ / _` |  _/ -_)
#   \__\___|_|_|_| .__/_\__,_|\__\___|
#                |_|

# Manage templates
export extern template [
    --help(-h)        # help for template
]

# Get an item template
export extern "item template get" [
    --file-mode=filemode       # Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
    --force(-f)                # Do not prompt for confirmation.
    --help(-h)                 # help for get
    --out-file(-o)=string: path      # Write the template to a file instead of stdout.

    ...category # [{ <category> | - }]
]

# Get a list of templates
export extern "item template list" [
    --help(-h)        # help for list
]

alias "item template ls" = item template list

#          dP                   oo
#          88
# 88d888b. 88 dP    dP .d8888b. dP 88d888b.
# 88'  `88 88 88    88 88'  `88 88 88'  `88
# 88.  .88 88 88.  .88 88.  .88 88 88    88
# 88Y888P' dP `88888P' `8888P88 dP dP    dP
# 88                        .88
# dP                    d8888P

# Manage the shell plugins you use to authenticate third-party CLIs
export extern plugin [
    --help(-h)        # help for plugin
]


# List all available shell plugins
export extern "plugin list" []

# Clear shell plugin configuration
export extern "plugin clear" []

# Configure a shell plugin
export extern "plugin init" [
    --help(-h)        # help for init

    executable: string # [ <plugin-executable> ]
]

# Inspect your existing shell plugin configurations
export extern "plugin inspect" []

# Provision credentials from 1Password and run this command
export extern "plugin run" []

#         _             _         __  __                                                   _      _____                                          _
#        | |           (_)       |  \/  |                                                 | |    / ____|                                        | |
#   _ __ | |_   _  __ _ _ _ __   | \  / | __ _ _ __   __ _  __ _  ___ _ __ ___   ___ _ __ | |_  | |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
#  | '_ \| | | | |/ _` | | '_ \  | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '_ ` _ \ / _ \ '_ \| __| | |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
#  | |_) | | |_| | (_| | | | | | | |  | | (_| | | | | (_| | (_| |  __/ | | | | |  __/ | | | |_  | |___| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
#  | .__/|_|\__,_|\__, |_|_| |_| |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_| |_| |_|\___|_| |_|\__|  \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
#  | |             __/ |                                    __/ |
#  |_|            |___/                                    |___/

# Manage credentials for shell plugins
export extern "plugin credential" []


# Manage service accounts
export extern service-account [

]

# Manage users within this 1Password account
export extern user [

]

# Manage permissions and perform CRUD operations on your 1Password vaults
export extern vault [

]


#    ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
#   ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
#   ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
#   ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
#   ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
#   ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
#    ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######

# Generate shell completion information
export extern completion [

]

# Inject secrets into a config file
export extern inject [

]

# Read a secret reference
export extern read [

]

# Pass secrets as environment variables to a process
export extern run [

]

# Sign in to a 1Password account
export extern signin [

]

# Sign out of a 1Password account
export extern signout [

]

# Check for and download updates.
export extern update [

]

# Get information about a signed-in account
export extern whoami [

]



#   ##    ## ##     ##     ######   #######  ##     ## ########  ##       ######## ######## ####  #######  ##    ##  ######
#   ###   ## ##     ##    ##    ## ##     ## ###   ### ##     ## ##       ##          ##     ##  ##     ## ###   ## ##    ##
#   ####  ## ##     ##    ##       ##     ## #### #### ##     ## ##       ##          ##     ##  ##     ## ####  ## ##
#   ## ## ## ##     ##    ##       ##     ## ## ### ## ########  ##       ######      ##     ##  ##     ## ## ## ##  ######
#   ##  #### ##     ##    ##       ##     ## ##     ## ##        ##       ##          ##     ##  ##     ## ##  ####       ##
#   ##   ### ##     ##    ##    ## ##     ## ##     ## ##        ##       ##          ##     ##  ##     ## ##   ### ##    ##
#   ##    ##  #######      ######   #######  ##     ## ##        ######## ########    ##    ####  #######  ##    ##  ######

def "nu completion format" [] {
    [
        json
        human-readable
    ]
}

def "nu completion encoding" [] {
    [
        UTF-8
        SHIFT_JIS
        gbk
    ]
}