---
layout: post
title: "Tricks for debugging python internals on Windows"
excerpt: "Digging into systems internals."
tags: ["debugging", "python", "systems programming"]
comments: true
---

## Background

At my day job I was working on a problem where I had to dig into the internals
of the Python runtime running on Windows. While I was working on this I
learned a few tips and tricks that might come in handy for someone else. To start
you'll want to debug python with the windows system debugger: [WinDbg](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/getting-started-with-windbg).
Debugging runtime like Python is convenient in Visual Studio, but in the end it's
not as powerful and features available in WinDbg will make things a lot easier.

## Symbol Support

The first thing you'll want is symbols for your python release.
There are multiple ways to get Python symbols:
- You can download them manually using this helpful [guide](https://docs.microsoft.com/en-us/visualstudio/python/debugging-symbols-for-mixed-mode-c-cpp-python?view=vs-2019).
- You can use Sean Cline's [symbol server](https://github.com/SeanCline/PythonSymbols), and the debugger will download symbols for you.

The symbol server support seems to work well, and is easy, so I would recommend that.
To add the symbol server to your WinDbg symbol path, run: 

```
1:044> .sympath+ http://pythonsymbols.sdcline.com/symbols
```

## Source Support

Now that we have symbols, next we need to get the source to line up with the code you are
debugging and stepping through. First we need to use the debugger to find out what version
of python we are debugging:

```
1:044> !filever python38.dll
filever python38.dll
GetFileVersionInfo
Version: 3.8.150.1013 
0000000f`02ca0000 0000000f`030c9000   python38
    Loaded symbol image file: python38.dll
    Image path: python38.dll
    Image name: python38.dll
    Browse all global symbols  functions  data
    Timestamp:        Mon Oct 14 12:38:17 2019 (5DA4CEA9)
    CheckSum:         0040A466
    ImageSize:        00429000
    Product version:  3.8.150.1013
    File flags:       0 (Mask 3F)
    File OS:          4 Unknown Win32
    File type:        2.0 Dll
    File date:        00000000.00000000
    Translations:     0000.04b0
    Information from resource tables:
        CompanyName:      Python Software Foundation
        ProductName:      Python
        InternalName:     Python DLL
        OriginalFilename: python38.dll
        ProductVersion:   3.8.0
        FileVersion:      3.8.0
```
The version I'm debugging appears to be based on Python 3.8.0, using that information
we can clone a copy of the cpython repository, and checkout the correct branch:

```
c:\> git clone https://github.com/python/cpython.git
c:\> pushd cpython
c:\cpython> git tag -l | findstr 3.8.0
v3.8.0
...

c:\cpython> git checkout v3.8.0
```

Finally we can fix up the source path in our debugger to point to our python source code:

```
1:044> .srcpath+ c:\cpython
```
## Dynamic Breakpoints

Another trick that might need, is the ability to inject dynamic breakpoints into the python code
in order to narrow down a bug reproduction, or catch the system in a certain state.
Unfortunately there is no way to write inline assembly in python. However we can
take advantage of the Python [ctypes library](https://docs.python.org/3/library/ctypes.html). It exposes the windll API with support for [kernel32.dll](https://en.wikipedia.org/wiki/Microsoft_Windows_library_files#KERNEL32.DLL)
exported functions. Using windll we can call into the windows implementation of [DebugBreak()](https://docs.microsoft.com/en-us/windows/win32/api/debugapi/nf-debugapi-debugbreak) via the foreign function wrapper.
This will trigger a breakpoint exception in the process, and the debugger will break into handle it.

Here's an example of using it to instrument some code:
```python
# Call DebugBreak export from kernel32
from ctypes import windll
windll.kernel32.DebugBreak()

thing_you_are_trying_to_debug()
```

## The PyExt WinDbg Extension

Discovering the [PyExt](https://github.com/SeanCline/PyExt) WinDbg extension allowed
me to start being productive and narrowing down my issue.
It's very useful for gleaning bits of information about the
python runtime while debugging and issue or analyzing a crash dump.

To install, download the latest version from the PyExt [Release Page](https://github.com/SeanCline/PyExt/releases).
Extract the zip file somewhere on disk.
Then you can load the extension into the debugger with the the following command.

```
.load C:\PyExt-x64-Release\x64\Release\pyext.dll
```

The extension exposes a few useful commands:

```
1:044> !pyext.help
Commands for C:\PyExt-x64-Release\x64\Release\pyext.dll:
  !help     - Displays information on available extension commands
  !pyobj    - Prints information about a Python object
  !pystack  - Prints the Python stack for the current thread, or starting at a
              provided PyFrameObject
  !pysymfix - Adds python symbols to the symbol path.
```

As a short cut to the steps listed above the extension provides a command to quickly
setup the python symbol server: `!pysymfix`

```
1:044> !pysymfix
Current symbol path: srv*
Adding symbol server to path...

************* Path validation summary **************
Response                         Time (ms)     Location
Deferred                                       http://pythonsymbols.sdcline.com/symbols
New symbol path: http://pythonsymbols.sdcline.com/symbols
Loading symbols...

```

The extension also allows you to traverse the runtime stack frame object and display a
stack trace of the executing python code, using the `!pystack` command.
The utilize `!pystack` we'll need to find a python stack frame pointer somewhere on on
the native call stack. Lets look around and try to find one:

```
1:044> .f+
06 0000000f`0044bfe0 0000000f`02ce9770 python38!_PyEval_EvalFrameDefault+0xaba

1:044> dv
prv param @r12  struct _frame * f = 0x0000000f`0886e800
```

We simply pass the address of the _frame object to the `!pystack` command and let it work:

```
1:045> !pystack 0x0000000f0886e800 
Stack trace starting at (PyFrameObject*)(00000008`85b46130):
    File "C:\python-3.8.0.amd64\lib\site-packages\pip\__main__.py", line 26, in <module>
                    [Locals] [Globals] 
    File "C:\python-3.8.0.amd64\lib\runpy.py", line 85, in _run_code
                    [Globals] 
    File "C:\python-3.8.0.amd64\lib\runpy.py", line 192, in _run_module_as_main
                    [Globals]
```

Next the `!pyobj` extension allows you dump python runtime variables.
Objects in the CPython implementation are of type `_object`, this
is what `!pyobj` operates on.
Lets find an example in our test case, and try dumping it's value:

```
1:049> g
Breakpoint 11 hit
python38!_io_FileIO___init___impl:
0000000f`02d3652c 48895c2410      mov     qword ptr [rsp+10h],rbx ss:0000000f`0044aff8=0000000000000002

1:049> dv nameobj
prv param  @rdx              @rdx              struct _object * nameobj = 0x0000000f`04cc2f10

1:049> !pyobj 0xf04cc2f10
PyASCIIObject at address: 0000000f`04cc2f10
    RefCount: 81
    Type: str
    Repr: 'C:\\python-3.8.0.amd64\\lib\\tempfile.py'
```

## Conclusion

These resources, tips, and tricks helped me dig into the problem I was working
on and figure out what was going on. I hope they might help out someone else out
there debugging python on windows. Thanks for reading!
