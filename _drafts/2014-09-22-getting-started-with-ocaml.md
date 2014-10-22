---
layout: post
title: Getting started with OCaml
modified: 2014-09-22
excerpt: "We setup our windows environment to use ocaml."
tags: ["learning", "ocaml", "functional programming"]
category: pl
comments: false
---

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


