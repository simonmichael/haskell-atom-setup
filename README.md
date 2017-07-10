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

This doc can evolve if you test it yourself and send pull requests (quick feedback via IRC is also welcome).
Note as of late 2016 I have moved from Atom to Intellij (similar features, more refined and robust)
and I've stopped updating this doc myself.

If it is obsolete or there's a much better place for it, let me know.
I hope you find it useful.

Url:         <https://github.com/simonmichael/haskell-atom-setup>  
Created:     2016/5/12 by Simon Michael (email:<simon@joyful.com>, freenode:sm)  
Updated:     2016/12/26  
Discussion:  [#haskell](http://webchat.freenode.net/?channels=haskell), [issues](https://github.com/simonmichael/haskell-atom-setup/issues), haskell-cafe list


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
1. Install `Stack`, (Haskell build tool): <http://haskell-lang.org/get-started>  
2. Add `Stack`'s bin directory to your PATH if possible.
  * Eg: `echo 'export PATH=\$HOME/.local/bin:\$PATH' >> ~/.bashrc`  
3. Install a default instance of GHC (Haskell compiler) for your user:  
  * `stack setup`

### Create a minimal program in terminal (Optional)
in a terminal/command/shell window:
```
echo 'main = putStrLn "hello world"' > hello.hs
stack ghc hello.hs  # compile the program
./hello             # run it
```

### Test your program interactively in terminal (Optional)
```
stack ghci
:load hello.hs
:main    # or any Haskell expression
:reload  # after changing hello.hs
:help
:quit
```

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
1. install tools: `stack install ghc-mod hlint stylish-haskell  # slow`  
2. install Atom (text editor & IDE): <http://atom.io>  
3. start Atom  
4. install plugins: `Atom Preferences` -> `Install`
    * `search for haskell`
        - install `language-haskell`, `ide-haskell`, `ide-haskell-repl` and `haskell-ghc-mod`

    * `search for term3`
        - install `term3`

5. configure plugins: `Atom Preferences` -> `Packagages`
  * `ide-haskell`
    - nothing ?  
  * `ide-haskell-repl`  
     - `Command Args`: `ghci`  
     - `Command Path`: `stack`  # or the stack executable's absolute path, eg /usr/local/bin/stack. Don't use ~.  
   * `haskell-ghc-mod`  
     - `Additional Path Directories`: ... # eg on mac: /Users/USERNAME/.local/bin, /usr/local/bin

### View your program in Atom
1. `File` -> `Open`, select `hello.hs` (or other file you like)
2. `Haskell IDE` -> `Toggle Panel` hides/shows `Error/Warning/Lint/...` panes  

**With an module open, you should see:**  
* Syntax or type errors highlighted in place and reported in the `Error` pane  
* Hhlint cleanup suggestions highlighted in place and reported in the `Lint` pane  
* Auto-completion when typing both Haskell keywords (`module`, `let`, etc) and local names

#### Troubleshooting
* `Haskell IDE` -> `Prettify` gives an error:
  * `stylish-haskell` may not be in your path if Atom was started from GUI. Try starting from terminal (on mac: open -a Atom)
  * The file parsing failed due to, for example, misplaced code

* if `Haskell IDE` -> `Prettify` does nothing, chances are it is already prettified

### Test your program interactively in Atom
While viewing `hello.hs`, do `Haskell IDE` -> `Open REPL` and after you should see a new pane with a `\*Main>` prompt.

Enter GHCI commands here using CTRL-enter or CMD-enter:

`:main    # or any Haskell expression`  
`:reload  # after saving changes in hello.hs`  
`:help`  
`:quit`  

### Run terminal commands in Atom
You can also run regular GHCI in a terminal pane:

`Packages` -> `Term 3` -> `Open New Terminal In Right Pane` (eg)

## Create a program, package and project

* In the terminal: `stack new hello simple`  
* In Atom: `File` -> `Open`, select and open the `hello` directory (with no file selected)  

**You should see:**, in the sidebar:
```
.stack-work  
src/  
  Main.hs     # new program, similar to hello.hs. Click to open it  
hello.cabal   # package & program properties  
LICENSE  
Setup.hs  
stack.yaml    # project properties
```

## Build/run/install your package

In the terminal:  

```
cd hello             # enter the project directory (if necessary)
stack build          # build this project's program(s)
stack exec -- hello  # run this project's hello program in place
stack install        # install the hello program in ~/.local/bin
(%USERPROFILE%\.local\bin on Windows)
cd; hello            # runs the installed hello program, if your PATH is set right (see setup)
```

## More on Atom's Haskell support

* If errors are not highlighted in open files on starting Atom  
    * `File` -> `Save` will wake it up ([haskell-ghc-mod/#142](https://github.com/atom-haskell/haskell-ghc-mod/issues/142))  
* If errors are reported but the file compiles without error at the command line  
    * in multi-package stack projects, haskell-ghc-mod (ghc-mod) requires a workaround ([ghc-mod/#787](https://github.com/DanielG/ghc-mod/issues/787))  
    * see also <https://github.com/DanielG/ghc-mod/wiki> for other possible causes
