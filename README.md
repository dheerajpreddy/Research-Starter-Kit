# Research-Starter-Kit
Star this repo if it's useful, I'll keep updating it if I know people are following it.

--------------------------------------------------------------------------

## Introduction

### What is this?
Basically, I wasted a lot of time trying to figure out shit before I could start my research. A lot of logistical issues, and some technical issues. While research related issues on IIIT-H are very well known and ***moderately*** well documented(like [this Ping! article](https://pingiiit.org/cracked-mia-visible-cracks-in-academia/)), I could never really find a lot of solutions. So this is my attempt at trying to make things ***slightly*** easier for anyone who's newly entering the research life at IIIT-H. This will cover **only technical** issues.

**DISCLAIMER**: I'm a CVIT boi so everything mentioned here is from my own experience. If you want to contribute regarding other labs (or even CVIT), please fork and make a pull request, I'll approve it (provided it's not too controversial since this is publicly accessible. But feel free to DM me some ***masala*** anyway 😛)

### How accurate is this?
Well, probably not very accurate. I haven't actually bothered to look up any of the things I've written here, so it's only as accurate as my mind thinks it is (which I don't think actually reflects reality). So use this at your own peril. But if you do find errors, please do suggest fixes by making pull requests.

--------------------------------------------------------------------------

## Linux basics
Okay, now I know a lot of you will cringe at this. But hey, I genuinely didn't know some of these before I started my research work. So I'm guessing a lot of you don't either. If you do, feel free to skip through all of this.

### ssh, scp, rsync
I'm guessing you should already know this. Some examples - 
- `ssh dheerajreddy.p@ada.iiit.ac.in`
- `scp -r test_dir/ dheerajreddy.p@ada.iiit.ac.in:~/`
- `rsync -a --progress -h test.mp4 xyz@preon.iiit.ac.in:~/public_html/m.mp4`

**sidenote** - All of these work on port 22. So if any of these don't work, try allowing the port. On Ubuntu that's done by `sudo ufw allow 22`

### tmux
tmux has a lot of use cases, but I've predominantly used them to run lengthy scripts on a remote server when not always in session. You can Google exactly what it is, but roughly it creates a terminal session that will continue to run even after you've logged out of your ssh session, so if you've got a long script to run and don't want to wait while it does, you'll definitely need tmux.
Useful commands:-
- `tmux new` - creates a new tmux session, and by default names it 0
- `tmux new -s <name_of_session>` - ALWAYS NAME YOUR TMUX SESSIONS. Or else it gets really confusing
- `tmux ls` - lists down all tmux sessions
- `tmux a -t <name_of_session>` - default would be `tmux a -t 0`- 'attaches' a tmux session, which means you can now read and type commands in that particular tmux session.
- `ctrl+B D` - Executing this from inside a tmux session 'detaches' the session, i.e., the session is still running in the background but just that you aren't directly typing/viewing it. By the way, this notation means `ctrl+B` pressed together, followed by pressing just `D`.
- `ctrl+D` - Executing this inside a tmux session kills the tmux session, and it will take you back to your regular terminal session.
**sidenote** - PLEASE BE CAREFUL IN RUNNING `ctrl+B D` and `ctrl+D`. A couple of times I've accidentally done `ctrl+D` instead of detaching the session which ended up with me losing out on a lot of data :(((

### cron
cron is one of my favourite Linux applications. It's used to schedule jobs and it's very easy to pick up. Just enter `crontab -e` and pick the favoured editor of your choice (I prefer vim over nano 😤). Read through the text file that opens up. It has all the instructions commented out with some very nice examples. 
Some examples of cron jobs I've run -
- `0 1,4,23 * * * bash /home/football_analysis/job.sh` - Runs the bash script at 1 AM, 4 AM and 11 PM everyday
- `20 4 * * * bash /home/dheerajr/Independent_project/deploy/scraper.sh` - Runs the bash script at 4:20 AM everyday

--------------------------------------------------------------------------

## Python basics
You're probably better off Googling this part, but I'll list down a few important things I've used over the last year anyway. ALWAYS use python3. Lots of packages from `python2` are now beginning to deprecate, so even if you feel like it won't affect you if you do shit in `python2`, it'll definitely come back to bite you some day. Some packages work best on `python3.6` instead of `python3.7`. So look up documentation of any package before you begin using it. 

### virtualenv
For most serious work you'll do, you'll be using systems on which you aren't an admin or super user. Don't bother asking anyone to give you access to install packages, no sane system admin will install packages on a per user basis. Luckily, python comes with a very handy solution to this problem - virtualenv.

Installation - `pip3 install virtualenv --user`

Usage - 
```bash
virtualenv -p python3 my_project
source my_project/bin/activate
```
To stop using virtualenv - `deactivate`

**sidenote** - You can use additional packages like `virtualenvwrapper` for easy management of your virtualenvs. But it takes more effort to set up than virtualenv. I tried to teach this when I was TA for SSAD and no one ended up using it 😩 since virtualenv does the trick as well with lesser effort in setting up. But if you're working on multiple projects simultaneously, definitely consider using `virtualenvwrapper`

### jupyter notebook
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

### anaconda
Anaconda is a super powerful tool for data science. It comes with a lot of things, including a very nice virtualenv manager and easy interface to install multiple packages and different versions of python with easy integration into jupyter notebook. I've found it to be overkill for most of my projects, and I've predominantly used it to install different versions of python that would be impossible to do otherwise (specifically python3.6)

Installation - 
- Download the installer from [here](https://www.anaconda.com/distribution/#linux)
- Run the bash script

To install a specific version of python - `conda install python==$pythonversion$`

### argparse
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
- ADA is how you access the GPUs at IIIT-H. If you're doing anything related to machine learning, you're gonna have to read this very carefully.
- Accessing ADA - `ssh dheerajreddy.p@ada.iiit.ac.in`
- There are mainly 2 types of user accounts on ADA - student and research. Student accounts have low quality of service, i.e., can access a max of only 40 CPUs and 2 GPUs. Research accounts have medium QoS, i.e., 40 CPUs and 4 GPUs. If you want to increase QoS, send an email to hpc@iiit.ac.in CCing your advisor and stating why you need more.
- ADA has two modes - regular, node
- In regular mode, you have access to no resources. You just have a CPU which you can use to transfer data. You can't even run python in this mode. This is the mode you enter in immediately after logging in. 
    - In regular mode you have access to two large scale data storage partitions - `share1` and `share2` \
          - `share1` - `/share1/<username>`
          - `share2` - `/share2`
    - Both these storage modes are accessible only in the regular mode and NOT accessible in the node mode. They can only accessed in the regular mode. Usually this space is sued to store datasets.
- In node mode, you have access to some CPU and GPU cores. This is where all your processing will be done. 
    - To enter node mode - `sinteractive -c 40 -g 2`. If you have a CVIT account use this command with the flag `-A $USER`
    - No access to `share1` or `share2` in this mode. Instead, you have `/scratch` which stores large data inside a node, but only for 10 days. After 10 days, it gets wiped out. This is only accessible inside a node, and inaccessible through regular mode. `/scratch` is unique to the particular gnode that has been assigned to you. If you have data on scratch in gnodeXX and are unable to request the same gnodeXX again, you've lost that data.
          - To request a particular node - `sinteractive -c 40 -g 2 -w gnode14`
    - Inside a node, use virtualenvs to run python scripts / jupyter notebook
          - There is no GUI to ADA, so you'll need to run jupyter notebook on some port on ADA and then forward that port to your local PC so that you can access jupyter notebook that is running on ADA through your PC. There's a neat script to do this (added to this repo as [jp.sh](https://github.com/dheerajpreddy/Research-Starter-Kit/blob/master/jp.sh). Save the script as `jp.sh` and run the following - `./jp.sh XXXX YYYY <local_PC_IP> <PC_username>`. Now you can open `localhost:YYYY` on your PC and access jupyter on your browser.
- Set a password for your jupyter notebook so that you don't need to authenticate with a key all the time - `jupyter notebook password`
- To check for nodes currently occupied by you - `squeue -u $USER`
- `sinteractive` has a time limit of 6 hours. In order to run longer codes, you'll need to write a batch job and run it using `sbatch`. Batch jobs are just bash scripts that you can submit using `sbatch batch_job.sh`
- Format of a batch job's headers -
```bash 
#!/bin/bash
#SBATCH -n 16
#SBATCH --mem-per-cpu=2048
#SBATCH --time=72:00:00
#SBATCH --mincpus=32
#SBATCH --gres=gpu:4
#SBATCH --mail-user=dheerajreddy.p@students.iiit.ac.in
#SBATCH --mail-type=ALL
module add cuda/8.0
module add cudnn/7-cuda-8.0
```
- What the headers mean
    - -n is some number, I have no idea what for. Just leave it be for now.
    - --mem-per-cpu is self explanatory, probably shouldn't change this either.
    - --time is time limit for your batch script to run. After this time, it'll stop automatically.
    - --mincpus is number of cpus you're requesting
    - --gres=gpu: is number of GPUs you're requesting
    - --mail-user= will send an email to your email after batch job completes. May not work for non-IIIT email addresses.
    - --mail-type= I have no idea
    - Last two lines are just so that you can access CUDA. I don't completely understand what it is, but without that GPUs don't work. The remainder of the batch script is essentially just a bash script. You should ideally activate your virtualenv, and then run your python scripts in there. Batch jobs always produce outputs in slurm-<batch_job_id>.out files. However, you should always print out your own logs in separate files in the format that you want so that it's easy to figure out where your code has gone wrong. You can check out an [example batch job here](https://github.com/dheerajpreddy/Research-Starter-Kit/blob/master/sample_batch_job.sh)
- You can cancel an interactive session or batch job by - `scancel <job/session_id>`
- For more (detailed) info - http://hpc.iiit.ac.in/wiki/index.php/Ada_User_Guide

**free advice** - Most batch jobs are used since the script takes too long to run. So how do I know if my script is working for sure? Just test it for small quantities first, and then if nothing bad happens, assume that nothing bad will happen for large quantities either. Usually, reducing quantities for testing implies reducing the number of time some for loop or while loop is running. If the first 100/1000/n iterations run okay in a batch job, the next 1000 x n iterations should ideally also run without any errors. Regardless, print out detailed logs so that if it goes wrong, you can just correct it and re run it later.

**more free advice** - If you want to access/check on a large amount of data that's being outputted by your batch job, you should smartly request for max number of GPUs and <cpu_limit> - 1 number of CPUs for your batch job. This is so that you can request an sinteractive session for that node with ease. It is unlikely that anyone would request for only 1 CPU on ADA, so you're almost always guaranteed to get access to it.

**even more free advice** - So you wanna be a badass and still continue to use Jupyter for production code, huh? 🙄 Well, tmux is super useful in this case. Log in, create new tmux session and then enter into a node. That way your ssh session can exit without hurting the interactive session.

--------------------------------------------------------------------------

## Extras: Using GUI Tools
If you don't prefer using terminal editors such as vim all the time or just don't have to patience to adapt to and learn a terminal driven workflow, these ssh hacks would get you on the same routine you might already be used to. 

### VS Code
VS Code over Remote SSH is not as straightforward as you might think as we don't (and can't) run scripts on the ada headnode/login node. And trying to launch VS Code Remote SSH would just lag out. These are the steps to get it right:
1. Create a normal sinteracitve session as you would
```bash
ssh user@ada
sinteractive -c 40 -g 4 -A $USER
```
2. Take note of the machine you logged into. In our case, let's assume we connected to gnode01.
3. Port forward ssh connection from the gnode via the headnode as a ProxyJump
```bash
ssh -L 6000:localhost:22 -J user@ada user@gnode01
```
4. (optional) Test the port forwarded connection
```bash
ssh -p 6000 user@localhost
```
5. Install the Remote-SSH extension from the Extension Store of VS Code
6. Create and launch the Remote SSH session as usual and enter ```ssh -p 6000 user@localhost``` when prompted for the login and voila! You're in! Alternatively enter the following in your ssh configs file on your local machine (~/.ssh/config) and choose "ada" when prompted for the Remote Server. 
```
Host ada
  HostName localhost
  Port 6000
  User user
```

### PyCharm
Remote interpreters can be configured in the same way as mentioned above. Take note that this requires a professional license of PyCharm. The folder syncing options can be configured under `Tools>Deployment`. Most of the information is already available in the [official docs](https://www.jetbrains.com/help/pycharm/configuring-remote-interpreters-via-ssh.html). 

### Sublime Text 3
Check out [rmate](https://github.com/randy3k/RemoteSubl). Note that this can open only files and not directories. 

### File Managers
Most file managers such as Nautilus (the default Gnome one) have an option to browse files over a network connection. Making use of this by using `ssh://user@ada` and bookmarking your home folder is a particularly useful file management technique. 

--------------------------------------------------------------------------

## To-Do
0. Data Science basics
1. Deep learning basics
2. Computer Vision basics
3. Documentation basics
