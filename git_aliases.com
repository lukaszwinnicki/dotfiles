[alias]
    dsf = "!git diff --color $@ | diff-so-fancy"
	c = commit -am
	up = pull
	p = push
	s = status -s
	df = diff --color --color-words --abbrev
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --
    # deletes any local branch which has been deleted from the remote
    prune = fetch --prune
    # ensures that when you stash, you catch the new files you haven’t caught with a git add yet
    stash-all = stash save --include-untracked
    glog = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'

	# Show the diff between the latest commit and the current state
	d = !"git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat"

	# Merge GitHub pull request on top of the `master` branch
	mpr = "!f() { \
		if [ $(printf \"%s\" \"$1\" | grep '^[0-9]\\+$' > /dev/null; printf $?) -eq 0 ]; then \
			git fetch origin refs/pull/$1/head:pr/$1 && \
			git rebase master pr/$1 && \
			git checkout master && \
			git merge pr/$1 && \
			git branch -D pr/$1 && \
			git commit --amend -m \"$(git log -1 --pretty=%B)\n\nCloses #$1.\"; \
		fi \
	}; f"

