echo "Updating packages"
sudo yum update

sudo yum upgrade

echo "Installing dependancies"
sudo yum install zsh git

sudo yum install powerline fonts-powerline

echo "Cloning oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo "Change Ohmy-ZSH theme to gnzh"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/g'

chsh -s /bin/zsh

echo "Syntax Highlighting for Oh My Zsh"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts ./install.sh
mkdir /usr/share/fonts cp /root/.local/share/fonts/* /usr/share/fonts
cd

echo "Activating syntax highligthter"
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"


