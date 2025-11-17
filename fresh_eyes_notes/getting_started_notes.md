# 11/17/2025

I was informed by M. Burnett that I was working on the wrong tutorials.
I need to focus on the RFSoC tutorials.

In the first tutorial, I ran a few commands:
```
mkdir casper
cd casper
git clone https://github.com/casper-astro/mlib_devel.git
cd mlib_devel
git checkout -b m2021a origin/m2021a

# install package dependencies
pip install -r requirements.txt

# initialize submodules
git submodule init
git submodule update
```

This resulted in the following string of errors:
```
You are running Setuptools on Python 2, which is no longer
supported and
>>> SETUPTOOLS WILL STOP WORKING <<<
...
https://github.com/pypa/setuptools/issues/1458
    about the steps that led to this unsupported combination.
    ************************************************************
      sys.version_info < (3,) and warnings.warn(pre + "*" * 60 + msg + "*" * 60)
    running develop
    error: can't create or remove files in install directory
    
    The following error occurred while trying to add or remove files in the
    installation directory:
    
        [Errno 13] Permission denied: '/usr/lib/python2.7/site-packages/test-easy-install-92084.write-test'
    
    The installation directory you specified (via --install-dir, --prefix, or
    the distutils default setting) was:
    
        /usr/lib/python2.7/site-packages/
    
    Perhaps your account does not have write access to this directory?  If the
    installation directory is a system-owned directory, you may need to sign in
    as the administrator or "root" account.  If you do not have administrative
    access to this machine, you may wish to choose a different installation
    directory, preferably one that is listed in your PYTHONPATH environment
    variable.
    
    For information on other options, you may wish to consult the
    documentation at:
    
      https://setuptools.readthedocs.io/en/latest/easy_install.html
    
    Please make the appropriate changes for your system and try again.
```

PLEASE NOTE: this link lead to a page that didn't exist.

```
Command "/usr/bin/python2 -c "import setuptools, tokenize;__file__='/home/nch/Documents/CASPER/RFSOC/casper/mlib_devel/src/xml2vhdl-ox/scripts/python/xml2vhdl-ox/setup.py';exec(compile(getattr(tokenize, 'open', open)(__file__).read().replace('\r\n', '\n'), __file__, 'exec'))" develop --no-deps" failed with error code 1 in /home/nch/Documents/CASPER/RFSOC/casper/mlib_devel/src/xml2vhdl-ox/scripts/python/xml2vhdl-ox
You are using pip version 8.1.2, however version 25.3 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```

PLEASE NOTE: these errors are similar, if not identical, to the errors I ran into when trying to perform the original CASPER tutorials.
This implies I need to use a virtual environment when working on Clyde. However, `venv` and `conda`, the two virtual environment packages I know about, aren't included on Clyde.

