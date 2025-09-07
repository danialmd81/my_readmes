man-update() {
	local fish_comp_dir="/home/danial/.cache/fish/generated_completions/"
	local zinit_comp_dir="/home/danial/.local/share/zinit/completions"

	# Check dependencies
	if ! command -v fish >/dev/null 2>&1; then
		echo "Error: fish shell is not installed"
		return 1
	fi

	if ! command -v zsh-manpage-completion-generator >/dev/null 2>&1; then
		echo "Error: zsh-manpage-completion-generator is not installed"
		return 1
	fi

	# Create destination directories
	mkdir -p "$zsh_custom_comp_dir" "$zinit_comp_dir"

	# Update fish completions
	echo "Updating fish completions..."
	if ! fish -c 'fish_update_completions'; then
		echo "Error: Failed to update fish completions"
		return 1
	fi

	# Convert to zsh completions
	if ! zsh-manpage-completion-generator -dst "$zinit_comp_dir" -src "$fish_comp_dir"; then
		echo "Error: Failed to generate completions in $zinit_comp_dir"
		return 1
	fi

	echo "Successfully updated completions"
	return 0
}
