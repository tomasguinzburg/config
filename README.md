# Config
.config/ files for consistent terminal experience across workstations.

### Prerequisites

You'll need a package manager (I use [brew](https://brew.sh/)) and a
[Rust toolchain](https://www.rust-lang.org/tools/install)

```
brew install git rustup-init fish
cargo install sccache --locked
RUST_WRAPPER=sccache cargo install zoxide zellij mise-en-place --locked
```

### Usage

Unless you own this repo, it's not a good idea to clone into your config
directly; and should probably fork it instead.

```
cd ~/.config
git init
git remote add origin git@github.com:tomasguinzburg/config.git
git pull
```
