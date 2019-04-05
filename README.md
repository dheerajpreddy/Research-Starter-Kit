# Research-Starter-Kit
Star this repo if it's useful, I'll keep updating it if I know people are following it.

--------------------------------------------------------------------------

## Introduction

### What is this?
Basically, I wasted a lot of time trying to figure out shit before I could start my research. A lot of logistical issues, and some technical issues. While research related issues on IIIT-H are very well known and ***moderately*** well documented(like [this Ping! article](https://pingiiit.org/cracked-mia-visible-cracks-in-academia/)), I could never really find a lot of solutions. So this is my attempt at trying to make things ****slightly*** easier for anyone who's newly entering the research life at IIIT-H. This will cover **only technical** issues.

**DISCLAIMER**: I'm a CVIT boi so everything mentioned here is from my own experience. If you want to contribute regarding other labs (or even CVIT), please fork and make a pull request, I'll approve it (provided it's not too controversial since thisis publicly accessible. But feel free to DM me some ***masala*** anyway 😛)

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


--------------------------------------------------------------------------

## ADA for Dummies

--------------------------------------------------------------------------

## What next?
1. Deep learning basics
2. Computer Vision basics
