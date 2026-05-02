# source $'($NU_SCRIPTS_PATH)/themes/nu-themes/catppuccin-macchiato.nu'

use system
# because nupm git is here too🙄
# use nupm/nupm
use random.nu
use ./ledger.nu

# my extern completers
use hledger.nu
use op.nu
use fakedata.nu
use legendary.nu
use komorebic.nu
use pipes-rs.nu

# my modules
use sys

# scripts/
use yazi.nu *

use $'($NU_SCRIPTS_PATH)/sourced/misc/password_generator/nupass.nu'
# use jobapp.nu

source $'($NU_SCRIPTS_PATH)/custom-completions/btm/btm-completions.nu'
source $'($NU_SCRIPTS_PATH)/custom-completions/typst/typst-completions.nu'

match (sys host| get name) {
	'Windows' => {
		source $'($NU_SCRIPTS_PATH)/custom-completions/scoop/scoop-completions.nu'
		source $'($NU_SCRIPTS_PATH)/custom-completions/winget/winget-completions.nu'
		},
		'Linux' => {
			use swww.nu
		# source $'($NU_SCRIPTS_PATH)/custom-completions/hypr/hypr-completions.nu'
	},
	'Darwin' => ()
}

source $'($NU_SCRIPTS_PATH)/sourced/fun/spark.nu'
source $'($NU_SCRIPTS_PATH)/modules/formats/from-env.nu'
source $'($NU_SCRIPTS_PATH)/modules/formats/to-ini.nu'
source $'($NU_SCRIPTS_PATH)/modules/formats/to-number-format.nu'
