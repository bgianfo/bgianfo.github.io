---
layout: post
title: "Mystery: HORIPAD for the switch controller not working with Steam on Linux?"
excerpt: "Delving into usb devices."
tags: ["linux", "switch"]
category: guide
comments: true
---

I just picked up a [HORIPAD][horipad-link] for the Switch.
Hoping I could use it with Steam on my Linux box in addition to the switch, I plugged it into my system running the 5.0-rc1 kernel.
It was a bit to my surprise, but it showed up as a recognised device:

{% highlight tcsh tabsize=4 %}
$ dmesg

... snip ...
[    2.665567] input: HORI CO.,LTD. HORIPAD S as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:0F0D:00C1.0001/input/input8
[    2.665671] hid-generic 0003:0F0D:00C1.0001: input,hidraw0: USB HID v1.11 Gamepad [HORI CO.,LTD. HORIPAD S] on usb-0000:00:14.0-1/input0
{% endhighlight %}

We can find the same information in _lsusb_;

{% highlight tcsh tabsize=4 %}
$ lsusb -v 

Bus 001 Device 002: ID 0f0d:00c1 Hori Co., Ltd 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0f0d Hori Co., Ltd
  idProduct          0x00c1 
  bcdDevice            5.72
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      80
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               5
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               5

{% endhighlight %}
 
So we know it's recognized, lets see if [jstest][jstest-link] can read input coming from the device: 

{% highlight tcsh tabsize=4 %}
$ jstest --normal /dev/input/js0 

Driver version is 2.1.0.
Joystick (HORI CO.,LTD. HORIPAD S) has 6 axes (X, Y, Z, Rz, Hat0X, Hat0Y)
and 14 buttons (BtnA, BtnB, BtnC, BtnX, BtnY, BtnZ, BtnTL, BtnTR, BtnTL2, BtnTR2, BtnSelect, BtnStart, BtnMode, BtnThumbL).
Testing ... (interrupt to exit)
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:on   2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:on   2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:off  2:on   3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:off  2:on   3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0:  9458  1: -2703  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 
Axes:  0:-32767  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0: -1014  1: 32767  2:-18580  3: 32767  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0: -1690  1: 32767  2:-18580  3: 32767  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0: -1690  1: 32767  2:-18580  3: 32767  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0: -2027  1: 32767  2:-18580  3: 32767  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 
{% endhighlight %}

All the buttons / sticks  and dpad seem to work and jstest is able to read signal from all inputs!

I opened up steam, thinking I was going to play [Celeste][celeste-link]. However steam reported that it didn't recognize any controllers...

Going into Settings -> Controllers -> General Controller Settings, I had the "Generic Gamepad Configuration Support" option
checked, as this wasn't one of the known Xbox/PS/Switch controllers. Steam wasn't able to see the device for some reason.

After digging around I saw mention of the [steam-devices][steam-devices-link] package, which was recommended by some others debugging
similar issues for other controllers. So I installed that package, and nothing changed.

Wondering what exactly this package does, I started to dig into what exactly that package provided.

{% highlight tcsh tabsize=4 %}
$ dpkg -L steam-devices

/.
/lib
/lib/udev
/lib/udev/rules.d
/lib/udev/rules.d/60-HTC-Vive-perms.rules
/lib/udev/rules.d/99-steam-controller-perms.rules
/usr
/usr/share
/usr/share/doc
/usr/share/doc/steam-devices
/usr/share/doc/steam-devices/changelog.Debian.gz
/usr/share/doc/steam-devices/copyright
{% endhighlight %}

That _99-steam-controller-perm.rules_ file stood out as interesting.

{% highlight tcsh tabsize=4 %}
$ head /lib/udev/rules.d/99-steam-controller-perms.rules

# Valve USB devices
SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
# Steam Controller udev write access
KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess"

# Valve HID devices over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"

# Valve HID devices over bluetooth hidraw
KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
{% endhighlight %}

It looks like a bunch of [udev rules][udev-link] for configuring the permission for hidraw and uinput devices.
We saw in the output above that our controller is a hidraw device, maybe we need to setup permissions for the device to be read by non elevated users?

To test this out I appended the following to the _99-steam-controller-perm.rules_ file.
I found the vendor id and product id for the HORIPAD using lsusb -v (as seen above).

{% highlight perl tabsize=4 %}
# HORIPAD S over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="00c1", MODE="0666"
{% endhighlight %}

Not wanting to reboot I quickly dug up [how to force reload udev rules][udev-read-link]: 
{% highlight tcsh tabsize=4 %}
$ sudo udevadm control --reload-rules 
$ sudo udevadm trigger
{% endhighlight %}

A few seconds later, steam popped up a window informing me that it had recnogized a new controller!

I started up [Celeste][celeste-link] and everything worked like a charm.
Off to play the game!

[horipad-link]: http://stores.horiusa.com/horipad-for-nintendo-switch/
[jstest-link]: https://linux.die.net/man/1/jstest
[celeste-link]: https://store.steampowered.com/app/504230/Celeste/
[steam-devices-link]: https://github.com/ValveSoftware/steam-devices
[udev-link]: https://mirrors.edge.kernel.org/pub/linux/utils/kernel/hotplug/udev/udev.html
[udev-read-link]: https://unix.stackexchange.com/questions/39370/how-to-reload-udev-rules-without-reboot
