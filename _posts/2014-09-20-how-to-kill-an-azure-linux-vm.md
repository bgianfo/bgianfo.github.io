---
layout: post
title: How To Kill An Azure Linux VM in 1 second.
---

{{ page.title }}
================

<p class="meta">20 September 2014 - Seattle</p>

It's super easy, just try to install the Xen HyperVisor:

{% highlight tcsh tabsize=4 %}

sudo apt-get install xen-system-amd64
reboot

{% endhighlight %}

The machine will never come up, as it will hang on boot :).
