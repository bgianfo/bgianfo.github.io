---
layout: post
title: "Embracing The Mirage [Part One]"
modified: 2014-10-20
excerpt: "Jumping into the World of Unikernels."
tags: [openmirage, unikernels, learning, ocaml]
category: systems
---

As of late I have become increasingly enamored with this great research project [Mirage OS](http://www.openmirage.org/).
The team is building a library operating system, they use the term [unikernel](http://anil.recoil.org/papers/2013-asplos-mirage.pdf).
In essence this means that you write the code for your system, and at compilation time the system builds you an image which you can then
deploy to a [hypervisor](http://en.wikipedia.org/wiki/Hypervisor) running on bare metal. This image is then run virtualized, entirely on its own.
No operating system is needed to host your application, resulting the ability to better utilize cloud resources (less overhead) and much better isolation
guarantees due to VM [sandboxing](<http://en.wikipedia.org/wiki/Sandbox_(computer_security)>) which is inherit in virtualized environments.


Besides the promises of isolation and efficiency, I'm also interested in the project because of the team's choice of language for implementing their
library OS. They have chosen to use the [OCaml](https://ocaml.org/) language, for the uninitiated OCaml is an awesome language. It has inspired tons of other
languages that you might use everyday. OCaml has an great type system, which allows for quite in depth static analysis to be performed during compilation.
It has full support for functional, imperative, and object oriented programming styles.


To me the project appears to be a recipe for success, and I want to help Mirage OS become even more successful.
The project currently has the ability to compile down to both [Xen](http://en.wikipedia.org/wiki/Xen) images, as well as unix user space process.
In the coming months, I will be working on adding user space windows process support, as well as a future goal of supporting [Hyper-V](http://en.wikipedia.org/wiki/Hyper-V) images.

I've [expressed my interest](http://lists.xenproject.org/archives/html/mirageos-devel/2014-09/msg00112.html) to the Mirage OS developers mailing list, and they seem to agree this would be valuable work.
This is super exciting to me, and although there are many challenges ahead I'm sure I will learn a ton.

I'll be documenting the journey here.
