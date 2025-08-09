man-update() {
  fish -c 'fish_update_completions'
  zsh-manpage-completion-generator -dst ~/.zsh/custom/zsh-completion-generator/completions
}