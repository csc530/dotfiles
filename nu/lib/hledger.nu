# Fast, friendly, robust plain text accounting software
export extern main [
    --help(-h) # Display the help message for this command
    --version # show version information
]

# hledger User Manuals
export extern help [
    topic?: string@help_topics # The topic to display the manual for
    --help(-h) # Display the help message for this command
    -i         # show the manual with info
    -m # show the manual with man
    -p  # show the manual with $PAGER or less
]

# ######## ##    ## ######## ######## ########  #### ##    ##  ######      ########     ###    ########    ###
# ##       ###   ##    ##    ##       ##     ##  ##  ###   ## ##    ##     ##     ##   ## ##      ##      ## ##
# ##       ####  ##    ##    ##       ##     ##  ##  ####  ## ##           ##     ##  ##   ##     ##     ##   ##
# ######   ## ## ##    ##    ######   ########   ##  ## ## ## ##   ####    ##     ## ##     ##    ##    ##     ##
# ##       ##  ####    ##    ##       ##   ##    ##  ##  #### ##    ##     ##     ## #########    ##    #########
# ##       ##   ###    ##    ##       ##    ##   ##  ##   ### ##    ##     ##     ## ##     ##    ##    ##     ##
# ######## ##    ##    ##    ######## ##     ## #### ##    ##  ######      ########  ##     ##    ##    ##     ##

# add or edit transactions, updating the journal file

# add transactions using terminal prompts
export extern add [
    # General flags:
    --file(-f)=FILE                         # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE                      # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                         # rename accounts named OLD to NEW
    --pivot=TAGNAME                         # use some other field/tag for account names
    --ignore-assertions(-I)                 # ignore any balance assertions
    --strict(-s)                            # do extra error checking (check that all posted accounts are declared)
    --man                                   # show user manual with man
    --info                                  # show info manual with info
    --debug=[N]: int@dedbug_levels          # show debug output (levels 1-9, default: 1)
    --version                               # show version information
    --help(-h)                              # Display the help message for this command

    # --------

    date?: string@"nu completion date"                                                          # The date of the transaction; an optional (CODE) may follow transaction dates.
    description?: string@"nu completion description"                                        # The description of the transaction; an optional ';' COMMENT may follow descriptions or amounts.
    account1?: string@"nu completion account"                                               # The account to debit
    amount1?: string@"nu completion amount"                                                     # The amount to debit
    account2?: string@"nu completion account"                                               # The account to credit
    amount2?: string@"nu completion amount"                                                     # The amount to credit
    ...transactions: string@"nu completion transaction"                         # a list of transactions following the form DATE DESCRIPTION ACCOUNT1 AMOUNT1 ACCOUNT2 AMOUNT2 ACCOUNT3 (until balance)
]

# Read new transactions added to each FILE provided as arguments since last run, and add them to the journal.
export extern import [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"               # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-versa in hledger-ui/hledger-web)
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --colour=WHEN: string@when_colour                                   # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command help)
    --man                                                               # show user manual with man
    --info                                                              # show info manual with info
    --debug=[N]: int@dedbug_levels                                      # show debug output (levels 1-9, default: 1)
    --version                                                           # show version information
]


#  ######   ######## ##    ## ######## ########     ###    ######## #### ##    ##  ######      ########     ###    ########    ###
# ##    ##  ##       ###   ## ##       ##     ##   ## ##      ##     ##  ###   ## ##    ##     ##     ##   ## ##      ##      ## ##
# ##        ##       ####  ## ##       ##     ##  ##   ##     ##     ##  ####  ## ##           ##     ##  ##   ##     ##     ##   ##
# ##   #### ######   ## ## ## ######   ########  ##     ##    ##     ##  ## ## ## ##   ####    ##     ## ##     ##    ##    ##     ##
# ##    ##  ##       ##  #### ##       ##   ##   #########    ##     ##  ##  #### ##    ##     ##     ## #########    ##    #########
# ##    ##  ##       ##   ### ##       ##    ##  ##     ##    ##     ##  ##   ### ##    ##     ##     ## ##     ##    ##    ##     ##
#  ######   ######## ##    ## ######## ##     ## ##     ##    ##    #### ##    ##  ######      ########  ##     ##    ##    ##     ##

# generate entries to be added to the journal file

#  generate balance-zeroing/restoring transactions
export extern close [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-versa in hledger-ui/hledger-web)
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --colour=WHEN: string@when_colour                                   # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command help)
    --man                                                               # show user manual with man
    --info                                                              # show info manual with info
    --debug=[N]: int@dedbug_levels                                      # show debug output (levels 1-9, default: 1)
    --version                                                           # show version information

    # --------

    ---close                                                            # show a closing transaction (default)
    ---open                                                             # show an opening transaction
    ---migrate                                                          # show both closing and opening transactions
    ---retain                                                           # show a retain earnings transaction (for RX accounts)
    ---explicit(-x)                                                     # show all amounts explicitly
    ---show-costs                                                       # show amounts with different costs separately
    ---interleaved                                                      # show source and destination postings together
    ---close-desc=DESC: string@nu_descriptions                             # set closing transaction's description
    ---close-acct=ACCT: string@nu_accounts                                 # set closing transaction's destination account
    ---open-desc=DESC: string@nu_descriptions                              # set opening transaction's description
    ---open-acct=ACCT: string@nu_accounts                                  # set opening transaction's source account
    ...account_query: string@account_query
]

