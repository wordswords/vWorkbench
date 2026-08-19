# Install Go if it is not already available
sudo dnf install -y golang

# Install shfmt for your user
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# Make it available in future zsh sessions
echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify
shfmt --version
