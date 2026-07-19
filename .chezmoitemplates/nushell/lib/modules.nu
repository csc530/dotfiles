source ./sys/mod.nu

# carapace
source ($nu.cache-dir)/carapace.nu
source ($nu.cache-dir)/zoxide.nu
source ($nu.cache-dir)/mise.nu

source ($nu.default-config-dir)/nu_scripts/themes/nu-themes/catppuccin-macchiato.nu

use system
use random.nu

# my extern completers
use hledger.nu
use op.nu
# use fakedata.nu
# use legendary.nu
use komorebic.nu
use pipes-rs.nu
# use swww.nu

# my modules
use sys

## cmd helpers & wrappers
use yazi.nu *

use ($nu.default-config-dir)/nu_scripts/sourced/misc/password_generator/nupass.nu
# use jobapp.nu

# completions
# source ($nu.default-config-dir)/completers/main.nu
## nu_scripts custom completers
source ($nu.default-config-dir)/nu_scripts/custom-completions/btm/btm-completions.nu
source ($nu.default-config-dir)/nu_scripts/custom-completions/typst/typst-completions.nu
if ((sys host| get name) == 'Windows') {
    source ($nu.default-config-dir)/nu_scripts/custom-completions/scoop/scoop-completions.nu
	source ($nu.default-config-dir)/nu_scripts/custom-completions/winget/winget-completions.nu
} else if ((sys host| get name) == 'Linux') {
	# source $'hypr-completions.nu'
}

source ($nu.default-config-dir)/nu_scripts/sourced/fun/spark.nu
source ($nu.default-config-dir)/nu_scripts/modules/formats/from-env.nu
source ($nu.default-config-dir)/nu_scripts/modules/formats/to-ini.nu
source ($nu.default-config-dir)/nu_scripts/modules/formats/to-number-format.nu

source ./aliases.nu