# generate auto postings, like print --auto
export extern rewrite [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-versa in hledger-ui/hledger-web)
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --colour=WHEN: string@when_colour                                   # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command help)
    --man                                                               # show user manual with man
    --info                                                              # show info manual with info
    --debug=[N]: int@dedbug_levels                                      # show debug output (levels 1-9, default: 1)
    --version                                                           # show version information

    # --------

    --add-posting='ACCT  AMTEXPR': string@posting                       # add a posting to ACCT, which may be parenthesised. AMTEXPR is either a literal amount, or *N which means the transaction's first matched amount multiplied by N (a decimal number). Two spaces separate ACCT and AMTEXPR.
    --diff                                                              # generate diff suitable as an input for patch tool
]


# ######## #### ##    ##    ###    ##    ##  ######  ####    ###    ##          ########  ######## ########   #######  ########  ########  ######
# ##        ##  ###   ##   ## ##   ###   ## ##    ##  ##    ## ##   ##          ##     ## ##       ##     ## ##     ## ##     ##    ##    ##    ##
# ##        ##  ####  ##  ##   ##  ####  ## ##        ##   ##   ##  ##          ##     ## ##       ##     ## ##     ## ##     ##    ##    ##
# ######    ##  ## ## ## ##     ## ## ## ## ##        ##  ##     ## ##          ########  ######   ########  ##     ## ########     ##     ######
# ##        ##  ##  #### ######### ##  #### ##        ##  ######### ##          ##   ##   ##       ##        ##     ## ##   ##      ##          ##
# ##        ##  ##   ### ##     ## ##   ### ##    ##  ##  ##     ## ##          ##    ##  ##       ##        ##     ## ##    ##     ##    ##    ##
# ##       #### ##    ## ##     ## ##    ##  ######  #### ##     ## ########    ##     ## ######## ##         #######  ##     ##    ##     ######

# standard financial statements

export extern aregister [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-versa in hledger-ui/hledger-web)
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --colour=WHEN: string@when_colour                                   # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command help)
    --man                                                               # show user manual with man
    --info                                                              # show info manual with info
    --debug=[N]: int@dedbug_levels                                      # show debug output (levels 1-9, default: 1)
    --version                                                           # show version information

    # --------

    --txn-dates                                                         # filter strictly by transaction date, not posting date. Warning: this can show a wrong running balance.
    --no-elide                                                          # don't show only 2 commodities per amount
    --width(-w)=N: int@width                                            # set output width (default: 80 or $COLUMNS). -wN,M sets description width as well.
    --align-all                                                         # guarantee alignment across all lines (slower)
    --output-format(-O)=FMT: string@formats                             # select the output format. Supported formats: txt, html, csv, tsv, json.
    --output-file(-o)=FILE: string@output_file                          # write output to FILE. A file extension matching one of the above formats selects that format.
]

# show assets, liabilities and net worth
export extern balancesheet [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --sum                                                               # show sum of posting amounts (default)
    --valuechange                                                       # show total change of period-end historical balance value (caused by deposits, withdrawals, market price fluctuations)
    --gain                                                              # show unrealised capital gain/loss (historical balance value minus cost basis)
    --budget                                                            # show sum of posting amounts compared to budget goals defined by periodic transactions
    --change                                                            # accumulate amounts from column start to column end (in multicolumn reports)
    --cumulative                                                        # accumulate amounts from report start (specified by e.g. -b/--begin) to column end
    --historical(-H)                                                    # accumulate amounts from journal start to column end (includes postings before report start date) (default)
    --flat(-l)                                                          # show accounts as a flat list (default). Amounts exclude subaccount amounts, except where the account is depth-clipped.
    --tree(-t)                                                          # show accounts as a tree. Amounts include subaccount amounts.
    --drop=N: int                                                       # flat mode: omit N leading account name parts
    --declared                                                          # include non-parent declared accounts (best used with -E)
    --average(-A)                                                       # show a row average column (in multicolumn reports)
    --row-total(-T)                                                     # show a row total column (in multicolumn reports)
    --summary-only                                                      # display only row summaries (e.g. row total, average) (in multicolumn reports)
    --no-total(-N)                                                      # omit the final total row
    --no-elide                                                          # don't squash boring parent accounts (in tree mode)
    --format=FORMATSTR: string                                          # use this custom line format (in simple reports)
    --sort-amount(-S)                                                   # sort by amount instead of account code/name
    --percent(-%)                                                       # express values in percentage of each column's total
    --layout=ARG: string@financial_reports_layouts                                         # how to show multi-commodity amounts:
    --output-format=FMT(-O): string@formats                             # select the output format. Supported formats: txt, html, csv, tsv, json.
    --output-file=FILE(-o)                                              # output to FILE. A file extension matching one of the above formats selects that format.
]

