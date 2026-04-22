# TODO

## Migration followups

- **Verify macOS bootstrap on existing mac.** See the dedicated "macOS in-place upgrade test plan" section below for step-by-step.
- **`.gitmodules` submodule section names** still reference the old path (`[submodule "config/home/.hammerspoon/..."]`) — the `path = ` values were updated, so git works, but the labels are cosmetically stale. Rename requires syncing `.git/config` and `.git/modules/<name>/` dir — skip until next time submodules need touching.
- **iTerm2 plist internal path** (`machines/macos/settings/iterm2/com.googlecode.iterm2.plist`) has a stale `/Users/William/dotfiles/env/settings/iterm2` string embedded. iTerm2 regenerates this on save; fix by re-exporting the prefs from a mac after the migration lands.
- **`machines/macos/setup.sh`** installs a lot (Anaconda, Chrome, Skype, keka, basictex, etc.) — review whether these are still wanted before next mac bootstrap.
- **Extract common Claude permissions** — `machines/ona/claude/settings.json` and `machines/macos/claude/settings.json` both carry duplicated keys (`model`, `enabledPlugins`, `autoDreamEnabled`, `deny`). Either move shared bits to `config/claude/settings.common.json` + `jq` deep-merge at setup time, or accept the duplication (current choice).
- **Repo branch cleanup** — after the migration merges to `master`, delete stale remote branches: `codespace`, `cs162vm`, `hive`, `mp`, `ocf`, `ubuntu`, `wsl`, `setup-idempotent`, `setup-packages`, `worktree-prefetch-all-users`.
- **`.claude/settings.local.json` at repo root** is project-local Claude permissions (granted during dotfiles editing). Currently committed — decide whether to gitignore it going forward.
- **Prezto fork** — `triyangle/prezto` is still single-branch; no migration needed, but verify `setup/prezto/setup.sh` still works after all the directory renames.

## Nice-to-haves

- Add a `machines/<env>/zshrc.local` overlay hook documented in the README.
- **`ona-start-all` zsh fn in `machines/macos/zshrc.local`.** Filters `ona environment list` on `ENVIRONMENT_PHASE_STOPPED` and loops `ona environment start --dont-wait <id>` (no bulk flag exists; `--dont-wait` avoids the default 30s-per-env wait). Work-laptop-only in practice (`ona` CLI not on personal mbp → fn exists but is a no-op), nothing sensitive, so the shared `machines/macos/` overlay is fine — no work/personal env split needed. Follow-up idea: launchd agent to auto-run at login if you want envs up without thinking about it.
- Consider chezmoi if a 3rd active env ever appears with significant overlap with an existing one.

## Manual post-bootstrap steps on fresh Ona

- **Statsig siggy CLI keys.** `machines/ona/setup.sh` installs `@statsig/siggy` globally via npm. Configure API keys from 1Password:
    ```sh
    siggy config -k <client key>
    siggy config -c <console key>
    ```
- **Claude Code `/plugin install slack@claude-plugins-official`.** User-scoped plugins don't auto-install from `enabledPlugins` (see below).

## Claude Code first-run

- **Plugins still need manual `/plugin install`.** Confirmed empirically on fresh Ona: `extraKnownMarketplaces` + `enabledPlugins` in `settings.json` does NOT auto-install. It only (a) pre-registers the marketplace (no `/plugin marketplace add` needed) and (b) auto-enables the plugin once installed. On a fresh Ona, after Claude Code launches, run: `/plugin install slack@claude-plugins-official`. Track other plugins here if the user adds more user-scoped ones. Consider a post-bootstrap doc line in README or a `machines/ona/setup.sh` hook that launches Claude with `--install-plugin` flags if such a CLI exists.
- **Theme + editorMode pre-seed (implemented in `setup/symlink.sh`).** `~/.claude.json` gets written with `{theme, editorMode, hasCompletedOnboarding}` only when it doesn't already exist, suppressing the first-run wizard and giving vim keybindings on fresh installs. Undocumented path but non-destructive (skipped if the file exists). Revisit if Claude Code ever exposes these in `settings.json`.

## macOS in-place upgrade test plan

Written so a separate Claude Code instance on the Mac can pick up cold and execute. If you're that Claude: **read this whole section before taking action.**

### Context

