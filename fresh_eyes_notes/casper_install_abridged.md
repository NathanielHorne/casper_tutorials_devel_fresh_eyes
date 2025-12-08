# Introduction

Welcome! 

This guide is the TL;DR of how to install CASPER in an appropriate environment.

CASPER Is a fickle program: it needs *incredibly* specific versions of all the software it depends upon.
Not only this, but the software that it depends upon are (generally) extremely storage-intensive.

Because of this, it is HIGHLY RECOMMENDED to work on CASPER on one of the Linux servers The Lab maintains.


For beginners reading this guide: follow parts 1 and 2.

For everyone else, skip part 1 *after* using [<font color="blue">this table</font>](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#environment-setup) to create a virtual machine with the required operating system version, along with the other software listed. Follow part 2 after this. 

# Part 1: How to connect to Clyde
0. (For anyone in the future) Talk to the sys-admin and get yourself an account.

Later in this blurb, "username" and "password" refers to the username and password for this account.

1. Connect to Caedm VPN (or be on BYU campus)

2. SSH Into Clyde

In a Linux terminal, type:
`ssh [username]@clyde.ee.byu.edu`

3. Enter your password, when challenged

4. Set VNC password

Run `vncpasswd` to set a password of your choice for your VNC account.

5. Check if VNC has been run before (sanity check)


Run `mkdir ~/.vnc` to make the computer check if the `/.vnc` folder exists.

If VNC has never been run, this folder wont exist. 

If it does not exist, then it will be created when you first run `vncserver` in the next steps.

6. Start a "vncserver" session

Run `vncserver -geometry [res_y]x[res_x] :[session number]

**IMPORTANT**: [session number] needs to be between 0-99 and unique from any other session currently running.

Run `vncserver -list` to see a list of the servers currently running.

ex.: `vncserver -geometry 1920x1080 :25`

ex.: `vncserver -geometry 1280x720 :34`

7. Type `clyde.ee.byu.edu:[session number]` in the destination bar in your VNC software (ex. Remmina)

8. Enter the VNC password you set in step 4

9 (after you are done) Use `vncserver -kill :[session number]` to free up the VNC number you used

# Part 2:How to set up CASPER

1. On a *local* (to you) Linux terminal, ssh into Clyde (see guide above)

2. Identify and create a "workspace" folder
Run:
```
cd <path_to_workspace>
mkdir workspace/
```

3. Create and navigate into an "install_script" folder in your "workspace" folder  

While in the "mlib_devel" directory, run:

`mkdir install_script`

Then:

`cd install_script`

4. SCP The install script over to your mlib_devel folder

Run:

`scp [path_to_script]/[script_name] \

[username]@clyde.ee.byu.edu://[path_to_install_script_folder]/[script_name]`

You will be asked for your password again.

Usually, the <path_to_install_script_folder> is incredibly long. 

Use the `pwd` command while the "install_script" folder is your active directory to find and copy the full path.

5. Give the script executable permissions

Run:

`chmod +x [script_name]`
This makes it so that the script can be run as a script.

6. Change your directory back out to "workspace/"

Run:

`cd ../`

7. Find out whether "python3" is installed on your system

Run:

`which python3`

If this does not return a path of directories to an install of python3, you need to install python3.

8. Find out whether "conda" is installed on your system

Run:

`conda list`

If this does not return a misc list of Python packages, you do not have conda installed.

Conda is owned by the company "Anaconda". Use their documentation to download and install "miniconda"

9. Create a Conda environemnt to run the script / CASPER inside.

Run:

`conda create --name <tasteful_name> python=3.9`

Bear in mind, this is the environment you will be working with for a while. The name is not a dealbreaker, but just be mindful to name this environment something you would not mind your colleagues seeing.

This version of python is *extremely* important as it allows the install script to run.

***More on why the environment calls for 3.9 later.***

Type "y" when Conda asks you whether or not you want to install some required Python packages.

10. Activate the conda environment

Run:

`conda activate <tasteful_name>`

## Identify dependencies for install script

11. Identify install path for "Vivado"

Run:

`ls -halt ~/../../opt/local/Xilinx/Vivado/`

If a folder "2021.1" exists, you are good to continue.

PLEASE NOTE: The success of this command means there is a system-wide install of Vivado. Do not delete or change *anything*. 

ALSO NOTE: If this command succeeds, you have the default install path. Continue to the next step.

If not, use `find ~/ -name "Vivado"` to find where it could be located for your user, in particular.

If an install path is found for your user, in particular, ***save this path***

If it cannot be found, you do not have Vivado installed.

Install it to continue. Be warned: this is a large install and requires sudo privileges

12. Identify install path for "Matlab"

Run:

`ls -halt ~/../../opt/local/MATLAB/`

If a folder "R2021a" exists, you are good to continue.

PLEASE NOTE: The success of this command means there is a system-wide install of MATLAB. Do not delete or change *anything*. 

ALSO NOTE: If this command succeeds, you have the default install path. Continue to the next step.

If not, use `find ~/ -name "MATLAB"` to find where it could be located for your user, in particular.

If an install path is found for your user, in particular, ***save this path***

If it cannot be found, you do not have MATLAB installed.

Install it to continue. Be warned: this is a large install and requires sudo privileges

13. Identify install path for "Model Composer"

Run:

`ls -halt ~/../../opt/local/Xilinx/Model_Composer`

If a folder "2021.1" exists, you are good to continue.

PLEASE NOTE: The success of this command means there is a system-wide install of Xilinx Model Composer. Do not delete or change *anything*. 

ALSO NOTE: If this command succeeds, you have the default install path. Continue to the next step.

If not, use `find ~/ -name "Model_Composer"` to find where it could be located for your user, in particular.

If an install path is found for your user, in particular, ***save this path***

If it cannot be found, you do not have Xilinx Model Composer installed.

Install it to continue. Be warned: this is a large install and requires sudo privileges

14. Run the install script:

Run:

`./install_script/[script_name]`

* When asked if the python version is correct, press enter.

["But Author,"]{style="color:#003366"} I hear you say, 
["the script specifically asks for an environment with Python *3.8.20*! You have had me set up an environment with Python *3.9.12*! Can you not *read*?!"]{style="color:#003366"}

To that I say this: when I ran an environment with Python 3.8 installed, it actually set up an environment with Python *3.8.13*. I assume having a Python version *higher* than 3.8.20 is preferable to having a Python version *lower* than 3.8.20. 

PLEASE NOTE, HOWEVER: both environments work! My personal environment runs Python 3.9 with no difference to the environment I set up with python 3.8.

The beauty about Conda is that if you run into issues in the future with what version of Python you are running, you can simply create a new environment. 

After that, you can re-run the install script (after you perform `rm -rf casper/` on your current install).

As long as you save your `.slx` design files OUTSIDE of your install of CASPER, you are fine.

NOTE: I STRONGLY RECCOMMEND YOU SAVE YOUR `.slx` DESIGN FILES TO A FOLDER *BESIDES* THE ONE YOU USED TO INSTALL CASPER (see above line) 

* When asked if the installation path is correct, confirm there is not already a folder named "casper" where you are running the install script.

If there is, cancel out of the script, delete the folder, then run the script again. Having a pre-existing "casper" folder breaks the script.

Type "Y", then press enter, once you have confirmed there is not a pre-existing "casper" folder where you are running the install script.

* Confirm you will be using Simulink by typing "y", then press enter

* If and only if you have the default install path for Vivado, press enter.

If not, type in the installation path for Vivado, then press enter.

* Follow the same logic for MATLAB and Model Composer

15. Wait for the install script to finish

16. VNC Into Clyde (see guide above)

17. Open a terminal on the VNC version of Clyde

18. On that terminal, navigate to `[path_to_workspace]/casper/xilinx/mlib_devel`

19. Once there, run `./startsg` to start CASPER-ized MATLAB

You may need to run `chmod +x startsg`, but this is unlikely.

20. Once CASPER-ized MATLAB loads, click the "SIMULINK" icon on the upper banner.

Complete! Once Simulink/Model Composer load, you are all set to begin work on a design
