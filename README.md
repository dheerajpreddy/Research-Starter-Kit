# Research-Starter-Kit
Star this repo if it's useful, I'll keep updating it if I know people are following it.

--------------------------------------------------------------------------

## Introduction

### What is this?
Basically, I wasted a lot of time trying to figure out shit before I could start my research. A lot of logistical issues, and some technical issues. While research related issues on IIIT-H are very well known and ***moderately*** well documented(like [this Ping! article](https://pingiiit.org/cracked-mia-visible-cracks-in-academia/)), I could never really find a lot of solutions. So this is my attempt at trying to make things ****slightly*** easier for anyone who's newly entering the research life at IIIT-H. This will cover **only technical** issues.

**DISCLAIMER**: I'm a CVIT boi so everything mentioned here is from my own experience. If you want to contribute regarding other labs (or even CVIT), please fork and make a pull request, I'll approve it (provided it's not too controversial since this is publicly accessible. But feel free to DM me some ***masala*** anyway 😛)

### How accurate is this?
Well, probably not very accurate. I haven't actually bothered to look up any of the things I've written here, so it's only as accurate as my mind thinks it is (which I don't think actually reflects reality). So use this at your own peril. But if you do find errors, please do suggest fixes by making pull requests.

--------------------------------------------------------------------------

## Linux basics
Okay, now I know a lot of you will cringe at this. But hey, I genuinely didn't know some of these before I started my research work. So I'm guessing a lot of you don't either. If you do, feel free to skip through all of this.

#### ssh, scp, rsync
I'm guessing you should already know this. Some examples - 
- `ssh dheerajreddy.p@ada.iiit.ac.in`
- `scp -r test_dir/ dheerajreddy.p@ada.iiit.ac.in:~/`
- `rsync -a --progress -h test.mp4 xyz@preon.iiit.ac.in:~/public_html/m.mp4`

**sidenote** - All of these work on port 22. So if any of these don't work, try allowing the port. On Ubuntu that's done by `sudo ufw allow 22`

#### tmux
tmux has a lot of use cases, but I've predominantly used them to run lengthy scripts on a remote server when not always in session. You can Google exactly what it is, but roughly it creates a terminal session that will continue to run even after you've logged out of your ssh session, so if you've got a long script to run and don't want to wait while it does, you'll definitely need tmux.
Useful commands:-
- `tmux new` - creates a new tmux session, and by default names it 0
- `tmux new -s <name_of_session>` - ALWAYS NAME YOUR TMUX SESSIONS. Or else it gets really confusing
- `tmux ls` - lists down all tmux sessions
- `tmux a -t <name_of_session>` - default would be `tmux a -t 0`- 'attaches' a tmux session, which means you can now read and type commands in that particular tmux session.
- `ctrl+B D` - Executing this from inside a tmux session 'detaches' the session, i.e., the session is still running in the background but just that you aren't directly typing/viewing it. By the way, this notation means `ctrl+B` pressed together, followed by pressing just `D`.
- `ctrl+D` - Executing this inside a tmux session kills the tmux session, and it will take you back to your regular terminal session.
**sidenote** - PLEASE BE CAREFUL IN RUNNING `ctrl+B D` and `ctrl+D`. A couple of times I've accidentally done `ctrl+D` instead of detaching the session which ended up with me losing out on a lot of data :(((

#### cron
cron is one of my favourite Linux applications. It's used to schedule jobs and it's very easy to pick up. Just enter `crontab -e` and pick the favoured editor of your choice (I prefer vim over nano 😤). Read through the text file that opens up. It has all the instructions commented out with some very nice examples. 
Some examples of cron jobs I've run -
- `0 1,4,23 * * * bash /home/football_analysis/job.sh` - Runs the bash script at 1 AM, 4 AM and 11 PM everyday
- `20 4 * * * bash /home/dheerajr/Independent_project/deploy/scraper.sh` - Runs the bash script at 4:20 AM everyday

--------------------------------------------------------------------------

## Python basics
You're probably better off Googling this part, but I'll list down a few important things I've used over the last year anyway. ALWAYS use python3. Lots of packages from `python2` are now beginning to deprecate, so even if you feel like it won't affect you if you do shit in `python2`, it'll definitely come back to bite you some day. Some packages work best on `python3.6` instead of `python3.7`. So look up documentation of any package before you begin using it. 

#### virtualenv
For most serious work you'll do, you'll be using systems on which you aren't an admin or super user. Don't bother asking anyone to give you access to install packages, no sane system admin will install packages on a per user basis. Luckily, python comes with a very handy solution to this problem - virtualenv.

Installation - `pip3 install virtualenv --user`

Usage - 
```bash
virtualenv -p python3 my_project
source my_project/bin/activate
```
To stop using virtualenv - `deactivate`

**sidenote** - You can use additional packages like `virtualenvwrapper` for easy management of your virtualenvs. But it takes more effort to set up than virtualenv. I tried to teach this when I was TA for SSAD and no one ended up using it 😩 since virtualenv does the trick as well with lesser effort in setting up. But if you're working on multiple projects simultaneously, definitely consider using `virtualenvwrapper`

#### jupyter notebook
I share a love-hate relationship with Jupyter Notebooks. They're super easy to use, but if you aren't careful you could easily screw up a lot of things. If you didn't know this already, Jupyter Notebooks are just a better version of the `ipython` interface on the terminal. You have the option to divide your code into 'cells' and view it in a nice interface on your browser. 

Installation - `pip3 install jupyter --user`

Usage - `jupyter notebook`

Using a virtualenv with a jupyter notebook - 
```bash
source projectname/bin/activate
pip install ipykernel
ipython kernel install --user --name=projectname
```
The virtualenv will now appear in the list of your kernels with the name 'projectname'

**sidenote** - I hate jupyter notebooks because even after you delete a cell, the variables still remain even though 'deleting' a cell gives you the impression that everything in it no longer exists. So any other part of the code that still uses these 'deleted' variables continue to function accurately even though they shouldn't. So please restart your kernel everytime you make changes (you know, just in case). Also, if you have any code that you intend to deploy for long periods of time or for large data, please convert all your code to a .py file and run it from the terminal. Jupyter is great to develop code, not to deploy. Use it to deploy at your own peril.

#### anaconda
Anaconda is a super powerful tool for data science. It comes with a lot of things, including a very nice virtualenv manager and easy interface to install multiple packages and different versions of python with easy integration into jupyter notebook. I've found it to be overkill for most of my projects, and I've predominantly used it to install different versions of python that would be impossible to do otherwise (specifically python3.6)

Installation - 
- Download the installer from [here](https://www.anaconda.com/distribution/#linux)
- Run the bash script

To install a specific version of python - `conda install python==$pythonversion$`

#### argparse
I want to avoid discussing about specific packages because there are just so many of them that are useful. But perhaps one of the most used ones (at least for me) is `argparse`. It allows a python script to take arguments with great ease. It's really important when you're looking to automate python scripts.

Usage example- 
```python
import argparse

parser = argparse.ArgumentParser(description="Script to upload a tar file to Google Drive")

parser.add_argument("--tar_dir", help="Path to the tar dir")
parser.add_argument("--date", help="Date for which processing needs to be done")

arguments = parser.parse_args()

tar_dir = arguments.tar_dir 
# tar_dir now stores whatever argument was passed with the --tar_dir flag
date = arguments.date 
# date now stores whatever argument was passed with the --date flag
```

--------------------------------------------------------------------------

## ADA for Dummies

--------------------------------------------------------------------------

## Documentation basics

--------------------------------------------------------------------------

## To-Do
0. Data Science basics
1. Deep learning basics
2. Computer Vision basics