The dotfiles repo recently migrated from a multi-branch strategy (master for macOS, codespace for GitHub codespaces, plus ~7 other stale env branches) to a single-branch-with-per-env-overlays layout. The branch `single-branch-migration` (PR #3, `triyangle/dotfiles`) has the new setup and has been tested on a fresh Ona workspace. The macOS path was refactored but is **not yet verified on a real Mac**. This is the first Mac test.

### Pre-upgrade state on this machine

The Mac is running the OLD layout from `master`:
- `~/dotfiles` is a git checkout on `master`
- `~/.gitconfig → ~/dotfiles/env/config/.gitconfig`
- `~/.hammerspoon → ~/dotfiles/config/home/.hammerspoon` (old location — about to move to `machines/macos/`)
- Other symlinks per `setup/symlink.sh` at the master revision
- Prezto installed at `~/.zprezto`

### Step 1: Preview layout without touching real state

Verify the new `symlink.sh` produces the expected layout by running it against a fake `$HOME`:

```bash
git clone --recurse-submodules git@github.com:triyangle/dotfiles.git /tmp/dotfiles-test
cd /tmp/dotfiles-test && git checkout single-branch-migration

FAKE=$(mktemp -d)
ln -s /tmp/dotfiles-test "$FAKE/dotfiles"
HOME="$FAKE" DOTFILES_ENV=macos bash /tmp/dotfiles-test/setup/symlink.sh

# Expected resolves:
readlink "$FAKE/.gitconfig"        # /tmp/dotfiles-test/config/home/.gitconfig
readlink "$FAKE/.gitconfig.local"  # /tmp/dotfiles-test/machines/macos/.gitconfig.local
readlink "$FAKE/.hammerspoon"      # /tmp/dotfiles-test/machines/macos/.hammerspoon
readlink "$FAKE/.slate"            # /tmp/dotfiles-test/machines/macos/.slate
readlink "$FAKE/.claude/settings.json"  # machines/macos/claude/settings.json
cat "$FAKE/.claude.json"           # should have theme/editorMode/dismissals pre-seeded
jq 'keys | length' "$FAKE/.claude.json"  # 14

# Verify ~/.codex/config.toml was assembled:
head -5 "$FAKE/.codex/config.toml"  # starts with `model_reasoning_effort = "high"`
```

If any of those fail, stop and debug the symlink.sh logic before touching the real `~/dotfiles`.

### Step 2: Real in-place upgrade

**Caveats before running:**
- Between `git checkout` and `install.sh` finishing, symlinks dangle for ~10-30s. Hammerspoon may blip; `killall Hammerspoon` before the upgrade if you care about zero flicker.
- `machines/macos/setup.sh` runs Homebrew installs (iterm2, nvim, etc.). If anything is already installed, the new `_cask_install` helper skips it. If nothing's installed this will download a lot. Review `machines/macos/setup.sh` for the exact list beforehand if you want to be sure.
- The `chsh` step uses `brew --prefix` to find zsh, so it works on both Apple Silicon (`/opt/homebrew/bin/zsh`) and Intel (`/usr/local/bin/zsh`). It'll add the brew zsh to `/etc/shells` if missing (needs sudo).

The upgrade:

```bash
killall Hammerspoon 2>/dev/null    # optional, avoids visual blip
cd ~/dotfiles
git fetch origin single-branch-migration
git checkout single-branch-migration
git submodule sync
git submodule update --init --recursive
bash install.sh
```

Open Hammerspoon again (if you killed it) — config now comes from `~/.hammerspoon → machines/macos/.hammerspoon`.

### Step 3: Post-upgrade verification

```bash
cat ~/.dotfiles-env                         # macos
readlink ~/.gitconfig                       # → dotfiles/config/home/.gitconfig
readlink ~/.gitconfig.local                 # → dotfiles/machines/macos/.gitconfig.local
git config user.email                       # willy.h.yang@gmail.com (via [include] chain)
readlink ~/.claude/settings.json            # → dotfiles/machines/macos/claude/settings.json
jq '.theme, .editorMode' ~/.claude.json     # should be present (either pre-existing user values or pre-seeded)
head -3 ~/.codex/config.toml                # model_reasoning_effort = "high"
ls ~/.tmux/plugins/                         # tpm + 6 plugins
readlink ~/.hammerspoon                     # → dotfiles/machines/macos/.hammerspoon
```

Also:
- Open a new terminal; zsh + prezto should load normally
- `which siggy` — only installed by Ona setup.sh, not macOS, so unavailable (expected)
- Open Claude Code; `claude mcp list` — macOS has no MCPs declared by default (personal mac, no Vanta tools), so list is empty. If any are there they came from your prior state, not from this dotfiles.

### Step 4: If anything breaks

**Rollback to master:**

```bash
cd ~/dotfiles
git checkout master
git submodule sync
git submodule update --init --recursive
bash setup/symlink.sh
```

That re-links everything to the old paths. Your Mac is back to its previous state.

**Report findings:** If something breaks during Mac bootstrap that we couldn't anticipate (Hammerspoon reload issue, chsh path weirdness, etc.), either:
1. Fix in `machines/macos/setup.sh` / `setup/symlink.sh` and commit to `single-branch-migration` directly
2. Leave a note in this TODO.md for the next session

### Step 5: Once Mac-verified, merge

After a successful upgrade + verification, the PR can merge. Old branches (`codespace`, `cs162vm`, `hive`, `mp`, `ocf`, `ubuntu`, `wsl`, `setup-idempotent`, `setup-packages`, `worktree-prefetch-all-users`) get deleted per the "Repo branch cleanup" item above.

## Unrelated-but-tracked

- **Auto port-forwarding for WebStorm → Ona.** Instead of `ssh -L` per session, add `LocalForward` entries to `~/.ssh/config` under the Ona host (e.g. `Host ona-*` with `LocalForward 3000 localhost:3000` etc.) + `ExitOnForwardFailure no` so conflicts don't break the connection. Open question: does Ona overwrite `~/.ssh/config` each time you paste their setup command? If so, put the forwards in a separate `Include`d file, or manage via a wrapper host entry. `~/.ssh/config` is per-machine and not typically in this dotfiles repo, but noting here to make sure the workflow gets set up.
