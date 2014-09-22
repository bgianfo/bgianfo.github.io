---
layout: post
title: Embracing The Mirage
tags: [openmirage, unikernels, learning, ocaml]
category: systems
---

{{ page.title }}
================

<p class="meta">22 September 2014 - Seattle</p>

As of late I have become increasingly enamored with this great research project [OpenMirage](http://www.openmirage.org/).
The team is building a library operating system, they use the term [unikernel](http://anil.recoil.org/papers/2013-asplos-mirage.pdf).
In essence this means that you write the code for your system, and at compilation time the system builds you an image which you can then
deploy to a [hypervisor](http://en.wikipedia.org/wiki/Hypervisor) running on bare metal. This image is then run virtualized, entirely on it's own.
No operating system is needed to hose your app, resulting the ability to better utilize cloud resources (less overhead) and much better isolation
guarantee's due to VM [sandboxing](http://en.wikipedia.org/wiki/Sandbox_(computer_security)) which is inherit in virtualized environments.

Besides the promises of isolation, and efficiency I'm also interested in the project because of their choice of language for implementing their
library OS. They have chosen to use [OCaml](https://ocaml.org/), for the uninitiated OCaml is an awesome language, it has inspired tons of other
languages that you might use everyday. OCaml has an great type system, which allows for quite in depth static analysis to be performed during compilation.
It has full support for functional, imperative, and object oriented programming styles.

To me it appears to be a recipe for success, and I want to help OpenMirage become even more successful.
The project currently can build your code as a [Xen](http://en.wikipedia.org/wiki/Xen) vm images, as well as Unix user space process (for debugging).

#TODO!!! Talk about windows support

