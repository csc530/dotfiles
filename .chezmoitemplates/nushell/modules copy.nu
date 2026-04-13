# source $'($NU_SCRIPTS)/themes/nu-themes/catppuccin-macchiato.nu'

use system
# because nupm git is here too🙄
use nupm/nupm
use random.nu
use ~/.config/nushell/ledger.nu

# my extern completers
use hledger.nu
use op.nu
use fakedata.nu
use legendary.nu
use komorebic.nu
use pipes-rs.nu
use swww.nu

# my modules
use sys

# scripts/
use yazi.nu *

use $'($NU_SCRIPTS)/sourced/misc/password_generator/nupass.nu'
# use jobapp.nu

source $'($NU_SCRIPTS)/custom-completions/btm/btm-completions.nu'
source $'($NU_SCRIPTS)/custom-completions/typst/typst-completions.nu'
source $'($NU_SCRIPTS)/custom-completions/scoop/scoop-completions.nu'
if ((sys host| get name) == 'Windows') {
	source $'($NU_SCRIPTS)/custom-completions/winget/winget-completions.nu'
} else if ((sys host| get name) == 'Linux') {
	# source $'hypr-completions.nu'
}

source $'($NU_SCRIPTS)/sourced/fun/spark.nu'
source $'($NU_SCRIPTS)/modules/formats/from-env.nu'
source $'($NU_SCRIPTS)/modules/formats/to-ini.nu'
source $'($NU_SCRIPTS)/modules/formats/to-number-format.nu'
