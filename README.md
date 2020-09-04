# Notes

After finding myself duck-duck-going (ducking?) the same thing a bunch of times,
searching my browser history for the same thing I searched for three weeks ago,
etc., I (_finally_) decided to start putting those things onto this page. Think
of it as my auxiliary long-term memory.

(UPDATE: [This strongly suggests](https://imgur.com/a/n24kl) I should use the
phrase 'duck it' for searching on DuckDuckGo.)

## <a name="contents">Contents</a>

[Git](#git-stuff)
- [Pruning deleted remote branches](#git-remote-prune)
- [Creating a Github repository from the command line](#gh-repo-cli)
- [Because I always forget reverting in Git](#git-revert)
- [Resolving 95% of Git conflicts](#git-conflicts)

[Shell](#shell)
- [Symlinks](#symlinks)
- [Command substitution](#cmd-sub)
- [Better zsh history](#zsh-history)
- [Excluding multiple directories with recursive grep](#grep-multi-exclude)

[Vim](#vim)
- [Formatting JSON in Vim](#vim-json)

[Mac OS](#macos)
- [Showing hidden files in Finder](#hidden-finder)

[TDD](#tdd)
- [TDD talk notes](#tdd-talk)

[Golang Resources](#golang)
- [Installing Go with Homebrew](#go-install)


## <a name="git">Git</a>

### <a name="git-remote-prune">Pruning deleted remote branches from my local copy</a>
Find out what you can prune like this:

```
git remote prune --dry-run origin
```

Then prune like this:

```
git remote prune origin
```
ht: [Why do I see a deleted remote branch?](https://stackoverflow.com/questions/17128466/why-do-i-see-a-deleted-remote-branch)

[back](#contents)

### <a name="gh-repo-cli">Creating a Github repository from the command line</a>
First, create a git repository in the usual way:
```
mkdir my-new-repo
cd my-new-repo
git init
echo '#My New Repository\nLorem ipsum.' > README.md
git add README.md
git commit -m 'Initial commit'
git remote add origin git@github.com:$(git config user.name)/my-new-repo.git
```
Then you'll need to create the repository on Github. To do this, you'll need to
create a [Github personal access token](https://github.com/settings/tokens).
It's simplest to copy it into the shell variable `GITHUB_ACCESS_TOKEN`. Then you
run this Github API command:
```
curl -u $(git config user.name):$GITHUB_ACCESS_TOKEN https://api.github.com/user/repos -d '{"name":"my-new-repo"}'
```
Finally, push the repository changes to your new remote repository:
```
git push -u origin master
```
[back](#contents)

### <a name="git-revert">Because I always forget reverting in Git</a>

[How to undo almost anything with Git](https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git/)

#### Reverting a merge commit
If you run `git log -n 1` in your repository, you should see the last commit:
```
commit 76aeb7a3054cafca4af6652edb9bcdfb3bd31e9d (HEAD -> bar, origin/bar)
Merge: 7e3b24e 2e855bc
Author: Me <me@somewhere.com>
Date:   Fri Sep 4 10:20:55 2020 -0600

    Merge branch 'foo' into bar
```
The commit hash is the one you want to revert (it's the value of HEAD). The next
two commits are the parents of that commit: the first is the immediate parent.

To revert to the commit immediately previous to the merge, use this command:
```
git revert 76aeb7a -m 1
```
And to revert to the one before that, use `-m 2` instead of `-m 1`.

[back](#contents)

### <a name="git-conflicts">Resolving 95% of Git conflicts</a>

[Quickest Way to Resolve Most Git Conflicts](https://easyengine.io/tutorials/git/git-resolve-merge-conflicts/)

[back](#contents)

## <a name="shell">Shell</a>

### <a name="symlinks">Symbolic links</a>
Get the value of a symbolic link:
```
readlink <filename>
```
Create a symbolic link:
```
ln -s <srcfile> <dest>
```
[back](#contents)

### <a name="cmd-sub">Command substitution</a>
Command substitution (run a command in a subshell and return the value within a
command):
```
$(UNIX_COMMAND)
`UNIX_COMMAND`
```
For example, here is a way to show all the machine-local users:
```
ls $(dirname ~) 
ls `dirname ~`
```
[back](#contents)

### <a name="zsh-history">Better zsh history</a>
```
# In ~/.zshrc
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
```
Then you can see your history like this:
```
$ history -E -10
  474  4.12.2019 00:08  unsetopt | grep extended
  475  4.12.2019 00:08  history 5
  476  4.12.2019 00:08  history -E
  477  4.12.2019 00:09  man zsh
  478  4.12.2019 00:09  man zshoptions | less -p EXTENDED_H
  479  4.12.2019 00:10  cat ~/.zsh_history
  480  4.12.2019 00:11  history -D
  481  4.12.2019 00:11  history -E
  482  4.12.2019 00:11  man history
  483  4.12.2019 00:12  history -10
```
This is useful for cutting down on the noise of duplicate commands:
```
# In ~/.zshrc
setopt HIST_FIND_NO_DUPS
```

More here: [Better zsh history](https://www.soberkoder.com/better-zsh-history/)

[back](#contents)
### <a name="grep-multi-exclude">Excluding multiple directories with recursive grep</a>

```
grep -r --exclude-dir={dir1,dir2,...,dirn} EXPR DIR
```
[back](#contents)

## <a name="macos">Mac OS</a>
### <a name="hidden-finder">Showing hidden files in Mac OS Finder dialog</a>
```
Command-Shift-.
```
[back](#contents)

## <a name="tdd">TDD</a>
### <a name="tdd">TDD talk notes</a>
<a name="tdd-talk">[Some notes I prepared for a collaborative tech talk on TDD](/tdd)</a>

[back](#contents)

## Vim <a name="vim"/>

### <a name="vim-json">Formatting JSON in Vim</a>
Install [jq](https://stedolan.github.io/jq/):

```
brew install jq
```

Inside vim:

```
:%!jq .
```

## <a name="golang">Golang Resources</a>

### <a name="go-install">Installing Go with Homebrew</a>
The latest version is 1.14.

You can remove earlier versions of go by removing `usr/local/bin/go`. If it is
symbolically linked, find it using `readlink` (see above).
```
brew install go
```
The tool [brew-go](https://github.com/mhinz/brew-go) is a useful Ruby gem for
managing Go tools. Install it like this:
```
gem install brew-go
```
Then you can use it like this:
```
brew go <command>
```
For example:
```
brew go get golint
```
*NB*: Golint can't be installed using `brew-go`, because it causes an error.
Brew puts Go tools into `/usr/local/Cellar/go/$GOVERSION$/bin`, so you can just
run `go get -u golang.org/x/lint/golint`, move the file from `$HOME/go/bin` to
the above directory, and create a symbolic link.

## Visual Studio Code

### Vim support

Use [Vim for Visual Studio Code](https://github.com/VSCodeVim).

#### Support for .vimrc files

It's experimental: there is now a setting for it in the plugin.

#### Repeating commands by holding a key down

OS X disables this generally. If you want to enable it for VSCode use this command:
```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```
You'll have to restart VSCode.

### Debugging Go in Visual Studio Code

You'll need the standard `launch.json` configuration:
```
{
	"version": "0.2.0",
	"configurations": [

		{
			"name": "Launch",
			"type": "go",
			"request": "launch",
			"mode": "auto",
			"program": "${fileDirname}",
			"env": {},
			"args": []
		}
	]
}
```
Install the command line Go debugger, `dlv`:
```
go get github.com/go-delve/delve/cmd/dlv
```
Make sure it's in your PATH.

Once `dlv` is installed, you should be able to set breakpoints in your Go
programs and debug them in Visual Studio Code. It's possible that you'll need to
install the XCode command-line tools so that the debugger can be launched:
```
xcode-select --install
```
#### A note on tests that depend on an environment variable being set
You can set the environment variable in your `launch.json` file, in the `env`
property, which is an object that allows the variable to be a property name.

## Testing in Go
### Running Go tests in a specific subdirectory
To run only tests in subdirectory `foo`:
```
go test ./foo
```
### Clearing test cache
```
go clean -testcache
```
## Go instructional resources

[Go Best Practices](https://www.brianketelsen.com/talks/gcru18-best/)

[Concurrency is not Parallelism](https://www.youtube.com/watch?v=cN_DpYBzKso)

[Go Proverbs](https://www.youtube.com/watch?v=PAAkCSZUG1c)

[Closures are the Generics of GO](https://www.youtube.com/watch?v=5IKcPMJXkKs)

[The Why of Go](https://www.infoq.com/presentations/go-concurrency-gc/)

[Go advanced concurrency patterns: part 3 (channels)](https://blogtitle.github.io/go-advanced-concurrency-patterns-part-3-channels/)

[An Overview of Go's Tooling](https://www.alexedwards.net/blog/an-overview-of-go-tooling)

[Practical Go](https://dave.cheney.net/practical-go/presentations/qcon-china.html)

### Go testing

[Gopter, the standard Go property-testing framework](https://github.com/leanovate/gopter)

[Property-based testing in Go](https://giedrius.blog/2019/07/08/property-based-testing-in-golang/)

[My own notes on property testing](/gopter-notes)

## Docker instructional resources

[Images and Layers](https://docs.docker.com/storage/storagedriver/)

[Anatomy of a Container](https://www.slideshare.net/mobile/jpetazzo/anatomy-of-a-container-namespaces-cgroups-some-filesystem-magic-linuxcon)

[AWS Lambda Simulation Docker Images](https://github.com/lambci/docker-lambda#run-examples)

[Digging into Docker Layers](https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612)

[Hello World](https://howtodoinjava.com/library/docker-hello-world-example/)

[AWS SAM in a Docker Container](https://medium.com/monsoon-engineering/running-aws-sam-in-a-docker-container-2491596672c2)

## Python

### Creating a minimal Python package
[Scott Torborg](https://www.scotttorborg.com/) has a nice tutorial on
[creating a minimal Python
package](https://python-packaging.readthedocs.io/en/latest/) that can be used
for distributing your software.

Essentially, you need to have a standard package structure, an `__init__.py`
file inside the main source directory, and a `setup.py` script calling
`setuptools.setup` that has an appropriate description of the package.

### Installing a Python package from Github via pip
Once you have your Python package source stored in your repository, you can
install it directly from Github in two steps. First, tag one of your commits
with a version number (or, better, make a release). Second, put this into
your `requirements.txt` file:

```
git+git://github.com/myaccount/myrepo.git@vM.m.p
```
The above assumes your release has the name `vM.m.p` (ahem, shorthand for
version Major.minor.patch).

When you've done all that, running `pip install -r requirements.txt` will
download the repository and run its `setup.py` script.
