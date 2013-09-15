if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
eval `keychain --eval --inherit any --noask --nolock --quick --quiet`
