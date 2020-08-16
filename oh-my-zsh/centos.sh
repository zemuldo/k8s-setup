echo "Updating packages"
sudo yum update

sudo yum -y upgrade

echo "Installing dependancies"
sudo yum -y install zsh git util-linux-user

echo "Setting up powerline fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts ./install.sh
sudo mkdir /usr/share/fonts
sudo cp ~/.local/share/fonts/* /usr/share/fonts

echo "Cloning oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo "Change Ohmy-ZSH theme to gnzh"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/g' ~/.zshrc

chsh -s /bin/zsh

echo "Syntax Highlighting for Oh My Zsh"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1

echo "Activating syntax highligthter"
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"


