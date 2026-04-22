# TODO

## Migration followups

- **Verify Ona bootstrap on a fresh Ona env.** The `install.sh → setup/setup.sh` flow was designed per the Codespaces dotfiles docs but not yet tested against an actual Ona workspace. Confirm `IS_ON_ONA=true` is present at install time and that `ln -sfn <cloned-path> ~/dotfiles` resolves correctly.
- **Verify macOS bootstrap on a fresh mac.** `machines/macos/setup.sh` still uses legacy `brew cask install <name>` syntax; modern Homebrew expects `brew install --cask <name>`. Modernize when next used.
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

## Claude Code first-run

- **Plugins still need manual `/plugin install`.** Confirmed empirically on fresh Ona: `extraKnownMarketplaces` + `enabledPlugins` in `settings.json` does NOT auto-install. It only (a) pre-registers the marketplace (no `/plugin marketplace add` needed) and (b) auto-enables the plugin once installed. On a fresh Ona, after Claude Code launches, run: `/plugin install slack@claude-plugins-official`. Track other plugins here if the user adds more user-scoped ones. Consider a post-bootstrap doc line in README or a `machines/ona/setup.sh` hook that launches Claude with `--install-plugin` flags if such a CLI exists.
- **Theme + editorMode pre-seed (implemented in `setup/symlink.sh`).** `~/.claude.json` gets written with `{theme, editorMode, hasCompletedOnboarding}` only when it doesn't already exist, suppressing the first-run wizard and giving vim keybindings on fresh installs. Undocumented path but non-destructive (skipped if the file exists). Revisit if Claude Code ever exposes these in `settings.json`.

## Unrelated-but-tracked

- **Auto port-forwarding for WebStorm → Ona.** Instead of `ssh -L` per session, add `LocalForward` entries to `~/.ssh/config` under the Ona host (e.g. `Host ona-*` with `LocalForward 3000 localhost:3000` etc.) + `ExitOnForwardFailure no` so conflicts don't break the connection. Open question: does Ona overwrite `~/.ssh/config` each time you paste their setup command? If so, put the forwards in a separate `Include`d file, or manage via a wrapper host entry. `~/.ssh/config` is per-machine and not typically in this dotfiles repo, but noting here to make sure the workflow gets set up.
