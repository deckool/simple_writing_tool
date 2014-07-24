##Haskell starter environment on Debian droplet

#hi

### Introduction

Haskell environment in a Debian based system contains:

+ GHCi is GHC's interactive environment, in which Haskell expressions can be interactively evaluated and programs can be interpreted.
+ Cabal, the package manager

Thanks to development of Haskell Platform, the basic Haskell environment became smooth.

### Starting

We will start by creating a new droplet with debian image but these commands will also work for Ubuntu images.

> We are allready root so `sudo` is not required, yet you can and you should use it if you login with other user than root

    apt-get install haskell-platform

The Haskell platform will provide all the dependencies for the system to tun Haskell.

First of all let's say Hello World from Haskell.
For this we need to open the compiler `ghci`. To do that we run `ghci` from our console.

    $ ghci
    GHCi, version 6.12.1: http://www.haskell.org/ghc/  :? for help
    Loading package ghc-prim ... linking ... done.
    Loading package integer-gmp ... linking ... done.
    Loading package base ... linking ... done.
    Loading package ffi-1.0 ... linking ... done.
    Prelude>

> %class%
> [lala]("xxx")

[[image]("lalala")](class:glarch)

[loo bar](abbr:desc)

[the car](id:name)

[foo lar](raw:text) 

That's some text with a footnote. [^1]

[^1]: Here's a footnote with some text.