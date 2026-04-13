# My Dotfiles

made [chezmoi](https://github.com/twpayne/chezmoi), donc si tu ne comprend pas le noms de quel qu'une de ces fichiers, tu peux aller voir [les doc](https://www.chezmoi.io) pour comprenez et comment appliquer vous meme.

## why

Am I just flexing that I use multiple OSes?
Or just love making my life incongruent and difficult managing very different systems to this extent?

Definitely in part.
It definitely is a blessing to be able to use each of these operating systems, and have tried them each on their proper machine, but I guess I'm just a nerd 🤓.
And I like exploring technology learning their differences, hating them, loving one (*cough* Arch Linux btw), and then (after a long while when my biases fade) appreciating their uniqueness and design choices: yes even Windows, and macOS (they truly do all have their strong suits and valid reasons to be used :/)

### take-aways

- Mac: ~~net-~~zero pollution of user space, even hidden or dotfiles cuz ew mess -- less is best ![Bee & Puppycat with Tempbot](https://media.giphy.com/media/znhKtWU6JX9ni/giphy.gif)
  - everything in my $HOME folder should make sense and be descriptive; NOT A MESS of app configs hidden behind a dot (`.`) -- **LINUX**
- Windows: ...? uummm, well.. (moving on 😬))
- Linux: ... .....  ̄\_(ツ)_/ ̄

ok so it looks like right now I know nothing of Windows and Linux ditros and my whole beginning yap was a lie, and really I'm an apple-eater.
I'll keep using them and see if any philosophies or design choices resonate with me that I can extend into my workflow OS agonistically.

## Tool-Belt

- Terminal: Ghostty, Kitty, or Windows Terminal
- Shell: Zsh, Bash, Powershell, but I'd love to main Nushell across OSes
- Editor: NeoVim, Microsoft Edit, or Micro (if am really editing cuz I'm not good with Vim yet (ᵟຶ︵ ᵟຶ))
- Visual: Visual Studio Code or Zed
- Browser: Orion, Floorp, or Vivaldi

yea, so that list is a lot but mostly becuz of availability and quality of service (QoS) I get from each app on each OS.
And by that I mean these dotfiles are not ready to lift their respective configs across distros.. yet.


## Structure

The repository is structured as follows:

```tree
.
├── .chezmoitemplates (shared files and folders)/
│   ├── aka. the important stuff
│   ├── and utilities across machines
│   └── tout important a utiliser pour mon flux
├── dot_config (= .config)/
│   ├── alias l'origine des
│   ├── fichiers et dossiers
│   └── pour configurations
├── AppData (windows-specifics)
├── Library (mac specifics)
└── packages/
    ├── scoop
    ├── uniget = winget + scoop + other windows apps
    └── homebrew
```
