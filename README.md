# Shell commands (bash, zsh) 
Get the value of a symbolic link:
```
readlink <filename>
```
Create a symbolic link:
```
ln -s <srcfile> <dest>
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
