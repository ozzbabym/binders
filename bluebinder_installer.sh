#!/bin/bash


NOCOL="\033[0m" #все атрибуты по умолчанию
BLACK="\033[30m" #чёрный цвет знаков
RED="\033[31m" #красный цвет знаков
GREEN="\033[32m" #зелёный цвет знаков
YELLOW="\033[33m" #желтый цвет знаков
BLUE="\033[34m" #синий цвет знаков
PURPL="\033[35m" #фиолетовый цвет знаков
GREY="\033[37m" #серый цвет знаков


clear
echo -e "$BLUE#=============================#"
echo -e "Automatic install bluebinder to android"
echo -e "#=============================#$NOCOL"
sleep 3
echo ""


clear
echo -e "$YELLOW#=============================#"
echo -e "${RED}1${YELLOW}/${GREEN}3${YELLOW} Stage is go - install requirements"
echo -e "#=============================#$NOCOL"
sudo apt-get update
sudo apt-get install make gcc build-essential libglib2.0*-dev libsystemd-dev libbluetooth-dev -y
sleep 3


clear
echo -e "$YELLOW#=============================#"
echo -e "2/${GREEN}3${YELLOW} Stage is go - download sources"
echo -e "#=============================#$NOCOL"
GIT_BLUEBINDER=https://github.com/mer-hybris/bluebinder
GIT_BLUEBINDER2=https://github.com/OLEG-XEP/bluebinder
GIT_LIBGBINDER=https://github.com/mer-hybris/libgbinder
GIT_LIBGBINDER2=https://github.com/OLEG-XEP/libgbinder
GIT_LIBGLIBUTIL=https://git.sailfishos.org/mer-core/libglibutil
GIT_LIBGLIBUTIL2=https://github.com/OLEG-XEP/libglibutil
WORK_DIR=~/build_bluebinder

mkdir -p $WORK_DIR
cd $WORK_DIR
git clone $GIT_BLUEBINDER || git clone --depth 1 $GIT_BLUEBINDER2
git clone $GIT_LIBGBINDER || git clone --depth 1 $GIT_LIBGBINDER2
git clone $GIT_LIBGLIBUTIL || git clone --depth 1 $GIT_LIBGLIBUTIL2
sleep 3


clear
echo -e "$YELLOW#=============================#"
echo -e "${GREEN}3${YELLOW}/${GREEN}3${YELLOW} Stage is go - building files"
echo -e "#=============================#$NOCOL"
cd libglibutil
make -j$(nproc --all)
make install-dev -j$(nproc --all)
cd ..

cd libgbinder
make -j$(nproc --all)
make install-dev -j$(nproc --all)
cd ..

cd bluebinder
make -j$(nproc --all)
make install -j$(nproc --all)
cd ~
rm -rf $WORK_DIR

echo -e "$YELLOW#=============================#"
echo -e "${GREEN}Successful building. Let's enjoy!$NOCOL"
echo -e "$YELLOW#=============================#$NOCOL"
