# Easy Haskell IDE Setup 2016

Public url: <http://joyful.com/haskell-ide-setup>  
Created:    2016/5/12 by Simon Michael (sm), <simon@joyful.com>. Last updated: 2016/5/15  
Discussion: #haskell-beginners, #haskell-atom, #haskell-stack, #haskell, ...

As of 2016 (Q2), what's the least painful way to get Haskell and a modern, straightforward development environment set up ?

If you're on a mac and willing to pay, it's <http://haskellformac.com>, though this may be less integrated with the Haskell ecosystem.

Otherwise, here are some recipes, intended to be cross-platform and as reliable and easy as currently possible.
I hope you find this helpful; please test it and submit improvements.
When this doc becomes obsolete/wrong or there's a much better place for it, let me know.

## Set up Haskell
install stack (haskell build tool): <http://haskellstack.org>  
add stack's bin directory to your PATH if possible (`echo 'export PATH=\$HOME/.local/bin:\$PATH' >> ~/.bashrc`)  
install GHC (haskell compiler): stack setup

## Set up Atom
install tools: `stack install ghc-mod hlint stylish-haskell ghcid  # slow`  
install Atom (editor & IDE): <http://atom.io>  
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

## Run terminal commands in Atom
Packages -> Term 3 -> Open New Terminal In Right Pane (eg)

## Create a minimal program in terminal
in a terminal/command/shell window, or a terminal pane in Atom:
```
echo 'main = putStrLn "hello world"' > hello.hs
stack ghc hello.hs  # compile the program
./hello             # run it
```

## Test your program interactively in terminal
```
stack ghci
:load hello.hs
:main    # or any haskell expression
:reload  # after changing hello.hs
:help
:quit
```

## Auto-compile your program in terminal
```
ghcid hello.hs
```
you should see: syntax and type errors displayed whenever hello.hs changes  
in a stack project (described below), you may need this instead:  
```
ghcid -c 'stack ghci'
```

## View your program in Atom
File -> Open, select hello.hs  
Haskell IDE -> Toggle Panel hides/shows Error/Warning/Lint/... panes  
you should see:  
&nbsp;&nbsp; any syntax or type errors highlighted in place and reported in the Error pane
&nbsp;&nbsp; any hlint cleanup suggestions highlighted in place and reported in the Lint pane
&nbsp;&nbsp; when typing, some keywords (module, let, ...) are autocompleted (and some (import, function names, ...) are not ?)  
if Haskell IDE -> Prettify gives an error  
&nbsp;&nbsp; stylish-haskell may not be in your path if Atom was started from GUI. Try starting from terminal (on mac: open -a Atom)  
if Haskell IDE -> Prettify does nothing  
&nbsp;&nbsp; ?

## Test your program interactively in Atom
while viewing hello.hs: Haskell IDE -> Open REPL  
you should see a new pane with a \*Main> prompt. Enter GHCI commands here using CTRL-enter or CMD-enter  
:main    # or any haskell expression  
:reload  # after saving changes in hello.hs  
:help  
:quit

## Create a program, package & project
in terminal:  
`stack new hello simple`  
in Atom: File -> Open, select and open the "hello" folder (with no file selected)  
you should see: in the sidebar,  
&nbsp;&nbsp; .stack-work  
&nbsp;&nbsp; src/  
&nbsp;&nbsp;   Main.hs     # new program, similar to hello.hs. Click to open it  
&nbsp;&nbsp; hello.cabal   # package & program properties  
&nbsp;&nbsp; LICENSE  
&nbsp;&nbsp; Setup.hs  
&nbsp;&nbsp; stack.yaml   # project properties

## Build/run/install your package
in terminal:

```
cd hello             # enter the project directory (if necessary)
stack build          # build this project's program(s)
stack exec -- hello  # run this project's hello program in place
stack install        # install the hello program in ~/.local/bin
(%USERPROFILE%\.local\bin on Windows)
cd; hello            # runs the installed hello program, if your PATH is set right (see setup)
```

## More on Atom haskell support
if errors are not highlighted in open files on starting Atom  
&nbsp;&nbsp; make a change in source, or Haskell IDE -> gcc-mod -> Check to wake it up <https://github.com/atom-haskell/haskell-ghc-mod/issues/142>  
if errors are reported but the file compiles without error at the command line  
&nbsp;&nbsp; haskell-ghc-mod (ghc-mod) requires a workaround in multi-package stack projects <https://github.com/DanielG/ghc-mod/issues/787>  
&nbsp;&nbsp; see also <https://github.com/DanielG/ghc-mod/wiki> for other possible causes

