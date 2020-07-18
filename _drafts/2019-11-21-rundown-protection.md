---
layout: post
title: "Inside NT Rundown Protection"
excerpt: "Digging into systems internals."
tags: ["software", "C", "rust", "systems programming"]
comments: false
---

## Background

Through my work, I've been exposed to a variety of synchronization primitives.
However once I learned about [__Run-Down Protection__][run-down-link] I was enamored
by how simple and elegant of a solution it was. I was first exposed to it when working
on a project which runs in the [NT Kernel][nt-kernel-link].

Run-Down Protection is useful when you are attempting to manage the lifetime of a
resource which is shared between components. It provides the following capabilities.

* Guarantee's a resource is accessible for the duration of it's usage.
* Guarantee's that no one is using the resource when you are attempting to destroy it.
* Guarantee's once destroyed the resource remains inaccessilble until explicitly re-initialized.
* The API is non-blocking.

## Data Structure

Run-down Protection is implemented in the Kernel, but is exposed pubickly thought the windows
driver SDK so that driver developers can use the facility in their third party drivers.

Using the windows driver SDK we can see how NT defines the EX_RUNDOWN_REF struct, which is the
key datastructure in the Run-down protection implementation.

```c
typedef struct _EX_RUNDOWN_REF
{
#define EX_RUNDOWN_ACTIVE      0x1
#define EX_RUNDOWN_COUNT_SHIFT 0x1
#define EX_RUNDOWN_COUNT_INC   (1<<EX_RUNDOWN_COUNT_SHIFT)
    union {
        __volatile ULONG_PTR Count;
        __volatile PVOID Ptr;
    };
} EX_RUNDOWN_REF, *PEX_RUNDOWN_REF;
```

We see that we have a union of a count of some sort, and a void pointer.

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

If you squint, run-down protection looks a bit like a specialization of a
reader writer lock.

[run-down-link]: https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/run-down-protection
[nt-kernel-link]: https://en.wikipedia.org/wiki/Windows_NT
[ref-count-link]: https://en.wikipedia.org/wiki/Reference_counting
[reactos-link]: https://github.com/reactos/reactos/blob/master/ntoskrnl/ex/rundown.c
