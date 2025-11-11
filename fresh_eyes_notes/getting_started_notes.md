# 11/9/2025
CASPER TUTORIALS DAY ONE:
From [the main page](https://casper-toolflow.readthedocs.io/en/latest/), I clicked on the "CASPER Tutorials" link.

That led [here](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/).

Read [this text](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Here%20you%20will%20find%20all%20the%20current%20tutorials%20for%20the%20SNAP,%20SKARAB%20and%20Red%20Pitaya%20platforms.):
Cool. I have no idea what that means.

[What is a "GBE Tutorial?"](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=GBE%20tutorial)

This [footnote-like comment on ROACH](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Note%20that%20official%20support%20for%20ROACH%20plaforms%20is%20no%20longer%20provided,%20however%20this%20version%20of%20mlib_devel%20contains%20all%20ROACH%20related%20documentation%20and%20ROACH%20tutorials%20can%20be%20found%20here) needs to be below the table.

Read [this](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Instructions%20on%20setting%20up%20an%20environment%20in%20which%20to%20run%20these%20tutorials%20can%20be%20found%20here.).

Legitamate first reaction: Is this important? This sounds like it is something that I should do before I continue with this tutorial, right? Should I skip it?

Read [this](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Instructions%20on%20setting%20up%20the%20toolflow-proper%20can%20be%20found%20here.)

First reaction: again, how important is this? 
What is "the toolflow-*proper*?" This implies I'm using a scaled-down version of the toolflow. Is that the case? What?
Is "the toolflow" refering to MLIB_DEVEL?

Read [this](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/#:~:text=Modifications%20to%20be%20run%20after%20installs).

Wait. Hold on. Does that mean that I needed to follow some sort of install? So what I read before *is* important. Interesting.

Summary: The documentation the group has on how to VNC into Clyde or Clyde-like servers is unclear.

## How to connect to Clyde (for my future reference) 
0. (For anyone in the future) Talk to the sys-admin and get yourself an account
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
