export extern main [
    --color-mode(-c)=<COLOR_MODE>: string@colour        # what kind of terminal coloring to use
    --palette=<PALETTE>: string@palette                  # the color palette used assign colors to pipes
    --rainbow=<DEGREES>: int@rainbow                  # cycle hue of pipes
    --delay(-d)=<DELAY_MS>: int                    # delay between frames in milliseconds
    --fps(-f)=<FPS>: float                         # number of frames of animation that are displayed in a second; use 0 for unlimited
    --reset-threshold(-r)=<RESET_THRESHOLD>: float  # portion of screen covered before resetting (0.0–1.0)
    --kinds(-k)=<KINDS>: string@kind                      # kinds of pipes separated by commas, e.g. heavy,curved
    --bold(-b)=<BOOL>: string@bool                        # whether to use bold [possible values: true, false]
    --inherit-style(-i)=<BOOL>?: string@bool               # whether pipes should retain style after hitting the edge [possible values: true, false]
    --pipe-num(-p)=<NUM>: int                     # number of pipes
    --turn-chance(-t)=<TURN_CHANCE>: float          # chance of a pipe turning (0.0–1.0)
    --license                                # Print license
    --help(-h)                               # Print help
    --version(-V)                            # Print version
]

def rainbow [] {
    0..255
}

def palette [] {
    [default, darker, pastel matrix]
}

def colour [] {
    [ansi, rgb none]
}

def kind [] {
    [heavy curved emoji]
}

def bool [] {
    ["'true'" "'false'"]
}