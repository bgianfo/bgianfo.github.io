---
layout: post
title: "Adaptive Range Filters for Cold Data: Avoiding Trips to Siberia."
modified: 2014-10-20
excerpt: "We discuss an interesting new data structure."
tags: ["databases", "data structures"]
category: databases
comments: false
---
<a href="http://www.vldb.org/pvldb/vol6/p1714-kossmann.pdf">
<img style="float:right; margin-left: 10px;" src="/assets/images/arf-thumb.png" height="340" width="260"/>
</a>
In issue [No.14, Volume 6 of the Proceedings of the Very Large Database Endowment][pvldb] September 2013, a very interesting paper was published,
jointly from Microsoft Research and the Systems Group at ETH Zurich. 
The research focuses on a new data structure the team has developed named "Adaptive Range Filters", or ARFs for short.
ARFs are said to be to range queries, what [bloom filters][bloomfilter] are to point queries, i.e. an extremely space
and time efficient data structure capable of answer questions of set membership.

## Design 
At it's core an ARF is essentially a highly specialize [Trie].

## Implementation 

<!-- Our Sources -->
[pvldb]: http://www.vldb.org/pvldb/vol6.html
[bloomfilter]: http://en.wikipedia.org/wiki/Bloom_filter
[trie]: http://en.wikipedia.org/wiki/Trie
