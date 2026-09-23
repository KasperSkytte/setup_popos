# yubikey

Lets a YubiKey tap (pam_u2f) replace the password for **sudo** and **polkit prompts**,
which includes 1Password's "unlock using system authentication", pkexec and GUI admin
dialogs. It can optionally cover the login greeter and lock screen too. The password
always keeps working as a fallback.

Supports Ubuntu and Pop!_OS 22.04 / 24.04 / 26.04 (GNOME, COSMIC, KDE).

## What it detects at runtime

| Detected | Why it matters |
|---|---|
| polkit version | 0.105 (22.04) ships `/etc/pam.d/polkit-1`; 124 (24.04) ships it in `/usr/lib/pam.d`, so the role copies it to `/etc` before editing |
| `polkit-agent-helper@.service` | polkit 127+ runs PAM in a sandbox that hides `/dev/hidraw*`; the role then installs a drop-in that allows hidraw only |
| sudo vs sudo-rs | Ubuntu 25.10+ defaults to sudo-rs. It uses the same `sudo`/`sudo-i` PAM services, and `visudo` validation works for both |
| display manager | gdm3 → `gdm-password`, cosmic-greeter → `cosmic-greeter`, sddm, lightdm (only with `yubikey_login: true`) |
| installed desktops | lock screen service: GNOME → `gdm-password`, COSMIC → `cosmic-greeter`, KDE → `kde` |

The detected values are printed at the start of the run.

## Design choices

- **Central authfile** `/etc/Yubico/u2f_keys` instead of `~/.config/Yubico/u2f_keys`, so
  sandboxed callers (polkit 127+) can read it.
- **Fixed origin/appid** (`pam://yubikey`), so a hostname change or reinstall does not
  invalidate the keys. Keys enrolled with the old per-host origin must be enrolled again.
- The PAM line is inserted before the first `auth` rule / `@include common-auth` and
  replaces any older `pam_u2f.so` line in place. `common-auth` is never touched
  (`pam-auth-update` would overwrite it).

## Enrollment

**Declared (recommended, no key taps on re-provisioning):**

```bash
pamu2fcfg -n -o pam://yubikey -i pam://yubikey   # once per key, touch when it blinks
```

```yaml
yubikey_u2f_mappings:
  kapper:
    - "<KeyHandle>,<PublicKey>,es256,+presence"   # primary
    - "<KeyHandle>,<PublicKey>,es256,+presence"   # backup
```

**Interactive:** with no mappings declared, the play asks for the key's FIDO2 PIN (leave it
empty if the key has none) and waits for a touch, but only if `default_user` isn't enrolled yet.
Run the play on the laptop itself, with the key plugged in and a desktop session active.

## Main variables

| Variable | Default | |
|---|---|---|
| `default_user` | — | required |
| `yubikey_singlefactor` | `true` | `false` removes all pam_u2f lines again |
| `yubikey_login` | `false` | also greeter + lock screen. Key-only login does not unlock gnome-keyring |
| `yubikey_u2f_mappings` | `{}` | see above |
| `yubikey_pam_extra_args` | `[]` | e.g. `[debug, debug_file=syslog]`, `[pinverification=1]` |
| `yubikey_install_authenticator` | `true` | Yubico Authenticator in `~/.local/lib` |
| `yubikey_enforce_sudo_auth` | `true` | makes `%sudo` require authentication |
| `yubikey_allow_unsupported_os` | `false` | skip the OS check |

## If polkit prompts fall back to a terminal prompt / 1Password won't prompt

The desktop's polkit agent registers only once, at login. If `polkit.service` is
restarted (usually by an apt upgrade), the agent is lost until you log out and back in.
To check whether it is registered:

```bash
journalctl -b | grep 'Registered Authentication Agent' | tail -n 3
```

Debugging: set `yubikey_pam_extra_args: [debug, debug_file=syslog]`, then
`journalctl -f | grep -i u2f`.
