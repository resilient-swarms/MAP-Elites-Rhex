sudo apt-get update
sudo apt-get install libeigen3-dev libboost-filesystem-dev libboost-system-dev libboost-regex-dev

sudo apt-add-repository ppa:dartsim/ppa
sudo apt-get update

sudo apt-get install build-essential cmake pkg-config git
sudo apt-get install libeigen3-dev libassimp-dev libccd-dev libfcl-dev libboost-regex-dev libboost-system-dev
sudo apt-get install libopenscenegraph-dev

sudo apt-get install libtinyxml-dev libtinyxml2-dev
sudo apt-get install liburdfdom-dev liburdfdom-headers-dev

# must edit .bashrc file with export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib:/usr/lib:/usr/local/lib

cd ~/
git clone git://github.com/dartsim/dart.git
cd dart
git checkout release-6.7

mkdir build
cd build
cmake -DDART_ENABLE_SIMD=OFF ..
make -j4
sudo make install

cd ~/
git clone https://github.com/resibots/robot_dart.git
cd robot_dart
./waf distclean
./waf configure
./waf
# ./waf install?
# ./waf configure --prefix=/path/to/install/dir --shared ?
./build/arm_plain
