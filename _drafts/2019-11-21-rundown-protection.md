---
layout: post
title: "Inside Rundown Protection"
excerpt: "We attempt to start learning the  elixir language."
tags: ["software", "rust", "systems programming"]
comments: true
---

## Background

Through my work, I've been exposed to many different kinds of synchronization primitives.
If you had to ask me which one stood out over the others, I think I'd say the concept of
[__Run-Down Protection__][run-down-link] which I was first exposed to when working with
the [NT kernel][nt-kernel-link].

Run-Down Protection is useful when you are attempting to do something like destroy a shared
resource. You need a way of guarantee access to the resource during it's usage, but also
guarantee that no one is using the resource when you are attempting to destroy it, and you
can deny future access to the resource after it's destruction.

## API

The rundown protection API is broken down into 5 pieces.
First you have initialization which is done by calling __ExInitializeRundownProtection__
on a pointer to the rundown reference.

```c
void ExInitializeRundownProtection(PEX_RUNDOWN_REF RunRef);
```

Next we have the two API's for gaining access to the rundown reference
__ExAcquireRundownProtection__ and __ExReleaseRundownProtection__. 
__ExAcquireRundownProtection__ returns __true__ if the acquisition was successful
and control flow can continue on and access the resource. If it returned
__false__ then the resource has been run-down and it is no longer safe
to access. If you successfully acquired rundown protection then you need
to call __ExReleaseRundownProtection__ when your access to the resource is complete.

```c
BOOLEAN ExAcquireRundownProtection(PEX_RUNDOWN_REF RunRef);
void ExReleaseRundownProtection(PEX_RUNDOWN_REF RunRef);
```

Finally we have the API's used to actually run-down a resource. These are 
__ExWaitForRundownProtectionRelease__ and __ExRundownCompleted__. 

```c
void ExWaitForRundownProtectionRelease(PEX_RUNDOWN_REF RunRef);
void ExRundownCompleted(PEX_RUNDOWN_REF RunRef); 
```

## Discussion

I like __run-down protection__ because it's just a extension of atomic
[reference counting][ref-count-link]. Acquisition of run-down protection
is just an increment of the internal reference count with a special case
to fail the request when the reference count is being run-down. Release
is just a decrement of the reference count with the extension to signal
a waiter if that is required. This simple extension results in a powerful
primitive, which provides a clean solution to a common problem. In a system
without run-down protection you end up attempting to play tricks with reference
counts and compromising that abstraction, in ways that ultimately just make
your system harder to reason about.

[run-down-link]: https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/run-down-protection
[nt-kernel-link]: https://en.wikipedia.org/wiki/Windows_NT
[ref-count-link]: https://en.wikipedia.org/wiki/Reference_counting
