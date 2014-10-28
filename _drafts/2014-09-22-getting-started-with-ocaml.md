---
layout: post
title: Getting started with OCaml
modified: 2014-09-22
excerpt: "We setup our windows environment to use ocaml."
tags: ["learning", "ocaml", "functional programming"]
category: pl
comments: false
---

# Setting up OCaml in MSYS2
The OCaml development environment heavily depends on a UNIX shell environment, so you'll need MSYS, which provides such an environment on Windows. 
We currently recommend MSYS2, which also provides a convenient package manager. 
You can install the compiler toolchain using MSYS2's package manager.

MSYS2 provides three environments:

* mingw32_shell.bat
* mingw64_shell.bat
* msys2_shell.bat 

For the OCaml build you should select correct batch file described below.

##32-bit build

Execute mingw32_shell.bat to run MSYS2 for a 32-bit system.

Run the following commands:
{% highlight tcsh tabsize=4 %}
$ pacman -S mingw-w64-i686-toolchain
$ pacman -S base-devel
{% endhighlight %}

To check the installation was successful, type: gcc -v.

The target should be: i686-w64-mingw32.

##64-bit build

Execute mingw64_shell.bat to run MSYS2 for a 64-bit system.

Run the following commands:
{% highlight tcsh tabsize=4 %}
$ pacman -S mingw-w64-x86_64-toolchain
$ pacman -S base-devel
{% endhighlight %}

To check the installation was successful, type: gcc -v.

The target should be: i686-w64-mingw32.

#Building Ocaml with MSYS2
{% highlight tcsh tabsize=4 %}
./configure
make
{% endhighlight %}

This will start the OCaml build.



* Install cygwin (with gcc sub system, make, patch)
* Install the Native Ocaml Port [http://protz.github.io/ocaml-installer/](http://protz.github.io/ocaml-installer/)


In a cygwin terminal:
{% highlight tcsh tabsize=4 %}

$ git clone https://github.com/ocaml/opam.git
$ cd opam
$ ./configure
$ make lib-ext
$ make
$ make install
$ make libinstall

{% endhighlight %}