# show assets, liabilities and equity
export extern balancesheetequity [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --sum                                                               # show sum of posting amounts (default)
    --valuechange                                                       # show total change of period-end historical balance value (caused by deposits, withdrawals, market price fluctuations)
    --gain                                                              # show unrealised capital gain/loss (historical balance value minus cost basis)
    --budget                                                            # show sum of posting amounts compared to budget goals defined by periodic transactions
    --change                                                            # accumulate amounts from column start to column end (in multicolumn reports)
    --cumulative                                                        # accumulate amounts from report start (specified by e.g. -b/--begin) to column end
    --historical(-H)                                                    # accumulate amounts from journal start to column end (includes postings before report start date) (default)
    --flat(-l)                                                          # show accounts as a flat list (default). Amounts exclude subaccount amounts, except where the account is depth-clipped.
    --tree(-t)                                                          # show accounts as a tree. Amounts include subaccount amounts.
    --drop=N: int                                                       # flat mode: omit N leading account name parts
    --declared                                                          # include non-parent declared accounts (best used with -E)
    --average(-A)                                                       # show a row average column (in multicolumn reports)
    --row-total(-T)                                                     # show a row total column (in multicolumn reports)
    --summary-only                                                      # display only row summaries (e.g. row total, average) (in multicolumn reports)
    --no-total(-N)                                                      # omit the final total row
    --no-elide                                                          # don't squash boring parent accounts (in tree mode)
    --format=FORMATSTR: string                                          # use this custom line format (in simple reports)
    --sort-amount(-S)                                                   # sort by amount instead of account code/name
    --percent(-%)                                                       # express values in percentage of each column's total
    --layout=ARG: string@financial_reports_layouts                                         # how to show multi-commodity amounts:
    --output-format=FMT(-O): string@formats                             # select the output format. Supported formats: txt, html, csv, tsv, json.
    --output-file=FILE(-o)                                              # output to FILE. A file extension matching one of the above formats selects that format.
]

# show changes in liquid assets
export extern cashflow [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --sum                                                               # show sum of posting amounts (default)
    --valuechange                                                       # show total change of period-end historical balance value (caused by deposits, withdrawals, market price fluctuations)
    --gain                                                              # show unrealised capital gain/loss (historical balance value minus cost basis)
    --budget                                                            # show sum of posting amounts compared to budget goals defined by periodic transactions
    --change                                                            # accumulate amounts from column start to column end (in multicolumn reports)
    --cumulative                                                        # accumulate amounts from report start (specified by e.g. -b/--begin) to column end
    --historical(-H)                                                    # accumulate amounts from journal start to column end (includes postings before report start date) (default)
    --flat(-l)                                                          # show accounts as a flat list (default). Amounts exclude subaccount amounts, except where the account is depth-clipped.
    --tree(-t)                                                          # show accounts as a tree. Amounts include subaccount amounts.
    --drop=N: int                                                       # flat mode: omit N leading account name parts
    --declared                                                          # include non-parent declared accounts (best used with -E)
    --average(-A)                                                       # show a row average column (in multicolumn reports)
    --row-total(-T)                                                     # show a row total column (in multicolumn reports)
    --summary-only                                                      # display only row summaries (e.g. row total, average) (in multicolumn reports)
    --no-total(-N)                                                      # omit the final total row
    --no-elide                                                          # don't squash boring parent accounts (in tree mode)
    --format=FORMATSTR: string                                          # use this custom line format (in simple reports)
    --sort-amount(-S)                                                   # sort by amount instead of account code/name
    --percent(-%)                                                       # express values in percentage of each column's total
    --layout=ARG: string@financial_reports_layouts                                         # how to show multi-commodity amounts:
    --output-format=FMT(-O): string@formats                             # select the output format. Supported formats: txt, html, csv, tsv, json.
    --output-file=FILE(-o)                                              # output to FILE. A file extension matching one of the above formats selects that format.
]

# show revenues and expenses
export extern incomestatement [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --sum                                                               # show sum of posting amounts (default)
    --valuechange                                                       # show total change of period-end historical balance value (caused by deposits, withdrawals, market price fluctuations)
    --gain                                                              # show unrealised capital gain/loss (historical balance value minus cost basis)
    --budget                                                            # show sum of posting amounts compared to budget goals defined by periodic transactions
    --change                                                            # accumulate amounts from column start to column end (in multicolumn reports)
    --cumulative                                                        # accumulate amounts from report start (specified by e.g. -b/--begin) to column end
    --historical(-H)                                                    # accumulate amounts from journal start to column end (includes postings before report start date) (default)
    --flat(-l)                                                          # show accounts as a flat list (default). Amounts exclude subaccount amounts, except where the account is depth-clipped.
    --tree(-t)                                                          # show accounts as a tree. Amounts include subaccount amounts.
    --drop=N: int                                                       # flat mode: omit N leading account name parts
    --declared                                                          # include non-parent declared accounts (best used with -E)
    --average(-A)                                                       # show a row average column (in multicolumn reports)
    --row-total(-T)                                                     # show a row total column (in multicolumn reports)
    --summary-only                                                      # display only row summaries (e.g. row total, average) (in multicolumn reports)
    --no-total(-N)                                                      # omit the final total row
    --no-elide                                                          # don't squash boring parent accounts (in tree mode)
    --format=FORMATSTR: string                                          # use this custom line format (in simple reports)
    --sort-amount(-S)                                                   # sort by amount instead of account code/name
    --percent(-%)                                                       # express values in percentage of each column's total
    --layout=ARG: string@financial_reports_layouts                                         # how to show multi-commodity amounts:
    --output-format=FMT(-O): string@formats                             # select the output format. Supported formats: txt, html, csv, tsv, json.
    --output-file=FILE(-o)                                              # output to FILE. A file extension matching one of the above formats selects that format.
]

