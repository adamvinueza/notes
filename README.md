# TDD notes

[Some notes I prepared for a collaborative tech talk on TDD](/tdd)

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

# Debugging Go in Visual Studio Code

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
### A note on tests that depend on an environment variable being set
You can set the environment variable in your `launch.json` file, in the `env`
property, which is an object that allows the variable to be a property name.

# Testing in Go
## Running Go tests in a specific subdirectory
To run only tests in subdirectory `foo`:
```
go test ./foo
```
## Clearing test cache
```
go clean -testcache
```
# Go Instructional Resources

[Go Best Practices](https://www.brianketelsen.com/talks/gcru18-best/)

[Concurrency is not Parallelism](https://www.youtube.com/watch?v=cN_DpYBzKso)

[Go Proverbs](https://www.youtube.com/watch?v=PAAkCSZUG1c)

[Closures are the Generics of GO](https://www.youtube.com/watch?v=5IKcPMJXkKs)

[The Why of Go](https://www.infoq.com/presentations/go-concurrency-gc/)

[Go advanced concurrency patterns: part 3 (channels)](https://blogtitle.github.io/go-advanced-concurrency-patterns-part-3-channels/)

[An Overview of Go's Tooling](https://www.alexedwards.net/blog/an-overview-of-go-tooling)

[Practical Go](https://dave.cheney.net/practical-go/presentations/qcon-china.html)


# Docker Instructional Resources

[Images and Layers](https://docs.docker.com/storage/storagedriver/)

[Anatomy of a Container](https://www.slideshare.net/mobile/jpetazzo/anatomy-of-a-container-namespaces-cgroups-some-filesystem-magic-linuxcon)

[AWS Lambda Simulation Docker Images](https://github.com/lambci/docker-lambda#run-examples)

[Digging into Docker Layers](https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612)

[Hello World](https://howtodoinjava.com/library/docker-hello-world-example/)

[AWS SAM in a Docker Container](https://medium.com/monsoon-engineering/running-aws-sam-in-a-docker-container-2491596672c2)

