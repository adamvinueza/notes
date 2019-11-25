# Shell commands (bash, zsh) 
Get the value of a symbolic link:
```
readlink <filename>
```
Create a symbolic link:
```
ln -s <srcfile> <dest>
```
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
# Installing Go with Homebrew
The latest version is 1.13.

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

# Creating a Github repository from the command line
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
