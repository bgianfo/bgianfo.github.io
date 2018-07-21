---
layout: post
title: "Teaching lldb to de-duplicate stacks "
modified: 2017-06-18
excerpt: "I humble-brag about my first contribution to LLDB."
tags: ["debuggers", "lldb", "llvm"]
category: debuggers
comments: true
---
Recently at [work] I was debugging a [core dump] from a gigantic machine.
As I normally do, I reached for [lldb] and started to dig in.
There were more than 700 threads in the process due to the amount of processors on
the system, and figuring out what was going on was going to prove difficult.

I realized that I needed something similar to the [!uniqstack] command in [windbg].
!uniqstack is a debugger extension command (included with the uext.dll extension)
for the Windows Debugger. The extension displays all of the stacks for all of the
threads in the current process, excluding stacks that appear to have duplicates.

<!-- References -->
[lldb]: https://lldb.llvm.org
[!uniqstack]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/-uniqstack
[work]: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup
[core dump]: https://en.wikipedia.org/wiki/Core_dump
[windbg]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/
