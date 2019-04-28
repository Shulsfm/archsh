#!/bin/bash
mkdir ~/Downloads
cd ~/Downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
#yaourt
sudo pacman -S --noconfirm --needed wget curl git 
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --skipinteg
cd ..
rm -rf yay-bin

# i3 soft
yay -S compton ttf-font-awesome xkblayout-state lxappearance --noconfirm

echo 'Копирование конфига i3'
cd ~/.config/
wget https://github.com/Shulsfm/archsh/raw/master/files/i3.tar
sudo tar -xvf i3.tar
rm i3.tar
echo 'Ставим лого ArchLinux в меню'
wget https://github.com/Shulsfm/archsh/blob/master/files/archlinux_logo.png
sudo mv -f ~/Downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

echo 'Убираем меню граб для выбора системы?'
read -p "1 - Да, 0 - Нет: " grub_set
if [[ $grub_set == 1 ]]; then
  wget https://github.com/Shulsfm/archsh/blob/master/files/grub.tar.gz
  sudo tar -xzf grub.tar.gz -C /
  sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $grub_set == 0 ]]; then
  echo 'Пропускаем.'
fi

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/stage3.sh

echo 'Установка завершена!'
