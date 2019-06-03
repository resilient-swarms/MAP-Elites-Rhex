# MAP-Elites Rhex Experiments

## Changes from the original hexapod map-elites experiments
I have made some adjustments to compilation to run experiments:
1. ```export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib:/usr/lib:/usr/local/lib``` in .bashrc
2. cpp14 compilation is enforced in waf scripts, this addresses compilation errors with the std namespaces
3. The no-native option is removed in waf scripts. This adjustment prevents segmentation faults.
4. Running cmake on DART is done with ```-DDART_ENABLE_SIMD=OFF ..```

## How to compile

Since the wscripts for the rhex dart wrapper and the controller have been adjusted, when you clone these components,
you will have to replace their original wscripts with the ones provided in the ```wafscripts/``` directory, the adjustments from above are contained
within. Finally these must be renamed to "wscript" in both instances. 

### Dependencies

#### Setting up the ResiBots environment

We use the environmental `RESIBOTS_DIR` variable for easy configuration and library finding (it basically points to one folder where every local installation happens that is related to the project). Thus, before installing/compiling anything, make sure that you add this line to your `~/.bashrc` or `~/.zshrc` file:

```bash
export RESIBOTS_DIR=/path/to/installation/folder
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib:/usr/lib:/usr/local/lib
```

From now on, we assume that the `RESIBOTS_DIR` variable is set.

#### Installing DART

To simulate our rhex we are using the [DART] simulator. To install use the following procedure:

```bash
sudo apt-add-repository ppa:libccd-debs/ppa
sudo apt-add-repository ppa:fcl-debs/ppa
sudo apt-add-repository ppa:dartsim/ppa
sudo apt-get update

sudo apt-get install build-essential cmake pkg-config git
sudo apt-get install libeigen3-dev libassimp-dev libccd-dev libfcl-dev libboost-regex-dev libboost-system-dev libode-dev
sudo apt-get install libopenscenegraph-dev

sudo apt-get install libtinyxml-dev libtinyxml2-dev
sudo apt-get install liburdfdom-dev liburdfdom-headers-dev

cd /path/to/tmp/folder
git clone git://github.com/dartsim/dart.git
cd dart
git checkout v6.3.0

mkdir build
cd build
cmake -DDART_ENABLE_SIMD=OFF ..
make -j4
sudo make install
```

#### Installing the rhex common files

In order to simulate the rhex you nead to get the URDF file and the controller library:

```bash
cd /path/to/tmp/folder
git clone https://github.com/rb10g16/rhex_common.git
cd rhex_common/rhex_models
./waf configure --prefix=$RESIBOTS_DIR
./waf install
cd ../rhex_controller
./waf configure --prefix=$RESIBOTS_DIR
./waf
./waf install
```

#### Installing the DART wrapper

To facilitate the simulation we have created a simple wrapper over the DART simulator that is specific to our rhex robot:

```bash
cd /path/to/tmp/folder
git clone https://github.com/rb10g16/rhex_simu.git
cd rhex_simu/rhex_dart
./waf configure --prefix=$RESIBOTS_DIR
./waf
./waf install
```

#### Installing sferes's dependencies

```bash
sudo apt-get update
sudo apt-get install libeigen3-dev libboost-serialization-dev libboost-filesystem-dev libboost-test-dev libboost-program-options-dev libboost-thread-dev libboost-regex-dev libboost-graph-dev
sudo apt-get install libtbb-dev
```

### Compiling the experiment

- Get [Sferes2]: `git clone https://github.com/sferes2/sferes2.git`
- Go to your `sferes2` root directory
- Go to the modules folder: `cd modules`
- Get the map elites module: `git clone https://github.com/sferes2/map_elites.git`
  - Add `map_elites` to your modules.conf file in the sferes folder 
- Go back to your `sferes` directory
- Configure for compilation: `./waf configure --cpp14=yes`
    - You can add other options if you want, like: `--cpp14=yes` to force C++14 compilation
- Compile sferes2 with: `./waf`
- Create an experiment folder (if there's none) and cd to it: `mkdir exp && cd exp`
- Clone map_elites_rhex_v2: `git clone https://github.com/AranBSmith/MAP-Elites-Rhex.git`
- Go back to your `sferes2` root directory
- Configure the experiment: `./waf configure --exp MAP-Elites-Rhex --cpp14=yes` 
- Compile the experiment: `./waf --exp MAP-Elites-Rhex`

```bash
cd path/to/tmp/folder/
git clone https://github.com/sferes2/sferes2.git
cd sferes2
./waf configure --cpp14=yes
./waf
mkdir exp && cd exp
git clone git clone https://github.com/AranBSmith/MAP-Elites-Rhex.git
cd ..
./waf configure --exp MAP-Elites-Rhex --cpp14=yes
./waf --exp MAP-Elites-Rhex
```

## How to run

- Compile the experiment (as shown above)
- Run it (assuming you are on sferes2 root dir and the `RESIBOTS_DIR` folder is set properly):
    - `./build/exp/map_elites_rhex_v2/rhex_text` for text archives
    - `./build/exp/map_elites_rhex_v2/rhex_binary` for binary archives

## Aknowledgement
[Roman Buckley MEng] For developing the Rhex skeleton, dart model, and controller. 

## Funding

This work has been funded by the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (grant agreement number 637972 - ResiBots).

## LICENSE

[CeCILL]

[CeCILL]: http://www.cecill.info/index.en.html
[DART]: https://github.com/dartsim/dart
[Sferes2]: https://github.com/sferes2/sferes2
[Roman Buckley MEng]: https://github.com/rb10g16
