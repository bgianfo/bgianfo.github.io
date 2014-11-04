---
layout: post
title: "Article: The Network is Reliable"
excerpt: "We an awesome ACM article."
tags: ["distributed systems", "link post", "article"]
category: dystributed-systems
link: http://queue.acm.org/detail.cfm?id=2655736
comments: false
---
<a href="http://queue.acm.org/detail.cfm?id=2655736">
<img style="float:right; margin-left: 10px; margin-bottom: -10px;" src="/images/network-reliable-thumb.png" />
</a>
One of my favorite excerpts from the article:

> ####DRBD Split-brain####
> When a two-node cluster partitions, there are no cases in which a node can reliably declare itself to be the primary. When this happens to a DRBD file system, as one user reported ([http://serverfault.com/questions/485545/dual-primary-ocfs2-drbd-encountered-split-brain-is-recovery-always-going-to-be](http://serverfault.com/questions/485545/dual-primary-ocfs2-drbd-encountered-split-brain-is-recovery-always-going-to-be)), both nodes can remain online and accept writes, leading to divergent file system-level changes.

In this article, [Peter Bailis](http://www.bailis.org/) and [Kyle Kingsbury](http://aphyr.com/) provide an awesome sampling of real life network failures
in a variety of actively deployed distributed systems.

It's definitely worth the read, especially interesting given the data from Google, Amazon, and Microsoft. You can view the living version of the document on github: [https://github.com/aphyr/partitions-post](https://github.com/aphyr/partitions-post).
