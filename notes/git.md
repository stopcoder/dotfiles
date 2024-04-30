# Git Global Command Shortcuts
git config --global alias.co checkout
git config --global alias.cob 'checkout -b'
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.ca "commit --amend"
git config --global alias.can "commit --amend --no-edit"

# Automatic Change-Id Generation
curl -Lo .git/hooks/commit-msg https://git.wdf.sap.corp/tools/hooks/commit-msg
chmod u+x .git/hooks/commit-msg
