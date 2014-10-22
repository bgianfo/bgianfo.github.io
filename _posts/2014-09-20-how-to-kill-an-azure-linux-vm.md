---
layout: post
title: How To Kill An Azure Linux VM in One Second
modified: 2014-09-20
excerpt: "Fun with hypervisors."
tags: [linux, xen, azure]
category: virtualization
---
It's super easy, just try to install the Xen HyperVisor on the Ubuntu 14.0 Image.

{% highlight tcsh tabsize=4 %}

$ sudo apt-get install xen-system-amd64
$ reboot

{% endhighlight %}

The machine will never come up, as it will be hung on boot.
This appears to stem from the fact that [Hyper-V](http://en.wikipedia.org/wiki/Hyper-V) does not support nesting [Hypervisors](http://en.wikipedia.org/wiki/Hypervisor).