# ##     ## ######## ########   ######     ###    ######## #### ##       ########    ########  ######## ########   #######  ########  ########  ######
# ##     ## ##       ##     ## ##    ##   ## ##      ##     ##  ##       ##          ##     ## ##       ##     ## ##     ## ##     ##    ##    ##    ##
# ##     ## ##       ##     ## ##        ##   ##     ##     ##  ##       ##          ##     ## ##       ##     ## ##     ## ##     ##    ##    ##
# ##     ## ######   ########   ######  ##     ##    ##     ##  ##       ######      ########  ######   ########  ##     ## ########     ##     ######
#  ##   ##  ##       ##   ##         ## #########    ##     ##  ##       ##          ##   ##   ##       ##        ##     ## ##   ##      ##          ##
#   ## ##   ##       ##    ##  ##    ## ##     ##    ##     ##  ##       ##          ##    ##  ##       ##        ##     ## ##    ##     ##    ##    ##
#    ###    ######## ##     ##  ######  ##     ##    ##    #### ######## ########    ##     ## ######## ##         #######  ##     ##    ##     ######

# more complex/versatile reporting commands

# show a simple bar chart of posting counts per period
export extern activity [
        # General flags
        --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
        --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
        --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
        --pivot=TAGNAME                                                     # use some other field/tag for account names
        --ignore-assertions(-I)                                             # ignore any balance assertions
        --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
        --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
        --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
        --daily(-D)                                                         # multiperiod/multicolumn report by day
        --weekly(-W)                                                        # multiperiod/multicolumn report by week
        --monthly(-M)                                                       # multiperiod/multicolumn report by month
        --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
        --yearly(-Y)                                                        # multiperiod/multicolumn report by year
        --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
        --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
        --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
        --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
        --pending(-P)                                                       # include only pending postings/txns
        --cleared(-C)                                                       # include only cleared postings/txns
        --real(-R)                                                          # include only non-virtual postings
        --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
        --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
        --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
        --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
        --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
        --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
        --infer-equity                                                      # conversion equity postings from costs
        --infer-costs                                                       # costs from conversion equity postings
        --infer-market-prices                                               # costs as additional market prices, as if they were P directives
        --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
        --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
        --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
        --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
        --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
        --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
        --help(-h)                                                          # show general help (or after CMD, command
]

# show balance changes, end balances, budgets, gains..
export extern balance [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --sum                                                               # show sum of posting amounts (default)
    --budget=[DESCPAT]                                                  # show sum of posting amounts together with budget goals defined by periodic transactions. With a DESCPAT argument (must be separated by = not space), use only periodic transactions with matching description (case insensitive substring match).
    --valuechange                                                       # show total change of value of period-end historical balances (caused by deposits, withdrawals, market price fluctuations)
    --gain                                                              # show unrealised capital gain/loss (historical balance value minus cost basis)
    --count                                                             # show the count of postings
    --change                                                            # accumulate amounts from column start to column end (in multicolumn reports, default)
    --cumulative                                                        # accumulate amounts from report start (specified by e.g. -b/--begin) to column end
    --historical(-H)                                                    # accumulate amounts from journal start to column end (includes postings before report start date)
    --flat(-l)                                                          # show accounts as a flat list (default). Amounts exclude subaccount amounts, except where the account is depth-clipped.
    --tree(-t)                                                          # show accounts as a tree. Amounts include subaccount amounts.
    --drop=N: int                                                       # omit N leading account name parts (in flat mode)
    --declared                                                          # include non-parent declared accounts (best used with -E)
    --average(-A)                                                       # show a row average column (in multicolumn reports)
    --related(-r)                                                       # show postings' siblings instead
    --row-total(-T)                                                     # show a row total column (in multicolumn reports)
    --summary-only                                                      # display only row summaries (e.g. row total, average) (in multicolumn reports)
    --no-total(-N)                                                      # omit the final total row
    --no-elide                                                          # don't squash boring parent accounts (in tree mode)
    --format=FORMATSTR: string                                          # use this custom line format (in simple reports)
    --sort-amount(-S)                                                   # sort by amount instead of account code/name (in flat mode). With multiple columns, sorts by the row total, or by row average if that is displayed.
    --percent(-%)                                                       # express values in percentage of each column's total
    --invert                                                            # display all amounts with reversed sign
    --transpose                                                         # transpose rows and columns
    --layout=ARG: string@all_layouts                                    # how to lay out multi-commodity amounts and the overall table
    --output-format=FMT(-O): string@formats                             # select the output format. Supported formats: txt, html, csv, tsv, json.
    --output-file=FILE(-o)                                              # write output to FILE. A file extension matching one of the above formats selects that format.
]

# show transactions or export journal data
export extern print [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --explicit(-x)                                                      # show all amounts explicitly
    --show-costs                                                        #  transaction prices even with conversion postings
    --round=TYPE: string@round_modes                                    #  much rounding or padding should be done when displaying amounts
    --new                                                               #  only newer-dated transactions added in each file since last run
    --match(-m)=DESC: string@nu_descriptions                            # fuzzy search for one recent transaction with description closest to DESC
    --output-format(-O)=FMT: string@formats                             # select the output format. Supported formats: txt, beancount, csv, tsv, json, sql.
    --output-file(-o)=FILE                                              # write output to FILE. A file extension matching one of the above formats selects that format.
]

