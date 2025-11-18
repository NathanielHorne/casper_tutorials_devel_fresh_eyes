#!/bin/bash

DEFAULT_COMPOSER="/opt/local/Xilinx/Model_Composer/2021.1"
DEFAULT_MATLAB="/opt/local/MATLAB/R2021a"
DEFAULT_XILINX="/opt/local/Xilinx/Vivado/2021.1"

# Get user input
echo "---VERIFY DEPENDENCIES---"
echo "Python path: $(which python)"
echo "Python version $(python3 --version)"
echo "If the python path is not correct and the version is not 3.8.20, or if you do not have both git and python, please abort the installation (CTRL+C) and install the packages/activate your venv before restarting."
echo -n "Press enter to continue"
read _
echo ""

echo "---GET INSTALLATION LOCATION---"
sandbox=$(pwd)/casper
invalid=true
while [ $invalid = true ]; do
	echo -n "Use installation path $sandbox? (Y/n): "
	read use_default_path
	if [ "$use_default_path" = "Y" ] || [ "$use_default_path" = "y" ]; then
		invalid=false
	elif [ "$use_default_path" = "n" ] || [ "$use_default_path" = "N" ]; then
		echo -n "Please enter the location to install: "
		read sandbox
		invalid=false
	else
		echo "Invalid input."
	fi
done
echo ""

echo "---SIMULINK SETUP---"
invalid=true
while [ $invalid = true ]; do
	echo -n "Do you plan on using simulink on this device? (y/N): "
	read xilinx_input
	if [ "$xilinx_input" = "Y" ] || [ "$xilinx_input" = "y" ]; then
		do_xilinx_setup=true;
		invalid=false
	elif [ "$xilinx_input" = "n" ] || [ "$xilinx_input" = "N" ]; then
		do_xilinx_setup=false;
		invalid=false
	else
		echo "Invalid input."
	fi
done
echo ""

if [ $do_xilinx_setup = true ]; then
	echo "It is recommended that you open a new tab in your terminal for the next few prompts. Typos may be resolved after installation is complete."
	echo "What is your absolute xilinx path? (</path/to/>Vivado/2021.1)"
	echo -n "If you don't know where to look, check $DEFAULT_XILINX. If it matches this, you can leave the path blank and type ENTER: "
	read xilinx_path
	echo "Received."
	if [ "$xilinx_path" = "" ]; then
		xilinx_path=$DEFAULT_XILINX
	fi
	echo "What is your absolute matlab path? (</path/to/>R2021a)"
	echo -n "Possible location $DEFAULT_MATLAB (if your path matches, just type ENTER): "
	read matlab_path
	if [ "$matlab_path" = "" ]; then
		matlab_path=$DEFAULT_MATLAB
	fi
	echo "Received."
	echo -n "Composer path? (</path/to/>Model_Composer/2021.1): "
	echo "Possible location $DEFAULT_COMPOSER (if your path matches, just type ENTER): "
	read composer_path
	if [ "$composer_path" = "" ]; then
		composer_path=$DEFAULT_COMPOSER
	fi
	echo "Received."
	dev_tree_xlnx="$sandbox/xilinx/device-tree-xlnx"
	echo ""
	echo "Prompts complete. To fix typos, open $sandbox/mlib_devel/startsg.local in a text editor. This statement will be shown again at the end of the installer."
fi
echo ""

echo "---CREATE BASE DIRECTORY---"
mkdir casper
cd casper
echo ""

echo "---SETUP XILINX DEVICE TREE---"
mkdir xilinx
cd xilinx
git clone https://github.com/xilinx/device-tree-xlnx.git
cd device-tree-xlnx
git fetch origin
git switch xlnx_rel_v2021.2
git reset --hard origin/xlnx_rel_v2021.2
echo ""

echo "---SETUP MLIB_DEVEL---"
cd ../
git clone https://github.com/casper-astro/mlib_devel.git
cd mlib_devel
git switch -c m2021a origin/m2021a
pip install -r requirements.txt
git submodule init
git submodule update
cp startsg.local.example ./startsg.local
if [ $do_xilinx_setup ]; then
	sed -i "s:XILINX_PATH=.*:XILINX_PATH="$xilinx_path":" startsg.local
	sed -i "s:MATLAB_PATH=.*:MATLAB_PATH="$matlab_path":" startsg.local
	sed -i "s:COMPOSER_PATH=.*:COMPOSER_PATH="$composer_path":" startsg.local
	sed -i "s:JASPER_BACKEND=.*:JASPER_BACKEND=vitis:" startsg.local
	sed -i "/JASPER_BACKEND=.*/a export XLNX_DT_REPO_PATH="$dev_tree_xlnx"" startsg.local
fi
echo ""

echo "---SETUP CASPERFPGA---"
cd ..
git clone https://github.com/casper-astro/casperfpga.git
cd casperfpga
git switch -c py38 origin/py38
pip install -r requirements.txt
pip install .
pip install ipython
sed "s/from . import progska/#from . import progska" -i ./casperfpga/casperfpga/__init__.py
echo ""

echo "---INSTALLER COMPLETE---"
if [ $do_xilinx_setup ]; then
	echo "To fix typos, open $sandbox/mlib_devel/startsg.local in a text editor."
	echo ""
fi

echo "To open simulink:"
echo "Make sure you are in $sandbox/mlib_devel"
echo 'run `./startsg`'
echo 'In the matlab session opened by the previous command, run `simulink`'
echo ""

echo "Testing casperfpga setup:"
echo 'open an IPython session (`ipython`).'
echo 'Run `import casperfpga`'
echo "This identifies most problems."
echo ""
echo "Troubleshooting:"
echo 'close ipython `exit()` and make sure you are in the casperfpga directory ($sandbox/casperfpga NOT $sandbox/casperfpga/casperfpga)'
echo 'run `pip install -r requirements.txt`'
echo 'run `pip install .`'
echo "Any further errors in import must be identified using error messages"
echo ""
echo "Optional final test (generally things work by this point):"
echo 'In ipython after successfully importing `casperfpga`, run `fpga = casperfpga.CasperFpga("<ip-address>")` '
echo 'Finally run `fpga.is_connected()`. The output should be true'
