---
title: Busicom 141-PF Replica schematics, Model-102 printer emulator
copyright: Copyright © 2008, Tuva Design | Modified on 2008-Nov-14
---

Quick links: [PIC-based Model-102 printer emulator](#simulator)


# Busicom 141-PF Replica Schematics {#schematics}

*New* - Version 2 (Updated 11/18/2008) — Click on each thumbnail to view full-size image.

[![Busicom 141-PF Replica schematics 1 of 5](./assets/BuscomV2p1-thumb.jpg){border="5"}](./assets/BuscomV2p1.jpg) &nbsp;
[![Busicom 141-PF Replica schematics 2 of 5](./assets/BuscomV2p2-thumb.jpg){border="5"}](./assets/BuscomV2p2.jpg) <br/>
[![Busicom 141-PF Replica schematics 3 of 5](./assets/BuscomV2p3-thumb.jpg){border="5"}](./assets/BuscomV2p3.jpg) &nbsp;
[![Busicom 141-PF Replica schematics 4 of 5](./assets/BuscomV2p4-thumb.jpg){border="5"}](./assets/BuscomV2p4.jpg) <br/>
[![Busicom 141-PF Replica schematics 5 of 5](./assets/BuscomV2p5-thumb.jpg){border="5"}](./assets/BuscomV2p5.jpg)


# Tim McNerney's Shinshu Seiki Model-102 printer emulator for PIC18F2320 {#simulator}

This hardware emulator converts the printer interface signals that
come from the calculator hardware into ASCII characters output over
the PIC's serial port (configured by default to drive an external
RS-232 level shifter). This interface can be used to drive a serial
LCD display, PC running a terminal emulator, etc. The emulator also
provides the calculator firmware running on the 4004 with the
all-important "heartbeat" sync pulses. Without the proper
timing pulses, the calculator won't work at all!

I built the exerciser to test the emulator. This was necessary
because my own hardware replica wasn't quite working yet (and then
Bill "scooped me" :-). The exerciser runs on a separate PIC
connectected to the emulator PIC. It generates all the signals that
the calculator would send to the printer, and responds to the index
pulses. I extracted the test data by running calculator examples on
an instrumented 4004/Busicom simulator written in Java.

- [model-102-printer-sim.c](./assets/model-102-printer-sim.c)
- [model-102-exerciser.c](./assets/model-102-exerciser.c)
- [model-102-test-data.c](./assets/model-102-test-data.c)

I used the [CCS C compiler](http://www.ccsinfo.com) to
deploy the emulator on the [PIC](http://www.microchip.com).
In test mode, the code probably still compiles with gcc and runs under
POSIX with little or no modifications.


# Legal Notices

- The software (e.g. simulators) and engineering documents (e.g. schematics) are provided "AS IS" with no warranty expressed or implied. Fitness for any particular purpose is not guaranteed. The authors do not accept any liability for use of this information.
- The works on this web site are licensed under a [Creative Commons Attribution-Noncommercial-Share Alike 2.5 License](http://creativecommons.org/licenses/by-nc-sa/2.5/).
