---
title: Complete Artwork, Schematics, and Simulator for Intel MCS-4 (4004 family)
copyright: Copyright © 2009, Tuva Design | Modified on 2009-Nov-20 at 09.18
---

[![](./assets/intel-4004-ad-photo-gray.jpg){width="504" height="329"}](./4004-ad) <br/>
[Intel's November 15, 1971 product announcement in *Electronic News*](./4004-ad)

# Complete Artwork, Schematics, and Simulator for Intel MCS-4 (4004 family) microprocessor chip-set: "Together again after 38 years!"

| 4001 ROM <br/> *—Newly re-created* | 4002 RAM               | 4003 <br/> I/O Expander  | 4004 CPU               |
| ---------------------------------- | ---------------------- | ------------------------ | ---------------------- |
| [![][4001-tiny]][4001]             | [![][4002-tiny]][4002] | [![][4003-tiny]][4003]   | [![][4004-tiny]][4004] |

Newly released materials (and quick links):
- [Mask artwork for Intel 4001 ROM, 4002 RAM, 4003 shift-register, and 4004 CPU](#mask-artwork)
- [4001, 4002, 4003, and 4004 schematics](#schematics)
- [4001 and 4004 composite photomicrographs](#photos)
- [Interactive simulator, circuit analyzer, and schematic viewer, with individual mask layers](#simulator)
- [Quick link to: 4004 35th Anniversary Project Home Page](./)


# Lajos Kintli writes about how and why he re-created the 4001 masks and the missing 4001, 4002, and 4003 schematics

During my university years, I learned the basics of microelectronics, but it was taught
entirely at the gate level. My desire to understand details of complex circuits like
microprocessors was not satisfied until years later. In June of 2007, while I was searching for
information on a related topic, I discovered the [4004.com](./) web site.
I was thrilled to find
the schematics of the 4004 microprocessor and an animated Java simulator. Seeing that the
team was looking for volunteers, I did not hesitate to offer my help, and soon I became
member of the Intel 4004 35th Anniversary Project team.

A challenging request arrived in June of 2008: to verify the schematics of the
giant 4004 replica being built for the Intel Museum against the masks used for manufacturing the
original microprocessor.  With the mask artwork in-hand, and I started to develop software to do netlist
extraction and comparison. Then I wanted to visualize the result. Unfortunately the schematic I had
was not available in machine-readable format, so finally I decided to generate it myself.  I took
PDF files and put them together into a big picture. It was not as monumental a task as I thought at
first, thanks to Federico Faggin's original design methodology, the schematic and layout were quite
close to each other. I only had to re-draw a few of the circuit blocks (e.g. the 4 bit wide data bus
buffers). Finally I "wired together" the 3 pages of the original drawings. Then I implemented a
component/circuit recognition algorithm, and in parallel I refined the schematics to make them more
clear to the software.  When the whole circuit was recognized, the matching
algorithm I developed earlier was applied, and a list of differences were found and corrected.

Here is a short list of the differences I found between the mask artwork and the schematics:

- In many cases, the polysilicon layer not only overlapped but also intersected the
  diffusion (e.g. at bootstrap capacitors), fooling my software into identifying transistors
  where none existed.
- Pixel errors caused two layers to be incorrectly connected.
- The schematic was at "revision G", while the masks artwork was from an earlier revision.
  The big difference was at the TEST input pin: the masks formed just a simple
  inverter, while it had a complex circuit on the schematic (a Schmitt Trigger).
- The input order of certain gates (e.g. a NAND gate with 2 or 3 inputs) were permuted (or simply reversed)
  between the schematic and layout.
- In a few cases, extra inverters were used from the original signals instead the already
  available inverted signals (e.g. "~O2" is re-generated from "O2" using an additional inverter,
  instead of using the "~O2" generated in some other part of the circuit).
- "JCN+ISZ" had slightly different decoding logic, but were logically equivalent.

Finally I got to the point where both netlist sources were equivalent except for the
"bootstrap loads." These are clever circuits for generating voltages that exceed Vdd so that
powerful inverters can drive long wires. These circuits are indicated on the schematic simply as a
resistor with a "B" next to it, however these are really combinations of a resistor, a capacitor and
a transistor. A "regular" pull-up resistor is just a transistor with its gate tied to Vdd. I
challenge the curious reader to study the diagram below and figure out how the bootstrap circuit
works. (Hint: This is not a DC circuit.)

![](./2009/bootstrap-loads.jpg)

The matched netlists contain the following number of components:

| Component type  | Layout   | Schematics | Difference |
| --------------- | -------: | ---------: | ---------: |
| Transistor:     |     1807 |       1741 |         66 |
| Resistor:       |      427 |        427 |          0 |
| Capacitor:      |       66 |          0 |         66 |
| ESD protection: |        8 |          8 |          0 |
| **Total:**      | **2308** |   **2176** |    **132** |

{border="1"}

After finishing the netlist comparison, I was motivated to simulate the extracted circuit to
ensure correctness, and to see whether the whole circuit would behave same upon
executing assembly code as described in the [MCS-4 User Manual](http://download.intel.com/museum/archives/pdf/msc4.pdf) (PDF 29.4Mb).
So I wrote a switch-level simulator. For easier testing, I gradually added more and more feature, and I replaced rough
temporary solutions with more mature ones. I realized that a number of problems
came from shortcomings of the simulator logic, and so I improved it until it
became reliable.


### Simulating the entire chip-set required re-creating the missing schematics and masks

After completing the verification work for the 4004 microprocessor, I yearned to simulate a complete
microcomputer set (CPU, ROMs and RAMs) at the transistor level. In late December of 2008, Tim McNerney
sent me scans of the Intel 4002 RAM mask proofs.  This was directly usable for the
simulator, but the schematics were not available in any form.  Fortunately, I found that
by reusing blocks from the CPU schematics, I could reproduce a correct schematic diagram in a relatively short time.
The situation with the ROM was not as straightforward.  To get me started, Tim sent me two high resolution
photomicrographs of the Intel 4001 ROM, one of the unmodified chip, and one of the chip with the
metal-layer etched away, revealing the transistors.  Unfortunately the quality was not
suitable for automatic mask extraction.  The only expedient alternative was to redraw the
required mask layers by tracing the photographs, and to reverse engineer the schematic.  For
the sake of project completeness, this is what I did.

At first only the individual chips were simulated separately by generating the necessary
test patterns for the external pins of RAM/ROM (which required a clock-cycle level accurate
simulator of Intel 4004 CPU too). Then I connected the individual simulators together
through a TCP/IP server application. This way the CPU/RAM/ROM simulators can be run in
parallel, just as they were wired in a real system. Sharing the resources of several
computers was considered for providing more screens to the schematic/layout and simulator
windows; but it was not necessary to get more processing power and more memory for the
entire simulated environment.

In October 2009, Tim sent me the mask artwork for the 4003, a 10 bit shift register used as
an I/O expander.  Much like I did for the 4002 RAM, I generated the schematic, and the result was
added to complete the MCS-4 simulator package.

In November 2009, Intel gave us permission to publish our work under a non-commercial
Creative-Common license.


# MCS-4 Composite Mask Artwork {#mask-artwork}

## The 4001 Mask-Programmable ROM

[![][4001-thumb]][4001]

## The 4002 RAM (External Registers)

[![][4002-thumb]][4002]

## The 4003 10-bit Shift Register (I/O Expander)

[![][4003-thumb]][4003]

## The 4004 CPU

[![][4004-thumb]][4004]


# MCS-4 Schematics {#schematics}

- [The 4001 ROM](http://alumni.media.mit.edu/~mcnerney/2009-4004/i4001-schematic.gif)
- [The 4002 RAM](http://alumni.media.mit.edu/~mcnerney/2009-4004/i4002-schematic.gif)
- [The 4003 Shift-Register](http://alumni.media.mit.edu/~mcnerney/2009-4004/i4003-schematic.gif)
- [The 4004 CPU](http://alumni.media.mit.edu/~mcnerney/2009-4004/i4004-schematic.gif)

Scans of the original 4004 schematics (three drawings) are available from the
[Intel Corporate Archives](http://www.intel.com/museum/archives/4004ip.htm), along with
scans of the manual mentioned above and the 4004 mask proofs.  These were transparencies bound
together for reference purposes, not the original lithographic masks.  Due to distortion and aging,
we had to "clean them up" and re-verify them.


# Composite Photomicrographs {#photos}

Here are links to two synthetic photomicrographs, one
of the 4001 and one of the 4004.  Tim McNerney created them using Photoshop by
layering a transparent photo of the original chip with a photo of the
chip that has had its metal layer etched away using hydrofluoric acid
(a really dangerous chemical--don't try this at home!).  By combining
the etched and unetched photos in this way, you can see the metal
wires and the transistors together in the same image.  It is almost like looking at an X-ray of the chip.

- [Composite photo of 4001 ROM](http://alumni.media.mit.edu/~mcnerney/2009-4004/4001-composite-photo.jpg)
- [Composite photo of 4004 CPU](http://alumni.media.mit.edu/~mcnerney/2009-4004/4004-composite-photo.jpg)


# The MCS-4 Simulator and Chip-Set Data {#simulator}

Here you can download a [zip file](./assets/i400x_analyzer_20210324.zip) with the individual mask, schematics, documentation, and Microsoft Windows executable.

## Quick start

1. First extract it using your favorite file archiving program (mine is the free, no strings attached [7-zip](http://www.7-zip.org/))
2. Inside the folder i400x_analyzer20091114 is an application called i400x_analyzer.exe, double-click it to run the program.
3. The first time you run it, keep the defaults checked, and click on "OK"
4. Four windows will appear, then a little dialog box.  Click "OK" to make the dialog box go away.
5. For casual exploration, the most interesting windows are the Layout Analyzer and the Schematic Analyzer.  Move the Layout window to the right to expose the Schematic window.
6. Click on the RM output pad.  You will notice that the same pad and wire highlighted in the Schematic window.
7. Select the Schematics window.  Then click on the wire directly above the one that is highlighted in white.  This will highlight the R0 output pad in the Layout window.
8. Back in the Windows file explorer, double-click on readme.txt for more documentation.  For quick access, here is a link to the same [readme.txt](./2009/readme.txt) file.

## A Few Screen Shots

As you can see in this screen shot of the Layout window, the simulator uses a different-looking color scheme than Tim chose for the mask composites.  In the simulator, the colors also indicate logic levels, and metal looks gray.  In the mask composites, Green = Diffusion, Red = Polysilicon, and Blue = Metal.  These colors were inspired by the book *Introduction to VLSI Systems* by Mead and Conway, as well as full-custom VLSI CAD systems that Tim used professionally, including Mentor Graphics and UCB Magic.

![](./2009/lay-wnd.PNG) &nbsp;
![](./2009/sch-wnd.PNG) <br/>
![](./2009/sim-wnd.PNG) &nbsp;
![](./2009/dis-wnd.PNG)


# Legal Notices

- The software (e.g. simulators) and engineering documents (e.g. schematics) are provided "AS IS" with no warranty expressed or implied. Fitness for any particular purpose is not guaranteed. The authors do not accept any liability for use of this information.
- The works on this web site are licensed under a [Creative Commons Attribution-Noncommercial-Share Alike 3.0 License](http://creativecommons.org/licenses/by-nc-sa/3.0/).


[4001]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4001-masks-composite.jpg
[4001-tiny]: ./2009/4001-composite-tiny.jpg
[4001-thumb]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4001-composite-thumb.jpg
[4002]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4002-masks-composite.jpg
[4002-tiny]: ./2009/4002-composite-tiny.jpg
[4002-thumb]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4002-composite-thumb.jpg
[4003]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4003-masks-composite.jpg
[4003-tiny]: ./2009/4003-composite-tiny.jpg
[4003-thumb]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4003-composite-thumb.jpg
[4004]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4004-masks-composite.jpg
[4004-tiny]: ./2009/4004-composite-tiny.jpg
[4004-thumb]: http://alumni.media.mit.edu/~mcnerney/2009-4004/4004-composite-thumb.jpg
