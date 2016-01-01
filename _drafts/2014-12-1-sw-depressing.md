---
layout: post
title: "Software Is Depressing"
#modified: 2014-12-01
excerpt: "We discuss how gut-wrenchingly depressing software is."
tags: ["software", "depression"]
category: commentary
comments: false
---

<!-- References -->
[lib-sml]: https://thestrangeloop.com/sessions/liberating-the-smalltalk-lurking-in-c-and-unix
[lib-sml-vid]: https://www.youtube.com/watch?v=LwicN2u6Dro
[wiki-isa]: https://en.wikipedia.org/wiki/Instruction_set
[wiki-os]: https://en.wikipedia.org/wiki/Operating_system

{% comment %}
Post Outline:

- Introduction to the idea
- Discussion of the point
- Examples of duplications
- Discussion of the fact that we can't fix the problem.
- Call to not fork, call to work together.
- Conclusion
{% endcomment %}

Sometime last year I was watching a recording of Stephen Kell's talk at the 2014 Strange
Loop conference. It was titled [Liberating the Smalltalk lurking in C and Unix](lib-sml),
the recording is available on [youtube](lib-sml-vid). The talk is great, I recommend taking
some time to watch it.

As I listened to Stephen discuss the many interoperability problems between languages,
a feeling which had been lying dormant in me for a long while surfaced once again.
It was a very deep, dark sadness. The emotion drew not from anything the speaker said,
but from a renewed realization that the path chosen by the software industry is truly
a futile, depressing effort. The amount of duplicated effort which occurs in the technology
industry is truly quite amazing.

To take a quick step back, I'm not some weird software idealist that thinks every peace
of software only needs to be written once and only once. There are admittedly a number of
semi-valid reasons for the amount of the duplication:

- Experimentation, and evaluation of new idea's and techniques.
- Compatible breaking requirements for a piece of software.
- Licensing issues.

#### Imagine the Software Utopia ####
In a theoretical software utopia, we would have none of these issues.
The key to the software utopia is that the world would never write the same piece of code twice.
There would be a single language, a single compiler for that language, a single [ISA](wiki-isa),
a single [operating system](wiki-os). There would be no software companies, only a single world
wide organization tasked to create and manage the worlds software stack.

As new idea's in software were proven and agreed upon to be superior, they would be integrated
into the uniform software stack, so that each new revision would be uniform in it's usage.
Hardware and software would be able to evolve in lockstep with one another. As new hardware is
created, all of the drivers and software necessary to support that hardware could be created
with a single unified vision from the hardware all the way up to the tightly integrated support
in the language.

#### Back To Reality ####
