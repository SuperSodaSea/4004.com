---
title: Swiss Physicist’s “Big Hack” for Intel 4004’s 52nd Anniversary
copyright: Copyright © 2023, Tuva Design | Modified on 2023-Nov-19
---

## Swiss Physicist’s “Big Hack” for Intel 4004’s 52nd Anniversary
### An international collaboration, a lot of hand-soldering, and incremental debugging <br/> (Biggest challenge: “Digital” FETs are really analog if you look closely. 0.2 volts is a tiny threshold)

![Klaus’ 4004,4002,4001x PCBs all turned on](./IMG_2596.jpg){width="66%"}
![Klaus’ 4004 PCB closeups: logo and decoder](./k4004-closeups.jpg){width="33%"}

The ambition to build a giant replica of the Intel 4004 microprocessor
dates back to the mid-2000s when Tim McNerney approached the Intel
Corporate Archives seeking schematics for this historic integrated
circuit—the first, single-chip CPU that companies could buy
off-the-shelf and program themselves. McNerney also reached out to
Italian semiconductor pioneer Federico Faggin, who had designed both
the 4004 (in 1971) and the 8080 (in 1975) for Intel before he jumped ship to
found Zilog (in 1976) and launch the rival Z80—of Radio Shack TRS-80 fame
and countless Soviet era personal computers.

Fast forward three decades. The Z80 was still licensable as an IP
core, powering zillions of TV remote controls, while Intel was
advertising their successful Pentium II on TV with colorful “bunny
suit“ dancers and “Intel inside” stickers. By then Intel’s three
founding CEOs had all retired, and gone with them a long-standing
rivalry with Faggin. It is truly curious that the Intel founders
never forgave Faggin, even after their company became a household name
through the fantastically successful 8088, 286, 386, 486, and Pentium
families that powered the PC revolution.

Fortunately in 2005, McNerney got to join Faggin when, for the first time since his 1975 exit, he was invited back to
Intel’s headquarters building
and presented with the original schematic drawings of his 4-bit
brainchild plus transparent “check plots” of the chip’s artwork preserved in the Intel Museum’s archives. If this peace
offering had not taken place, the [Intel 4004 35th Anniversary
Project](./) might never have gotten started. *[continues below]*

![Klaus’ 3 PCBs on Klaus’ work bench](./IMG_2633.jpg){width="63%"}
![Klaus’ 4004 PCB backlit](./IMG_2371.JPG){width="36%"}

McNerney’s bargain with Intel seemed simple enough: Intel would release the
schematics and artwork of the 4004 for non-commercial use, and in
return, McNerney would build for Intel an interactive museum exhibit with a
fully functional 4004 built out of individually-packaged transistors
on a 41x59 cm (16x23”) printed-circuit board (PCB) using the same
geometry as the original chip. He and his team soon realized how hard
this challenge would be. The 4004 check plots were good enough for
viewing, but had many distortions and tiny, but significant errors. After McNerney designed and Fred
Huettig built the interactive parts of the museum exhibit, what Faggin
accomplished in one year of sleepless nights (and no CAD software),
took an international team of six engineers, all working in their
spare time, two years initially plus (years later) a final two year,
two person push—just as the world was emerging from the Covid era.

The keys to success were threefold:
1. Schematic capture and verification, Fred Huettig (USA)
2. A simulator/analyzer that compared the schematic to the chip artwork
   and provided “oscilloscope traces” for every internal signal,
   Lajos Kintli (Hungary)
3. Someone with both the interest and perseverance to get a complex project
   over the finish line, Klaus Scheffler (Switzerland)

In a related, equally important effort, Brian
and Barry Silverman (Canada) wrote graphical simulators and reverse
engineered the Busicom 141PF desktop calculator, which was the very
first software application written for the 4004. This provided a fun,
practical example, and a verification testbed for the giant replica 4004.
The synergy between teammates was essential to keeping the
project going. Kintli's first involvement in the project
was to study the Busicom assembly language firmware
and add all-important comments to the code. *[continues below]*

![Klaus’ 4004 PCB flyover](./IMG_2379-rot.JPG){width="62%"}
![Klaus’ 4004 PCB layout](./layout.jpg){width="36%"}