# show postings in one or more accounts & running total
export extern register [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --cumulative                                                        # show running total from report start date (default)
    --historical(-H)                                                    # show historical running total/balance (includes postings before report start date)
    --average(-A)                                                       # show running average of posting amounts instead of total (implies --empty)
    --match(-m)=DESC: string@nu_descriptions                               # fuzzy search for one recent posting with description closest to DESC
    --related(-r)                                                       # show postings' siblings instead
    --invert                                                            # display all amounts with reversed sign
    --width(-w)=N: int@width                                            # set output width (default: 80 or $COLUMNS). -wN,M sets description width as well.
    --align-all                                                         # guarantee alignment across all lines (slower)
    --output-format(-O)=FMT: string@formats                             # select the output format. Supported formats: txt, csv, tsv, json.
    --output-file(-o)=FILE: string                                      # write output to FILE. A file extension matching one of the above formats selects that format.
]

# show return on investments
export extern roi [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --cashflow                                                          # show all amounts that were used to compute returns
    --investment=QUERY                                                  # query to select your investment transactions
    --profit-loss=QUERY                                                 # query to select profit-and-loss or appreciation/valuation transactions
    --pnl=QUERY                                                         # query to select profit-and-loss or appreciation/valuation transactions
]

# ########     ###     ######  ####  ######     ########  ######## ########   #######  ########  ########  ######
# ##     ##   ## ##   ##    ##  ##  ##    ##    ##     ## ##       ##     ## ##     ## ##     ##    ##    ##    ##
# ##     ##  ##   ##  ##        ##  ##          ##     ## ##       ##     ## ##     ## ##     ##    ##    ##
# ########  ##     ##  ######   ##  ##          ########  ######   ########  ##     ## ########     ##     ######
# ##     ## #########       ##  ##  ##          ##   ##   ##       ##        ##     ## ##   ##      ##          ##
# ##     ## ##     ## ##    ##  ##  ##    ##    ##    ##  ##       ##        ##     ## ##    ##     ##    ##    ##
# ########  ##     ##  ######  ####  ######     ##     ## ######## ##         #######  ##     ##    ##     ######

# lists and stats

# show account names
export extern accounts [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --used(-u)                                                          # show only accounts used by transactions
    --declared(-d)                                                      # show only accounts declared by account directive
    --unused                                                            # show only accounts declared but not used
    --undeclared                                                        # show only accounts used but not declared
    --types                                                             # also show account types when known
    --positions                                                         # also show where accounts were declared
    --directives                                                        # show as account directives, for use in journals
    --find                                                              # find the first account matched by the first argument (a case-insensitive infix regexp or account name)
    --flat(-l)                                                          # show accounts as a flat list (default)
    --tree(-t)                                                          # show accounts as a tree
    --drop=N: int                                                       # flat mode: omit N leading account name parts
]

# show transaction codes
export extern codes [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command
]

# show commodity/currency symbols
export extern commodities [
        # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command
]

# show full transaction descriptions (payee and note)
export extern descriptions [
        # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    ...rest: string@nu_descriptions # works with int though🙃
]

# show data files in use
export extern files [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command
]

# show note part of transaction descriptions
export extern notes [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command
]

# show payee names
export extern payees [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --declared                                                          # show payees declared with payee directives
    --used                                                              # show payees referenced by transactions
]

# show historical market prices
export extern prices [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --show-reverse          also show the prices inferred by reversing known prices
]

# show journal statistics
export extern stats [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --output-file(-o)=FILE: path                                        # write output to FILE.
]

