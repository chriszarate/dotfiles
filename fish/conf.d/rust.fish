# Homebrew's rustup is keg-only: its cargo/rustc shims live here rather than in
# /opt/homebrew/bin, so they need to be added to $PATH by hand. Prepend, so the
# shims win over anything a toolchain drops in ~/.cargo/bin.
if test -d /opt/homebrew/opt/rustup/bin
	fish_add_path --prepend --move /opt/homebrew/opt/rustup/bin
end
