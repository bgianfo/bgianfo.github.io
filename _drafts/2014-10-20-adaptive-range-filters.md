---
layout: post
title: "Adaptive Range Filters for Cold Data: Avoiding Trips to Siberia."
tags: ["databases", "data structures"]
category: databases
---

{{ page.title }}
================

<p class="meta">20 October 2014 - Seattle</p>
<a href="http://www.vldb.org/pvldb/vol6/p1714-kossmann.pdf">
<img style="float:right; margin-left: 10px;" src="/img/arf-thumb.png" height="200" width="160"/>
</a>
In issue [No.14, Volume 6 of the Proceedings of the Very Large Database Endowment][pvldb] September 2013, a very interesting paper was published,
jointly from Microsoft Research and the Systems Group at ETH Zurich. 
The research focuses on a new data structure the team has developed named "Adaptive Range Filters", or ARFs for short.
ARFs are said to be to range queries, what [bloom filters][bloomfilter] are to point queries, i.e. an extremely space
and time efficient data structure capable of answer questions of set membership.

#Design 
At it's core an ARF is essentially a highly specialize [Trie].
#Implementation 

<!-- Our Sources -->
[pvldb]: http://www.vldb.org/pvldb/vol6.html
[bloomfilter]: http://en.wikipedia.org/wiki/Bloom_filter
[trie]: http://en.wikipedia.org/wiki/Trie