# show tag names
export extern tags [
    # General flags
    --file(-f)=FILE: path                                               # use a different input file. For stdin, use - (default: $LEDGER_FILE or $HOME/.hledger.journal)
    --rules-file=RFILE: path                                            # CSV conversion rules file (default: FILE.rules)
    --alias=OLD=NEW                                                     # rename accounts named OLD to NEW
    --pivot=TAGNAME                                                     # use some other field/tag for account names
    --ignore-assertions(-I)                                             # ignore any balance assertions
    --strict(-s)                                                        #  do extra error checking (check that all posted accounts are declared)
    --begin(-b)=DATE: string@"nu completion date"                       # include postings/transactions on or after this date (will be adjusted to preceding subperiod start when using a report interval)
    --end(-e)=DATE: string@"nu completion date"                         # include postings/transactions before this date (will be adjusted to following subperiod end when using a report interval)
    --daily(-D)                                                         # multiperiod/multicolumn report by day
    --weekly(-W)                                                        # multiperiod/multicolumn report by week
    --monthly(-M)                                                       # multiperiod/multicolumn report by month
    --quarterly(-Q)                                                     # multiperiod/multicolumn report by quarter
    --yearly(-Y)                                                        # multiperiod/multicolumn report by year
    --period(-p)=PERIODEXP: string@"nu completion period"                # set start date, end date, and/or report interval    all at once
    --date2                                                             # match the secondary date instead. See command help for other effects. (--effective, --aux-date also accepted)
    --today=DATE: string@"nu completion date"                           # override today's date (affects relative smart dates, for tests/examples)
    --unmarked(-U)                                                      # include only unmarked postings/txns (can combine with -P or -C)
    --pending(-P)                                                       # include only pending postings/txns
    --cleared(-C)                                                       # include only cleared postings/txns
    --real(-R)                                                          # include only non-virtual postings
    --depth(- )=NUM: int                                                # hide accounts/postings deeper than NUM
    --empty(-E)                                                         # show items with zero amount, normally hidden (and vice-vers
    --cost(-B)                                                          # show amounts converted to their cost/selling amount, using the transaction price.
    --market(-V)                                                        # show amounts converted to period-end market value in their default valuation commodity. Equivalent to --value=end.
    --exchange(-X)=COMM: string@nu_commodities                             # show amounts converted to current (single period reports) or period-end (multiperiod reports) market value in the specified commodity. Equivalent to --value=end,COMM.
    --value=TYPE[,COMM]: string@value_types                             # show amounts converted with valuation TYPE, and optionally to specified commodity COMM
    --infer-equity                                                      # conversion equity postings from costs
    --infer-costs                                                       # costs from conversion equity postings
    --infer-market-prices                                               # costs as additional market prices, as if they were P directives
    --forecast=[PERIOD]                                                 # Generate transactions from periodic rules, between the latest recorded txn and 6 months from today, or during the specified PERIOD (= is required). Auto posting rules will be applied to these transactions as well. Also, in hledger-ui make future-dated transactions visible.
    --auto                                                              # Generate extra postings by applying auto posting rules to all txns (not just forecast txns).
    --verbose-tags                                                      # Add visible tags indicating transactions or postings which have been generated/modified.
    --commodity-style(-c)=COMM                                          # Override the commodity style in the output for the specified commodity. For example 'EUR1.000,00'.
    --color=WHEN: string@when_colour                                    # Should color-supporting commands use ANSI color codes in text output. (default=auto); A NO_COLOR environment variable overrides this.
    --pretty=[WHEN]: string@yes_no                                      # Show prettier output, e.g. using unicode box-drawing characters. 'yes' is the default. If you provide an argument you must use '=', e.g. '--pretty=yes'.
    --help(-h)                                                          # show general help (or after CMD, command

    # --------

    --values                                                            # list tag values instead of tag names
    --parsed                                                            # show tags/values in the order they were parsed, including duplicates

    ...query: string@nu_tags
]


#        _           _
#       | |         | |
#    ___| |_ ___ ___| |_ ___ _ __ __ _
#   / _ \ __/ __/ _ \ __/ _ \ '__/ _` |
#  |  __/ || (_|  __/ ||  __/ | | (_| |
#   \___|\__\___\___|\__\___|_|  \__,_|

# hledger usage tutorial
export extern demo [
    # General flags:
    --help(-h)                                                          # show general help (or after CMD, command help)
    --man                                                               # show user manual with man
    --info                                                              # show info manual with info
    --debug=[N]: int@dedbug_levels                                      # show debug output (levels 1-9, default: 1)
    --version                                                           # show version information

    # --------

    --speed(-s)=SPEED: float@speeds                                     # playback speed (1 is original speed, .5 is half, 2 is double, etc (default: 2))
    tutorial?: int@hl_demo_tutorials                                    # tutorial number (1-4); [NUM|PREFIX|SUBSTR] to match a tutorial by number, prefix or substring
]

# Run built-in unit tests
export extern test [
    # General flags:
    --help(-h)                                                          # show general help (or after CMD, command help)
    --man                                                               # show user manual with man
    --info                                                              # show info manual with info
    --debug=[N]: int@dedbug_levels                                      # show debug output (levels 1-9, default: 1)
    --version
]


#         _ _
#        | (_)
#    __ _| |_  __ _ ___  ___  ___
#   / _` | | |/ _` / __|/ _ \/ __|
#  | (_| | | | (_| \__ \  __/\__ \
#   \__,_|_|_|\__,_|___/\___||___/


export alias areg = aregister
export alias bs = balancesheet
export alias bse = balancesheetequity
export alias cf = cashflow
export alias is = incomestatement
export alias bal = balance
export alias reg = hledger register

#  ######   #######  ##     ## ########  ##       ######## ######## ####  #######  ##    ##  ######
# ##    ## ##     ## ###   ### ##     ## ##       ##          ##     ##  ##     ## ###   ## ##    ##
# ##       ##     ## #### #### ##     ## ##       ##          ##     ##  ##     ## ####  ## ##
# ##       ##     ## ## ### ## ########  ##       ######      ##     ##  ##     ## ## ## ##  ######
# ##       ##     ## ##     ## ##        ##       ##          ##     ##  ##     ## ##  ####       ##
# ##    ## ##     ## ##     ## ##        ##       ##          ##     ##  ##     ## ##   ### ##    ##
#  ######   #######  ##     ## ##        ######## ########    ##    ####  #######  ##    ##  ######

