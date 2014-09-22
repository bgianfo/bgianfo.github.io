---
layout: post
title: Getting started with OCaml
tags: [learning, ocaml]
category: systems
---

{{ page.title }}
================

<p class="meta">22 September 2014 - Seattle</p>

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