Read [the CASPER RFSoC README](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/readme.html#) to get started.
To be completely candid and transparent, I have no idea what most of this meant. 
I can guess what "direct sampling" meant, but other terms such as "mixer," "numerically controlled oscillator (NCO)," "interpolation," and "decimation" were foreign to me.

# 11/12/2025
CASPER TUTORIALS DAY TWO:

Working on installing CASPER on a VNC server on Clyde. 

Picking up where I left off: 

- Reading [installing the Toolflow](https://casper-toolflow.readthedocs.io/en/latest/src/Installing-the-Toolflow.html)....

- --> "The toolflow is very sensitive to mis-matching software versions"

Because I don't have physical access to the lab where Clyde is running, at the moment, I need to see what type of software is already installed. Using *that* information, I can reference the table listed in the documentation and see what type of hardware we're running. 
Hopefully.

Right. Okay. Let's find what operating system, MATLAB, Xilinx, Python, and subsequent mlib_devel branch / commit I should pull from.

Ran `cat /etc/os-release` when SSH'd on Clyde.

Saw:
```
NAME="Red Hat Enterprise Linux Server"
VERSION="7.9 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.9"
PRETTY_NAME="Red Hat Enterprise Linux"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.9:GA:server"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 7"
REDHAT_BUGZILLA_PRODUCT_VERSION=7.9
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="7.9"
```

Okay . . . the table on the CASPER page lists all the supported operating systems in terms of Ubuntu.
SO. What version of Ubuntu is equivalent to Red Hat Enterprise 7.9?

[Does some research]

It appears that Ubuntu isn't directly comparable to Red Hat. This is probably painfully obvious to those with more experience, but it's news to me.

So, which type of Ubuntu is *relatively* equivalent? How would I even figure that out?

[Quick Google search]

Okay. I need to find what kernel version the linux install on Clyde currently is.

ran `uname -r`

Found:
`3.10.0-1160.53.1.el7.x86_64`

Okay. What version of Ubuntu matches that kernel?

Reads a timeline w/ version history [in this WikiPedia Article](https://en.wikipedia.org/wiki/Linux_kernel_version_history).
- The kernel version *exists*. 
- It's called "Baby Fish?" Interesting.

[Searches `"baby fish" AND ubuntu`]

Nothing.

Okay . . . let's try: `ubuntu with AND "3.10" AND "kernel"`

Wow. That's interesting. Nothing is here. This feels like I'm doing something wrong.
As a user, I'm scared of downloading the wrong type of toolflow, since "the toolflow is very sensitive to mis-matching software versions."
It would be great if there was a table comparing RHEL releases to Ubuntu.

Someone says it in plaintext [in this Reddit post](https://www.reddit.com/r/linux/comments/1hhl3z/ubuntu_1310_is_now_based_on_the_latest_stable/).

Well, that doesn't match with anything on the table.

[Reads the table more closely]

Oh. We're probably running something equivalent to Ubuntu 20.04, since that's the only *other* choice listed.

Okay. 

`Ubuntu Version ≈ 20.04`

What about MATLAB?

I know from experience trying to install MATLAB on Linux for ECEn 380 that matlab versions are stored in `~/.matlab/`.

I checked there. We're running R2021a

`MATLAB Version = R2021a`

Okay. How can I find what version of Xilinx we're using?

Ran `find . -name "xilinx"` to show everything in the directories I have access to from `/home/[my_username]` that have "xilinx" in the title of the filename.

Found:
```
./.Xilinx/Vivado/2021.1/.....
``` 

`Xilinx Version = 2021.1`

Okay. This doesn't actually help us narrow down what hardware we're using.

Just out of curiosity, I ran: `find . -name "casper"`

Found: 
`./sandbox/casper_sandbox/casper`

This means we already have an installation of CASPER!
This would have been *really* good to know before I went down this rabbit hole.

**NOTE FOR FUTURE STUDENTS: Before you try to make a fresh install of CASPER, run `find . -name "casper"`**

Now that we have an install of CASPER confirmed, what do we do now?

[started to read the rest of the tutorial, just to be safe]

"Installing casperfpga using a virtual environment"

I didn't realize, at first, the importance of the *virtual* component.
Every working directory must have `casperfpga` installed. 

Is that part of the CASPER toolflow? 

Ran: "find . -name "casper*" | grep "casper*""

This made it so that I could find anything *starting* with CASPER.

Turns out, there is an entire other directory that I didn't notice before: `./sandbox/casper_sandbox/`

After rooting around this directory, I found `./sandbox/casper_sandbox/casper_workplace/Tutorial/demo/sysgen/sysgen/`

Why is that important? I found a demo file to use later.

---
Trying to install "casperfpga using a virutal environment." 

I'll be trying to use the following code since I was already at my working directory when I read this particular part of the manual and I was pretty sure I didn't already have the `casperfgpa` package installed:
```
# clone the repository to your working directory
$ cd /path/to/working/directory
$ git clone https://github.com/casper-astro/casperfpga.git
$ cd casperfpga
$ git checkout master
$ sudo pip install -r requirements.txt
$ sudo python setup.py install-->

```

`git clone...` worked just fine.

However, `git checkout master` did not work because "pathspec 'master' did not match any file(s) known to git"
So, the branch probably doesn't exist.

I used `git branch` to list all the branches associated with this repo. 

`* py38`

Okay, so instead of `git checkout master`, let's try `git checkout py38`.

Found:
```
Already on 'py38'
Your branch is up to date with 'origin/py38'.
```  

Okay. Next `sudo pip install -r requirements.txt`.

Found:
`nch is not in the sudoers file.  This incident will be reported.`

Makes sense. Let's try it without `sudo`.

Found:
```
You are running Setuptools on Python 2, which is no longer supported . . . 
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-bwoz3j/cython/
```

Odd, given that the earlier part of this code block is 
```
# remove current casperfpga install files
$ cd /usr/local/lib/python2.7/dist-packages
$ sudo rm -rf casper*
```

Just like I thought, `/usr/local/lib/python2.7/dist-packages` doesn't exist.

I ran `python --version` to see what version of Python I have access to. 
Found: `Python 2.7.5`

The first code block I ignored in "Installing casperfpga using a virtual environment" starts with `python3.8 -m venv ./cfpga_venv`

So, I tried using `man python3` to check to see if python3 was even *installed*. 

Yes. It is. However, the problem initially came up when I ran the `pip` command, since that's apparently using Python 2, not python 3.

[Quick google search]

Looks like there's a Python-3-based pip command called `pip3`. 

Running `man pip3` returns `No manual entry for pip3`, meaning this isn't installed on Clyde.

Okay. . . what does this command even *do*?

`pip install -r requirements.txt` uses pip to install every package in the requirements.txt file.

Can this be replicated without using `pip`? 

[asks ChatGPT]

Yes! Using `conda`, `poetry`, 'pipenv`, or `easy_install`.

Are any of these installed?
- Nope! I used `man [package]` to check

Alright. What packages is `requirements.txt` actually trying to install?

Used `cat requirements.txt`
```
cython
future
katcp
numpy
odict
tornado
redis
tftpy
progressbar2
#ipython reqs for py3
traitlets
jedi
parso
ipython
requests
```

Are any of these installed on Clyde?

`pip list | grep "cython"` Failed, but the command actually gave me a clue.

```
You are using pip version 8.1.2, however version 25.3 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```

I can't believe I didn't at least try this, back when the pip command first failed.

Ran `pip install --upgrade pip`
Found: the same error as before . . . 

Okay . . . 

I can't install python scripts or see which ones are installed.

Maybe this is because I don't have sudo-er access?

The next command seems to corroborate this.

Ran `python setup.py install`
Found: `[Errno 13] Permission denied: '/usr/lib64/python2.7/site-packages/test-easy-install-134211.write-test'`
Found: `Perhaps your account does not have write access to this directory?`

I agree, automated tool. Perhaps it *is* because I don't have write access.

Oddly, when I ran `cd ../`, then `ipython`, then `import casperfpga`, I actually got a novel response.

Before, I would receive an error. Something along the lines of "this doesn't exist". 

Now, it would `import casperfpga` without comment.

---

I reached out to my sys. admin. for help. She told me that I should be trying to use a Conda environment to do this process. 

Did I miss that? I don't think that was brought up, on the guide, but I could be very wrong. 

Not that I can see, actually. 

[Documentation > CASPER TUTORIALS > Environment setup]

This section:
1. Talks about the importance of using Ubuntu or Red Hat
2. Gives a table of compatibility w/ certain hardware
3. Mentions ROACH platforms are no longer supported
4. **LINKS TO AN ERROR:404 PAGE ABOUT SETTING UP THE ENVIRONMENT**
5. Links to setting up the proper toolflow.

Having this link work would have saved me about 3.5 hours of time. It would be in the lab's best financial interest for future students to have a working version of this link.

I used `"conda" inurl:casper-toolflow.readthedocs.io` to find [the page that talks about setting up these environments.](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/tut_getting_started.html)

**FUTURE STUDENTS / FUTURE ME WHEN I'M UPDATING THIS DOCUMENTATION: START BY READING THIS GUIDE.**


Trying to follow this guide:
Okay. Clyde can't do this, at least not in the configuration I have right now.

Clyde doesn't have a manual (`man` command) entry for `conda` or `venv`, the two environment generators the guide mentions.

Getting Conda setup on my personal linux machine (now an Ubuntu PC) wasn't hard. Just needed to make an account, then download the installer from the website.


This is where I'll have to start tomorrow. 

---
# 11/9/2025
CASPER TUTORIALS DAY ONE:

**Summary**: the process to get to the "Installing the Toolflow" page was an unclear slog of about 2 hours.

**Path taken**: Main Page --> Tutorials / Environment setup / "instructions on setting up the . . ." --> the *entire* "CASPER Toolflow" page until "Setup Links / Installing the Toolflow" at the *bottom* --> "Installing the Toolflow" page.

As shown in my journal below, getting to "Installing the Toolflow" page was a hastle and a half. I HIGHLY recommend fixing this to be one of (if not the) first thing a new user sees. 

From [the main page](https://casper-toolflow.readthedocs.io/en/latest/), I clicked on the "CASPER Tutorials" link.

That led [here](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/).

Read [this text](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Here%20you%20will%20find%20all%20the%20current%20tutorials%20for%20the%20SNAP,%20SKARAB%20and%20Red%20Pitaya%20platforms.):
Cool. I have no idea what that means.

[What is a "GBE Tutorial?"](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=GBE%20tutorial)

This [footnote-like comment on ROACH](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Note%20that%20official%20support%20for%20ROACH%20plaforms%20is%20no%20longer%20provided,%20however%20this%20version%20of%20mlib_devel%20contains%20all%20ROACH%20related%20documentation%20and%20ROACH%20tutorials%20can%20be%20found%20here) needs to be below the table.

Read [this](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Instructions%20on%20setting%20up%20an%20environment%20in%20which%20to%20run%20these%20tutorials%20can%20be%20found%20here.).

- Legitamate first reaction: Is this important? This sounds like it is something that I should do before I continue with this tutorial, right? Should I skip it?

Read [this](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Instructions%20on%20setting%20up%20the%20toolflow-proper%20can%20be%20found%20here.)

- First reaction: again, how important is this? 
What is "the toolflow-*proper*?" This implies I'm using a scaled-down version of the toolflow. Is that the case? What?
- Is "the toolflow" refering to MLIB_DEVEL?

Read [this](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Modifications%20to%20be%20run%20after%20installs).

- Wait. Hold on. Does that mean that I needed to follow some sort of install? So what I read before *is* important. Interesting.

Clicks "[here](https://github.com/casper-astro/tutorials_devel/blob/workshop2019/README.md)" to see "[instruction on setting up an environment in which to run these tutorials](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=instructions%20on%20setting%20up%20an%20environment%20in%20which%20to%20run%20these%20tutorials)" and is met with a 404 error:

- Lovely! Why is this missing? This seems like an incredibly important thing to be missing. Where can I find it?

**THE DOCUMENTATION ON HOW TO INSTALL / SETUP THE ENVIRONMENT TO ACTUALLY DO THE TUTORIALS IS MISSING**

Clicks "[here](https://casper-toolflow.readthedocs.io/en/latest/index.html)" to see "[Instructions on setting up the toolflow-proper](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Instructions%20on%20setting%20up%20the%20toolflow-proper)" and finds a whole other guide.

- Okay . . . so does this mean that this is the place where I find the documentation on how to install the toolflow?

- --> reads [What is mlib_devel?](https://casper-toolflow.readthedocs.io/en/latest/#:~:text=What%20is%20mlib_devel).

- --> Okay! This actually answers my earlier question on *what* the toolflow actually is. Why isn't this discussed in the tutorials section?


Clicks [this link](https://casper-toolflow.readthedocs.io/en/latest/) found [here](https://casper-toolflow.readthedocs.io/en/latest/#:~:text=the%20project's%20documentation):

- A link that points towards itself . . . that wasn't helpful.


Confusing wording here: "The software stack you will require to use the toolflow will depend what hardware you are targeting."

Recommendation: "The software stack you will run the toolflow on depends on your target hardware."


Clicks [this link](https://casper-toolflow.readthedocs.io/en/latest/src/Installing-the-Toolflow.html) found under the "Setup Links" tab at the bottom of the "CASPER Toolflow" page.

- **WHY DOES *THIS* LINK WORK, BUT THE ONE IN THE TUTORIALS PAGE DOESN'T?**

- Follow-up Question: is this tool named "MLIB_DEVEL" or "CASPER?" I am confused.

Reading [installing the Toolflow](https://casper-toolflow.readthedocs.io/en/latest/src/Installing-the-Toolflow.html)....

"The toolflow is very sensitive to mis-matching software versions"

*and* hardware, apparently. 

**WHERE CAN I FIND WHAT THE LAB IS USING AND WHERE?**


Summary: The documentation the group has on how to VNC into Clyde or Clyde-like servers is unclear.

## How to connect to Clyde (for my future reference) 
0. (For anyone in the future) Talk to the sys-admin and get yourself an account.
When I say "username" and "password" later in this blurb, I'm refering to the information included in this account.
1. Connect to Caedm VPN (or be on BYU campus proper) 
2. SSH Into Clyde
`ssh [username]@clyde.ee.byu.edu`
3. Enter your password, when challenged
4. Set VNC password
Run `vncpasswd` to set a password of your choice for your VNC account. 
5. Check if VNC has been run before (sanity check)
Run `mkdir ~/.vnc` to make the computer check if the `/.vnc` folder exists.
If VNC has never been run, this folder won't exist. It needs to exist for VNC to run, though. 
6. Start a "vncserver" session
Run `vncserver -geometry [res_y]x[res_x] :[session number]

**IMPORTANT**: [session number] needs to be between 0-99 and unique from any other session currently running. 
Run `vncserver -list` to see a list of the servers currently running.

ex.: `vncserver -geometry 1920x1080 :25`
ex.: `vncserver -geometry 1280x720 :34`

7. Type `clyde.ee.byu.edu:[session number]` in the destination bar in your VNC software.

8. Enter the VNC password you set in step 4

9. Enjoy 

---
# 11/8/2025 
Summary: could not RDP into CASPER, SSH non-operable

More details:
When trying to connect to Clyde using RDP, the following systems were unable to connect:
1. My Windows PC (with CAEDM VPN enabled)
2. My Linux Mint laptop (with CAEDM VPN enabled)
3. A server on the same network (Tycho.ee.byu.edu), even in administrator mode

As a sanity check, I tried several things to try to make it so that I could troubleshoot the problem.
My systems could connect to other servers. This was not an issue.

Clyde was visible on the network as `10.5.113.155` using the command `nslookup clyde.ee.byu.edu`.
When I used this in RDP applications on all systems, they still could not connect to Clyde.

An earlier message from M. Burnett states that Clyde is `10.5.113.218`.
Again, all systems cannot connect to this IP.

I attempted to connect to Clyde via SSH.
This produced the best results. I first SSH'd into my CAEDM account from my linux laptop, then SSH'd into Clyde.
After providing my username and password, I was let in. From there, a cute textmoji of an alpaca giving a Calvin and Hobbes joke appeared.
Unfortunately, I was unauthorized to create directories once I was in Clyde.

If there's a way to access the JDrive via the command line, I could copy over the files for CASPER over.
These files would also include the setup script that R. Poll sent over, at the suggestion of J. Naylor.:`

I'm stumped as to *why* I can't connect to Clyde via RDP, but can over SSH.

Installer included here: [installer](../install_script/casper_installer_7_9_25_jaxson.sh)

**QUESTIONN FOR THE GROUP:** What is going on? Why can't I connect to Clyde?

*MY PLAN MOVING FORWARD:* See if there's a way to dual-boot into my personal machine, using an extra hard drive I have.
Why would I do this? CASPER Needs to run on a *powerful* Linux environment--something my laptop cannot provide.

---
# 11/7/2025
Essential startup script provided by R. Poll. 

---
# 11/6/2025
Login details for remoting into Clyde.ee.byu.edu were confirmed with R. Haymore.