def "nu completion period" [ctx:string] {
    # example: [interval] start [end]
    let token = $ctx | split words | last
    let parts = $token | split row ' '
    if $parts.0 == 'every' {
        if ($parts | length) == 1 {
            let other = MONTHS | append (seq 1 12 | each {|i| $'($i)/'}) | each {|e| $'"($token) ($e)"'}
            seq 1 31 | each {|e|
                match $e {
                    1 | 21 | 31 => 'st "'
                    2 | 22 => 'nd "'
                    3 | 23 => 'rd "'
                    _ => 'th "'
                } | prepend $'"($token) ($e)' | str join #todo: breaks because of the number which is not a word and thus can't keep counting :(
            } | prepend $other
        } else if ($parts.1 | parse --regex '(\d+\w*)' | is-not-empty) {
            [day] | appen WEEKDAYS | each {|e| $'"($token) ($e)"'}
        }
    } else {
        ['from '] | append (nu_intervals) | append 'every ' | each {|e| $'"($e)"'}
    }

}

def "nu completion date" [ctx:string] {
    let date = $ctx | nu completion parse-context | get args | last | split row -
    let now = today

    if ($date | length ) == 1 {
        seq -100 100  | each {|e| if $e != 0 { $"($now.year - $e)-"} } | prepend $"($now.year)-"
    } else if ($date | length) == 2 {
        let year = $date.0 | into int
        seq 1 12 | each {|e| if $e < 10 { $"($year)-0($e)-"} else { $"($year)-($e)-"} }
    } else if ($date | length) == 3 {
        let month = $date.1
        let year = $date.0
        match ($month | into int) {
            1 | 3 | 5 | 7 | 8 | 10 | 12 => (seq 1 31)
            4 | 6 | 9 | 11  => (seq 1 30)
            2 => (if ($year | into int) mod 4 == 0 { (seq 1 29) } else { (seq 1 28) })
        }  | each {|e| if $e < 10 { $"($year)-($month)-0($e) "} else { $"($year)-($month)-($e) "} }
    } | nu completion output $ctx
}

def "nu completion description" [ctx:string] {
    let token = $ctx | split words | last
    nu_descriptions | each {|e| if ($e | str contains ' ') { $'"($e)" '}}
}

def "nu completion account" [ctx:string] {
    let token = $ctx | split words | last
    nu_accounts | each {|e| if ($e | str contains ' ') { $e } else { $e } } #todo: more effort for custom parse handling of colons and spaces tings
    # if ($token | str contains ':') {
    #     nu_accounts | where {|e| $e | str starts-with $token} | each {|e| $e | str substring ($token | str length).. | split row ':' | first | prepend $token | str join } | uniq #| each {|e| if ($e | str contains ' ') { $"'($e)'" } else { $e } }
    # } else {
    #     nu_accounts | each {|e| ($e | split row ':' | first) + ':'} | uniq
    # }
}

def "nu completion amount" [ctx:string] {
    let token = $ctx | split row ' ' | last
    let qty = $token | parse --regex '(?<qty>^\d+$)' | get qty
    if ($qty | is-not-empty) {
        nu_commodities | each {|e| $"($qty|first)($e)"}
    } else {
        nu_commodities
    }
}

def "nu completion transaction" [ctx: string] {
    let ctx = $ctx | trim
    let token = $ctx | split row ' ' | last
    let char = $token | split chars | last

    if $char == ':' {
        nu_accounts | where ($it | str starts-with $token) | each {|e|
            $e | split row ':' | skip while {|acct| $acct != $token } | skip 1 | first | prepend $token | str join ":"
        }
    }
    else if $char == '@' {

    }
    else {
        nu_accounts | where ($it | str starts-with $token) | each {|e|
            $e | split row ':' | first
        } | append nu_commodities
    }
}

def hl_demo_tutorials [] {
    [
        {value: 1, description: 'The easiest way to start a journal (add)'}
        {value: 2, description: 'Show full transactions (print)'}
        {value: 3, description: 'Show account balances and changes (balance)'}
        {value: 4, description: 'Upgrading hledger tools to latest source release with hledger-install'}
    ]
}

def speeds [] {
    [
        {value: 1, description: 'original speed'}
        {value: .5, description: 'half speed'}
        {value: 2, description: 'double speed'}
    ]
}

def round_modes [] {
    [
        {value: none, description: 'show original decimal digits, as in journal'}
        {value: soft, description: 'just add or remove decimal zeros to match precision (default)'}
        {value: hard, description: 'round posting amounts to precision (can unbalance transactions)'}
        {value: all, description: 'also round cost amounts to precision (can unbalance transactions)'}
    ]
}

def all_layouts [ctx?: string] {
    [
        # 'wide[,WIDTH]': all commodities on one line
        {value: 'wide', description: 'all commodities on one line'}
        {value: 'tall', description: 'each commodity on a new line'}
        {value: 'bare', description: 'bare numbers, symbols in a column'}
        {value: 'tidy', description: 'every attribute in its own column'}
    ]
}
def financial_reports_layouts [ctx?: string] {
    [
        # 'wide[,WIDTH]': all commodities on one line
        {value: 'wide', description: 'all commodities on one line'}
        {value: 'tall', description: 'each commodity on a new line'}
        {value: 'bare', description: 'bare numbers, symbols in a column'}
    ]
}

def formats [] {
    [txt, html, csv, tsv, json]
}

# todo: handle paths
def output_file [ctx?: string] {
    let name  = $ctx | split words | last
    formats | each {|ext|
        $name + '.' + $ext
    }
}