Inspired by the 4004’s 50th anniversary, MRI physicist Klaus Scheffler contacted
McNerney about the project—“can it be done?” was his main concern. After
McNerney and Scheffler met in California, for months and months, Scheffler
incrementally built up and tested his 4004 prototype, painstakingly
soldering 1,782 transistors, 49 LEDs and 434 resistors by hand, while
troubleshooting the giant circuit section-by-section using the “scope
traces” from Kintli’s simulator. The power-up reset circuit was harder to
debug. For this and for integration testing, Kintli wrote a
Teensy/Arduino-based test driver that simulated the MCS-4 system bus,
the external RAM and ROM, the rest of the Busicom calculator
hardware, plus [4004 assembly language algorithms for computing digits of Pi](./pi.zip).

After many Zoom debugging session with Kintli, Scheffler got his transistor
4004 running the complete Busicom calculator app at 250kHz, only 3x
slower than the original 750kHz chip. At first you might think “how
slow,” but IMHO this is really a respectable result. PCBs and discrete field-effect transistors (FETs) have
a lot more capacitance than the microscopic FETs inside a microchip.
Using low-capacitance RF FETs were key to achieve this
performance. Most common, discrete transistors are high-current FETs used in switching
power supplies, and have roughly 10x higher gate capacitance.

Once the prototype was fully working, Scheffler found a pick-and-place
electronic assembly company in Germany to build a commercial quality
4004 PCB worthy of a museum. The latest 4002 PCB is colored a very
attractive blue.

But Scheffler did not stop there. He went on to build a giant 4002
RAM. Then came the question of what to do about a 4001 ROM
replica. Thousands of RF transistors get expensive, even purchased at
a discount from surplus electronics dealers in Hong Kong, and he just
couldn’t bring himself to waste so many transistors building a
non-reprogrammable ROM PCB. So the team agreed on a compromise: use a
single re-writable, vintage-compatible EEPROM chip and build just the
specialized bus and I/O logic using discrete transistors. Thus was
born the 4001x, which Scheffler used to complete his giant 4-bit
 “microprocessor.”  For a hypothetical future museum exhibit, it would
be easy to build a ROM array using discrete transistors, but for
experimentation, being able to change the ROM contents is important.

Now that Scheffler has a fully working 4004 computer built out of discrete
transistors that computes the digits of Pi, he looks forward to a
demonstration of another historic, commercial application: the
Kienzle-Argo 1140, the world’s first electronic taxi meter developed
in Germany.


# Credits

- **Tim McNerney 2005-2023** - Computer scientist - Leadership, museum exhibit designer, historian, publicist. Built custom hardware to extract original Busicom calculator ROM firmware.
- **Klaus Scheffler 2022-2023** - Physicist - PCB CAD, hand assembled and debugged prototype hardware 4004 CPU, 4002 RAM, and 4001x ROM PCBs, searched supply chain for surplus transistors, worked with pick-and-place electronic assembly firm for beyond-prototype version of each PCB.
- **Lajos Kintli 2007-2023** - Mathematician - Wrote logic simulator, circuit extractor, netlist comparator (PC), integration test drivers (Teensy), and algorithms for verifying 4004 function (assembly language), e.g. digits-of-pi, 8-queens problem, 16-bit division. Documented Busicom firmware.
- **Fred Huettig 2005-2010** - Electrical engineer - Built FPGA electronics for 2006 Intel Museum exhibit, schematic capture from original 4004 drawings, verification, early circuit prototyping.
- **Brian Silverman 2005-2020** - Computer scientist, Educator - Wrote animated 4004 simulator, Busicom code analysis, calculator simulator, instruction-level 4004 simulator
- **Barry Silverman 2005-2006** - Computer scientist - Animated 4004 simulator


# Legal Notices

- The software (e.g. simulators) and engineering documents (e.g. schematics, drawings, etc.) are provided "AS IS" with no warranty expressed or implied. Fitness for any particular purpose is not guaranteed. The authors do not accept any liability for use of this information.
- The works on this web site are licensed under a [Creative Commons Attribution-Noncommercial-Share Alike 2.5 License](http://creativecommons.org/licenses/by-nc-sa/2.5/).
