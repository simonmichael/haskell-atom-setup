<!-- -*- markdown-toc-user-toc-structure-manipulation-fn:cdr; -*- -->

# Haskell Atom Setup 2016

What is the least painful way to get Haskell and a modern, user-friendly development environment set up ?
Based on my periodic attempts to set up the available Haskell IDEs, and to support newcomers on IRC,
as of early 2016 it's [stack](http://haskellstack.org) and [Atom](http://atom.io)
(unless you're on a mac and willing to pay and be in a slightly walled garden, in which case it's [Haskell for Mac](http://haskellformac.com)).

Here are some basic recipes for setting up Haskell and Atom from scratch, on any of the major platforms, as reliably and easily as possible.
They briefly note the steps required, and also the results you can expect (something that's often unclear with Haskell IDEs).
You don't need any previous Haskell knowledge, but you will need to download things, run terminal commands, wait for builds, edit files and configure settings.
With a fast connection/machine and the hints below, it should take less than half an hour, most of that unattended.

This doc will evolve as needed; please test it yourself and send pull requests.
Quick feedback via IRC is also welcome.
When it becomes obsolete (hopefully soon), or there's a much better place for it, let me know.
I hope you find it useful.

Url:         <https://github.com/simonmichael/haskell-atom-setup>  
Created:     2016/5/12 by Simon Michael (email:<simon@joyful.com>, freenode:sm)  
Updated:     2016/5/16  
Discussion:  [#haskell-atom](http://webchat.freenode.net/?channels=haskell-atom) (also: [issues](https://github.com/simonmichael/haskell-atom-setup/issues), #haskell-beginners, #haskell-stack, #haskell, #atom, haskell-cafe)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Set up Haskell](#set-up-haskell)
- [Create a minimal program in terminal](#create-a-minimal-program-in-terminal)
- [Test your program interactively in terminal](#test-your-program-interactively-in-terminal)
- [Set up Atom](#set-up-atom)
- [View your program in Atom](#view-your-program-in-atom)
- [Test your program interactively in Atom](#test-your-program-interactively-in-atom)
- [Run terminal commands in Atom](#run-terminal-commands-in-atom)
- [Create a program, package and project](#create-a-program-package-and-project)
- [Build/run/install your package](#buildruninstall-your-package)
- [More on Atom's Haskell support](#more-on-atoms-haskell-support)

<!-- markdown-toc end -->

## Set up Haskell
install stack (Haskell build tool): <http://haskellstack.org>  
add stack's bin directory to your PATH if possible. Eg:  
&nbsp;&nbsp; `echo 'export PATH=\$HOME/.local/bin:\$PATH' >> ~/.bashrc`  
install GHC (Haskell compiler): `stack setup`

## Create a minimal program in terminal
in a terminal/command/shell window:  
`echo 'main = putStrLn "hello world"' > hello.hs`  
`stack ghc hello.hs  # compile the program`  
`./hello             # run it`  

## Test your program interactively in terminal
`stack ghci`  
`:load hello.hs`  
`:main    # or any Haskell expression`  
`:reload  # after changing hello.hs`  
`:help`  
`:quit`  

<!-- ## Auto-compile your program in terminal -->
<!-- ``` -->
<!-- ghcid hello.hs -->
<!-- ``` -->
<!-- **you should see:** syntax and type errors displayed whenever hello.hs changes   -->
<!-- in a stack project (described below), you may need this instead:   -->
<!-- ``` -->
<!-- ghcid -c 'stack ghci' -->
<!-- ``` -->

## Set up Atom
install tools: `stack install ghc-mod hlint stylish-haskell ghcid  # slow`  
install Atom (text editor & IDE): <http://atom.io>  
start Atom  
install plugins: Atom Preferences -> Install,   
&nbsp;&nbsp; search for haskell, install language-haskell, ide-haskell, ide-haskell-repl, haskell-ghc-mod  
&nbsp;&nbsp; search for term3, install term3  
configure plugins: in plugin's settings,  
ide-haskell  
&nbsp;&nbsp; ?  
ide-haskell-repl  
&nbsp;&nbsp; Command Args: ghci  
&nbsp;&nbsp; Command Path: stack  # or the stack executable's absolute path, eg /usr/local/bin/stack. Don't use ~.  
haskell-ghc-mod  
&nbsp;&nbsp; Additional Path Directories: ... # eg on mac: /Users/USERNAME/.local/bin, /usr/local/bin

## View your program in Atom
File -> Open, select hello.hs  
Haskell IDE -> Toggle Panel hides/shows Error/Warning/Lint/... panes  
**you should see:**  
&nbsp;&nbsp; any syntax or type errors highlighted in place and reported in the Error pane  
&nbsp;&nbsp; any hlint cleanup suggestions highlighted in place and reported in the Lint pane  
&nbsp;&nbsp; when typing, some keywords (module, let, ...) are autocompleted (and some (import, function names, ...) are not ?)  
if Haskell IDE -> Prettify gives an error  
&nbsp;&nbsp; stylish-haskell may not be in your path if Atom was started from GUI. Try starting from terminal (on mac: open -a Atom)  
if Haskell IDE -> Prettify does nothing  
&nbsp;&nbsp; ?

## Test your program interactively in Atom
while viewing hello.hs: Haskell IDE -> Open REPL  
**you should see:** a new pane with a \*Main> prompt  
enter GHCI commands here using CTRL-enter or CMD-enter  
`:main    # or any Haskell expression`  
`:reload  # after saving changes in hello.hs`  
`:help`  
`:quit`  
You can also...

## Run terminal commands in Atom
Packages -> Term 3 -> Open New Terminal In Right Pane (eg)

## Create a program, package and project
in terminal: `stack new hello simple`  
in Atom: File -> Open, select and open the "hello" folder (with no file selected)  
**you should see:** in the sidebar,  
&nbsp;&nbsp; .stack-work  
&nbsp;&nbsp; src/  
&nbsp;&nbsp;   Main.hs     # new program, similar to hello.hs. Click to open it  
&nbsp;&nbsp; hello.cabal   # package & program properties  
&nbsp;&nbsp; LICENSE  
&nbsp;&nbsp; Setup.hs  
&nbsp;&nbsp; stack.yaml   # project properties

## Build/run/install your package
in terminal:  
`cd hello             # enter the project directory (if necessary)`  
`stack build          # build this project's program(s)`  
`stack exec -- hello  # run this project's hello program in place`  
`stack install        # install the hello program in ~/.local/bin`  
`(%USERPROFILE%\.local\bin on Windows)`  
`cd; hello            # runs the installed hello program, if your PATH is set right (see setup)`  

## More on Atom's Haskell support
if errors are not highlighted in open files on starting Atom  
&nbsp;&nbsp; make a change in source, or Haskell IDE -> gcc-mod -> Check to wake it up <https://github.com/atom-haskell/haskell-ghc-mod/issues/142>  
if errors are reported but the file compiles without error at the command line  
&nbsp;&nbsp; haskell-ghc-mod (ghc-mod) requires a workaround for multi-package stack projects <https://github.com/DanielG/ghc-mod/issues/787>  
&nbsp;&nbsp; see also <https://github.com/DanielG/ghc-mod/wiki> for other possible causes

