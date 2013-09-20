if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
eval `keychain --eval --inherit any --noask --nolock --agents ssh --quiet`
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "/tmp/ssh-auth-sock.$USER" ] ; then
  rm -f "/tmp/ssh-auth-sock.$USER"
  ln -sf $SSH_AUTH_SOCK "/tmp/ssh-auth-sock.$USER"
fi
export SSH_AUTH_SOCK="/tmp/ssh-auth-sock.$USER"