def width [ctx?: string] {
    # allow comma to set width of description
    seq 1 100
}

def posting [] {

}

## queries

def account_query [] {
    "acct:assets"
}

def yes_no [] {
    [yes,no]
}

def when_colour [] {
    [
        {value: 'auto', description: '(default): whenever stdout seems to be a color-supporting terminal.'}
        {value: 'always', description: 'same as yes'}
        {value: 'yes',  description: `always, useful eg when piping output into 'less -R'`.}
        {value: 'no',  description: 'same as no'}
        {value: 'never' , description: 'do not display output with color codes.'}
    ]
}

def value_types [ctx?: string] {
    [
        {value: 'then', description: `convert to contemporaneous market value, in default valuation commodity or COMM (print & register commands only)`}
        {value: end, description: 'convert to period-end market value, in default valuation commodity or COMM' }
        {value: 'now', description:  `convert to current market value, in default valuation commodity or COMM`}
        {value: 'YYYY-MM-DD', description: 'convert to market value on the given date, in default valuation commodity or COMM'}
    ]
}
def dedbug_levels [] {
    [
        {value: 1, description: 'least output (default)'},
        2 3 4 5 6 7 8
        {value: 9, description: 'maximum output; all debug output'}
    ]
}



# not accurate
def help_topics [] {
    [
        "about" "accounting" "accounts" "amounts" "balancing" "budgeting" "chart" "commodities" "csv" "data" "date" "display" "fava" "filtering" "formatting" "hledger-ui" "hledger-web" "importing" "journal" "ledger" "options" "payees" "periods" "prices" "querying" "reconciling" "rules" "running" "tags" "timesheet" "transactions" "types" "unposting" "upgrading" "utilities" "web" "writing"
    ]
}

# hledger functions

def nu_descriptions [] {
    ^hledger descriptions | lines
}

def nu_accounts [] {
    ^hledger accounts | lines
}

def nu_commodities []: nothing -> list<string> {
    ^hledger commodities | lines
}

def nu_tags []: nothing -> list<string> {
    ^hledger tags | lines
}

def nu_intervals [] nothing -> list<string> {
    [
        daily
        weekly
        monthly
        quarterly
        yearly
        biweekly # every two weeks
        fortnightly
        bimonthly # every two months
        'every day'
        'every week'
        'every month'
        'every quarter'
        'every year'
        (WEEKDAYS | each {|e| 'every ' + $e})
        weekday
        weekendday
    ] | flatten
}

def WEEKDAYS [] {
    [monday tuesday wednesday thursday friday saturday sunday]
}

def MONTHS [] {
    [january february march april may june july august september october november december]
}

# helper functions
const parse_args_rg = "(?<opening_quote>['\"`]?)(?<content>.*?)(?<closing_quote>\\k<opening_quote>)(?<separator>\\s+)"
const parse_option_name_rg = "(?:--?)(?<option_name>[\\w-]+)"

def "nu completion parse-context" [] string -> {cmd: string, args: list<string>} {
    let ctx = $in + ' ' # add space to end to ensure last part is parsed🙄
    # context strings starts at cursor position
    # need to parse but args could be quote enclosed; split words delimtis '.' and ' '
    mut parts = ($ctx | parse --regex $parse_args_rg
    # | each {|e| $e | upsert content  {|c| if $c.opening_quote == '' {$c.content} else { $c.content | str replace -r --all "\\\\(.)" "$1"} }}
    | get content) #= (?<opening_quote>['"`]?)(?<content>.*?)(?<closing_quote>\k<opening_quote>)(?<separator>\s+)
    # print $parts
    mut cmd = {cmd: $parts.0, args: []}
    mut args = []

    $parts = ($parts | skip 1)
    while ($parts | length) > 0 {
        let part = $parts.0
        let isOption = ($part | str starts-with '-')
        if $isOption {
            # no need to check for whitespace (\s) in the regex, because content is non-greedy AKA not parsing of option name from raw command string like above
            let optName = $part | parse --regex "(?:--?)(?<option_name>[\\w-]+)" | get option_name | first
            let optValue = $parts | get 1
            $cmd = ($cmd | upsert $optName $optValue)
        } else {
            $args ++= $part
        }
        $parts = ($parts | skip (1 + if $isOption {1} else {0}))
    }
    $cmd | upsert args $args
}


def "nu completion output" [ctx: string] list<string> -> list<string>, string -> list<string> {
    let output = $in
    let quote = $ctx + ` `
    | parse --regex $parse_args_rg
    | last
    if $quote.opening_quote != '' {
        let quote = $quote | get opening_quote
        $output | each {|e| $"($quote)($e)($quote)"}
    } else if ($quote.content | parse --regex "(?<quote>['\"`])(?:.*)" | is-not-empty) {
        let quote = $quote.content | str substring 0..1
        $output | each {|e| $"($quote)($e)($quote)"}
    } else {
        $output
    }
}

def "remove enclosing quotes" []: string -> string {
    mut s = $in
    if ($s | str starts-with '"') or ($s | str starts-with "'") {
        $s = ($s | str substring 1..)
    }
    if ($s | str ends-with '"') or ($s | str ends-with "'") {
        $s = ($s | str substring 0..-1)
    }
    $s
}

def today [] {
    date now | date to-record
}