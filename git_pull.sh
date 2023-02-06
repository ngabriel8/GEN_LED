#!/usr/bin/sh

# @(#) NMG/2WM - $Id:$


#### ERROR

# From https://github.com/ngabriel8/GEN_LED
# * branch            main       -> FETCH_HEAD
# hint: You have divergent branches and need to specify how to reconcile them.
# hint: You can do so by running one of the following commands sometime before
# hint: your next pull:
# hint: 
# hint:   git config pull.rebase false  # merge
# hint:   git config pull.rebase true   # rebase
# hint:   git config pull.ff only       # fast-forward only
# hint: 
# hint: You can replace "git config" with "git config --global" to set a default
# hint: preference for all repositories. You can also pass --rebase, --no-rebase,
# hint: or --ff-only on the command line to override the configured default per
# hint: invocation.
# fatal: Need to specify how to reconcile divergent branches.
#### END

# git pull origin master --allow-unrelated-histories
# git pull origin GEN_LED  --allow-unrelated-histories


git config pull.rebase false  # merge
git pull origin main --allow-unrelated-histories >err 2>&1 
grep -i error err
