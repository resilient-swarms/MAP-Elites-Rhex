sudo apt-add-repository ppa:libccd-debs/ppa
sudo apt-add-repository ppa:fcl-debs/ppa
sudo apt-add-repository ppa:dartsim/ppa
sudo apt-get update

sudo apt-get install build-essential cmake pkg-config git
sudo apt-get install libeigen3-dev libassimp-dev libccd-dev libfcl-dev libboost-regex-dev libboost-system-dev libode-dev
sudo apt-get install libopenscenegraph-dev

sudo apt-get install libtinyxml-dev libtinyxml2-dev
sudo apt-get install liburdfdom-dev liburdfdom-headers-dev

mkdir ~/itev2
mkdir ~/resibots

cd ~/itev2
git clone git://github.com/dartsim/dart.git
cd dart
git checkout v6.3.0

mkdir build
cd build
sudo make uninstall
cmake -DDART_ENABLE_SIMD=OFF ..
make -j4
sudo make install

cd ~/itev2
git clone https://github.com/resibots/hexapod_common.git
cd hexapod_common/hexapod_models
./waf distclean
./waf configure --prefix=$RESIBOTS_DIR
./waf install
cd ../hexapod_controller
./waf distclean
./waf configure --prefix=$RESIBOTS_DIR
./waf
./waf install

cd ~/itev2
git clone https://github.com/resibots/hexapod_simu.git
cd hexapod_simu/hexapod_dart
./waf distclean
./waf configure --prefix=$RESIBOTS_DIR
./waf
./waf install

sudo apt-get update
sudo apt-get install libeigen3-dev libboost-serialization-dev libboost-filesystem-dev libboost-test-dev libboost-program-options-dev libboost-thread-dev libboost-regex-dev libboost-graph-dev
sudo apt-get install libtbb-dev

cd ~/itev2
git clone https://github.com/resibots/limbo.git
cd limbo
mkdir exp && cd exp
git clone https://github.com/resibots/ite_v2.git
cd ..
./waf distclean
./waf configure --exp ite_v2 --no-native
./waf --exp ite_v2 --no-native
