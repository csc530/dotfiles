export extern main [
    --completion(-C)=string: string@"nu completion shells"             # print shell completion function, pass shell name as argument ("bash", "zsh" or "fish")
    --format(-f)=string: string@"nu completion formats"                 # generates rows in f format. Available formats: column|ndjson|sql (default "column")
    --generator(-g)=string: string@"nu completion generators"              # show help for a specific generator
    --generators(-G)                    # lists available generators
    --generators-with-constraints(-c)   # lists available generators with constraints
    --header(-H)                        # adds headers row
    --help(-h)                          # shows help
    --limit(-l)=int: int                     # limits rows up to n (default 10)
    --separator(-s)=string: string              # specifies separator for the column format (default " ")
    --stream(-S)                        # streams rows till the end of time
    --table(-t)=string: string                  # table name of the sql format (default "TABLE")
    --template(-T)=string: string               # Use template as input
    --version(-v)                       # shows version information

    ...generator: string@"nu completion generators"
]

def "nu completion shells" [] {
    [bahs zsh fish]
}

def "nu completion formats" [] {
    [column ndjson sql]
}

def "nu completion generators" [] {
    [
        {value: "adjectives"    , description: "adjective" }
        {value: "animal"        , description: "animal breed" }
        {value: "animal.cat"    , description: "random cat breed" }
        {value: "animal.dog"    , description: "dog breed" }
        {value: "city"          , description: "US city name" }
        {value: "color"         , description: "one word color" }
        {value: "country"       , description: "Full country name" }
        {value: "country.code"  , description: "2-digit country code" }
        {value: "date"          , description: "random date in the format YYYY-MM-DD. By default, it generates dates in the last year" }
        {value: "domain"        , description: "domain" }
        {value: "domain.tld"    , description: "valid TLD name from https://data.iana.org/TLD/tlds-alpha-by-domain.txt" }
        {value: "double"        , description: "double number" }
        {value: "email"         , description: "email" }
        {value: "emoji"         , description: "emoji from https://github.com/dariusk/corpora/blob/master/data/words/emojis.json" }
        {value: "enum"          , description: "value from an enum. By default, the enum is foo,bar,baz. It accepts a list of comma-separated values" }
        {value: "event.action"  , description: "clicked|purchased|viewed|watched" }
        {value: "file"          , description: "random value from a file. It accepts a file path. It can be either relative or absolute. The file must contain a value per line" }
        {value: "http.method"   , description: "DELETE|GET|HEAD|OPTION|PATCH|POST|PUT" }
        {value: "industry"      , description: "industry" }
        {value: "int"           , description: "positive integer between 1 and 1000" }
        {value: "ipv4"          , description: "ipv4" }
        {value: "ipv6"          , description: "ipv6" }
        {value: "latitude"      , description: "latitude" }
        {value: "longitude"     , description: "longitude" }
        {value: "mac.address"   , description: "mac address" }
        {value: "name"          , description: 'name.first + " " + name.last' }
        {value: "name.first"    , description: "capitalized first name" }
        {value: "name.last"     , description: "capitalized last name" }
        {value: "noun"          , description: "noun from https://github.com/dariusk/corpora/blob/master/data/words/nouns.json" }
        {value: "occupation"    , description: "occupation" }
        {value: "phone"         , description: "Phone number according to E.164" }
        {value: "phone.code"    , description: "Calling country code" }
        {value: "phone.local"   , description: "phone number without calling country code. It accepts an integer N number of digits. Min: 8, Max: 12" }
        {value: "sentence"      , description: "sentence" }
        {value: "state"         , description: "Full US state name" }
        {value: "state.code"    , description: "2-digit US state name" }
        {value: "timestamp"     , description: "Unix timestamp between epoch and now" }
        {value: "timezone"      , description: "tz in the form Area/City" }
        {value: "username"      , description: "username using the pattern \\w+" }
        {value: "uuidv1"        , description: "uuidv1" }
        {value: "uuidv4"        , description: "uuidv4" }
        {value: "uuidv6"        , description: "uuidv6" }
        {value: "uuidv7"        , description: "uuidv7" }

    ]
}