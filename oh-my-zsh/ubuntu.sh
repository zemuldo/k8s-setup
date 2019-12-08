echo "Updating packages"
sudo apt-get update

sudo apt upgrade

echo "Installing dependancies"
sudo apt install zsh git

sudo apt-get install powerline fonts-powerline

echo "Cloning oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo "Change Ohmy-ZSH theme to gnzh"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/g'

chsh -s /bin/zsh

echo "Syntax Highlighting for Oh My Zsh"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1

echo "Activating syntax highligthter"
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"


