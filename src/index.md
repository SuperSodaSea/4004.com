---
layout: home
title: Intel 4004 — 50th Anniversary Project
copyright: Copyright © 2006, 2007, 2008, 2009, 2010, 2011 Tuva Design | Modified on 2011-Nov-15
---

### Our mission is to make computer science and digital electronics accessible to students, hobbyists, and the curious museum-goers around the world. <!-- Our first interactive exhibit was commissioned by the Intel Museum in 2005. Questions? --> (Contact us at ![](./contact-info.gif){style="vertical-align: middle;" width="79" height="14"})

---

# Happy 52nd Anniversary 4004! (b: November 15, 1971) {#introduction style="line-height: 1.3em; border-top: medium none; padding-top: 0pt;"}

<br/>

## [Congratulations to Klaus Scheffler and Lajos Kintli](./hackaday23/) {style="line-height: 1.3em; text-align: center;"}

To celebrate the 52nd Anniversary of Intel’s November 15, 1971 product
launch of the now-historic 4004 microprocessor,
Swiss physicist, Klaus Scheffler, in a world’s first, built
[a complete 4-bit computer based on Intel’s original 4004 schematics
using nearly 4,000 discrete SMD transistors](./hackaday23/)
on three giant printed
circuit boards. He proved his computer works stand-alone by running
[an algorithm that computes the first 16 digits of Pi](./assets/4004-pi-16-p.txt).
This achievement was an
international collaboration with Hungarian mathematician, Lajos
Kintli, who worked with Scheffler from afar to debug the printed
circuit “microprocessor,” by writing assembly-language algorithms for the
4004, “board bring-up” test software running on a Teensy, and Kintli’s
indispensable
[circuit analyzer and verification software](./mcs4-masks-schematics-sim)
that made it possible for
Sheffler to build and debug his fledgeling, printed circuit 4004
incrementally, comparing it against “oscilloscope traces” from
Kintli’s known-working simulation of the entire 4004-family
chip-set. But Scheffler did not stop there. After he got his
transistor 4004 working, he went on to build a transistor 4002 RAM and
a hybrid ROM+I/O board to create a complete, stand-alone, 4-bit
computer. This project is a testament that a “big hack” (the good
kind) can be accomplished by a small team of dedicated hobbyists or
even solo, working just a few hours a week, yet persisting for months
despite the inevitable technical challenges.

[![](./hackaday23/IMG_2633-cr.jpg){width="100%"}](./hackaday23/)
Photo: Upper left: 4002 RAM, Lower left: 4001x ROM+I/O (that single chip is an AT28C256 EEPROM), Right: 4004 CPU, Center: System clock

<!--
**Watch this space for updates:** We're working with the folks at [Visual6502.org](http://visual6502.org) to build a *fast* in-browser simulation of the 4004. **Coming soon!**
-->

<!--
**This image (below)** was made from new mask data *verified* by Lajos Kintli using Fred Huettig schematics and Intel scans. (Note: Missing *vias* and non-electrical details.) <br/>
**Click on the image to explore** a *NEW* [**supersized (scalable) version**](./4004-50th-1st-cut-svg.html) of the 4004 artwork: (Pan/zoom works well on an iPad or Microsoft Surface) <br/>
[![4004 50th anniversary SVG](./4004-50th-2nd-cut.jpg){width="100%"}](./4004-50th-1st-cut-svg.html)
-->

<!--
[![4004 exhibit](./assets/4004-exhibit-banner.jpg)](./assets/PB150071.JPG)

[![](./assets/board_thumb.jpg){width="326" height="243"}](./assets/PB120046.JPG)

[![](./4004-announcement-text-top.jpg)](./4004-announcement.jpg)

[![](./assets/4004-masks-showing-fets-j3t.jpg){width="326" height="243"}](./assets/4004-masks-showing-fets-j3-.jpg)

[![](./assets/4004-lajos-schematics.jpg){width="326" height="243"}](./assets/4004-lajos-schematics.gif)

[![](./4004-announcement-text-bot.jpg)](./4004-announcement.jpg)

(Credits for Mask Artwork restoration: **Rotoscoping** Tim McNerney, **Verification** Lajos Kintli, **Simulation** Barry and Brian Silverman, **Schematic capture** Fred Huettig, **Photomicroscopy** Christopher Tarnovsky) {style="font-size: 9px;"}
-->


---

### Check out Chen Steenvoorden's [Busicom 141-PF Printing Calculator Simulator](https://dutchen18.gitlab.io/emu-rs/) implemented in WebAssembly.
#### Note best: The the 141-PF was a vintage adding machine, so you'll see the digits you typed on "paper" *only after* you press an operator button like "plus." For example: To add 18 and 42, type <u>1 8 + 4 2 + =</u> (The 2nd + is *very* important!) You can read the original [(Busicom clone) Operating Instructions](https://archive.org/details/Unicom141PManual/page/n3/mode/2up) at the [Internet Archive](https://archive.org).

[![](./busicom-simulator.png){width="400" height="360" border="8"}](https://dutchen18.gitlab.io/emu-rs/)

---

## Federico Faggin published his memoirs in Italian and English (February 2021)
### The autobiography of this award-winning pioneer of semiconductor technology, designer of the 4004, 8008, 8080, Z80, etc., first published in Italian (as *Silicio*), now out in English [*Silicon: From The Invention of the Microprocessor to the New Science of Consciousness*](http://siliconthebook.com)

---

## Last year's shout-out went to Erturk Kocalar (November 2020)
### ...for his line of educational (and open-source) [Arduino-compatible "Retroshield" kits](http://8bitforce.com) that let you play around with real, vintage microprocessors from the comfort of your laptop.  He recently released his most ambitious shield yet—you guessed it—the ZIF socketed, preassembled [4004 Retroshield](http://8bitforce.com/projects/4004/), complete with voltage level-shifters so the -15 volt PMOS 4004 can communicate with the 5 volt CMOS [Arduino](http://www.arduino.cc). I particularly like Erturk's [Busicom calculator technical summary](http://8bitforce.com/projects/4004/#busicom-141-pf), which includes a nice explanation of [how the Shinshu Seiki drum printer works](http://8bitforce.com/projects/4004/#printer).

---

### Want to meet a community of vintage semiconductor engineers we inspired? [Visit the Visual 6502 Project](http://www.visual6502.org/) and [Evil Mad Scientist Laboratories](https://www.evilmadscientist.com?s=monster+6502)
### Want to know more about the "F.F." signature in the corner of the chip? [Read the perspective of Federico Faggin, the 4004's silicon designer](http://www.intel4004.com/).

<p class="titleTip"></p>

# The Exhibit Story {#story style="border-top: medium none; padding-top: 0pt;"}

#### Genesis

In 2004 I became intrigued by a new kind of packaging for SSI (Small Scale Integration) logic gates, the DSBGA (Die Size Ball Grid Array). I had been waiting for years to see chips without packages, and this was the closest thing I had ever seen. A DSBGA "package" is nothing more than a "bare die" with a grid of solder balls welded to the pads so it can be flipped upside down and soldered to a printed circuit board like any other surface-mount device. But what I found more inspiring was that an entire logic family was now available with one gate per package. Now a printed circuit could be laid out just like the schematic or... just like a "standard cell" VLSI chip! And the end result, not being microscopic, would be easy for anyone to see and better appreciate.

Knowing that robotic "pick-and-place" machines were now the standard way of assembling electronics, and made the whole idea practical to produce, I started thinking. What could I build out of this "retro," one-gate-per-chip technology? Some sort of microprocessor seemed like a natural. But modern microprocessors have millions of transistors, so I knew I'd have to keep the project very modest, like restricting the data-path to 4-bits. This meant I'd have to design my own, or... go back in history and build a replica of a commercial micrprocessor. Besides, reproducing a commercial microprocessor, rather than re-inventing my own, would allow me to use existing software and existing manuals, data sheets, wisdom of the ages, etc.

The first microprocessor that came to mind was the Intel 4004. It was not nearly as famous as the 8080, and its 8-bit progeny, but my late step-father, Joe Robb, worked for Intel in the early 1970's, and I still remember when brought home some MCS-4 data sheets. MCS-4 (Microcomputer Set 4) was the name Intel gave to the 4004 chip family for its commercial introduction in November 1971.

#### In search of the circuit

So that was settled, but how to get the schematics? Joe, as I called him, had also brought home other goodies from Intel, among them an individually packaged C3102 register file chip--undoubtedly an engineering sample. Decades later, in 2000, I was curious enough about this historical relic I had in my possession, that I wrote a letter to the Intel Archives, and much to my surprise, received a big envelope in the mail a few weeks later with a data sheet and other historical information about Intel's early days.

During this research spree I also learned that the Intel Archives and the Intel Museum were somehow connected. This helped me turn a notion into a plan: I wrote to Tracey Mazur, the curator of the Intel Museum, and Rachel Stewart, Intel's corporate archivist, with a proposition: if you give me access to internal 4004 engineering documents, I will build you a giant, functioning replica of the 4004 suitable for a museum exhibit.

Around the same time I started looking for vintage software to run on the giant 4004 replica. I wrote to Federico Faggin and to Marcian "Ted" Hoff, two of the four co-inventors of the 4004 (I was never able to contact the other inventors, Busicom's Masatoshi Shima or Intel's Stan Mazor). Both Faggin and Hoff wrote back, Faggin with a general offer of advice, and Hoff with software for a 4004-based video game design that Intel pitched to a potential customer.

At this time, I was not optimistic about gaining access to schematics or the mask artwork that was used to create the original 4004 wafers, and so I began devising a "Plan B." I was even starting to wonder if there were any schematics to be found, having read interviews that suggested that no complete logic diagram was ever drawn of the 4004. In consultation with Federico Faggin and MIT's Tom Knight, I mentally prepared myself for reverse-engineering the 4004 "the old-fashioned way," by photographing the metal layer through a microscope, and then etching that top layer away to reveal the polysilicon layer, photographing that, and using enlargements of these photomicrographs to meticulously transcribe every transistor and wire.

A few weeks later I got word from Tracey Mazur that Intel's legal department would allow us access to the 4004 engineering documents, and Rachel Stewart was offering encouraging news about her research.

In late July of 2005 I flew to California to meet with Federico Faggin and Rachel Stewart at the Intel archives. The visit was amazingly brief and nearly a complete success. Faggin picked up three large engineering drawings on vullum, a translucent plastic sheeting, unrolled them one-by-one, and declared within 30 seconds, "Yes. This is all of them." Rachel and I looked at each other approvingly, as Faggin adds, "See here? The drawings are drawn just like the chip layout."

[![Busicom 141-PF Calculator](./assets/busicom-thumb.jpg){width="320" height="269"}](./assets/busicom-full-cr-jmed.jpg)

#### The Calculator connection

Just before my trip to Silicon Valley, Federico alerted me to the existence of an engineering prototype of the Busicom 141-PF calculator that he donated to the Computer History Museum in Mountain View, California. Besides the fact that there are fewer than a dozen production 141-PFs known to still be in existence, the significance of this particular relic was that it has socketed ROMs. This might allow us to recover the original calculator software, if we could construct a custom-mode ROM reader for the unusual 4001 ROMs compatible with the 4004 family. Federico was able to dig through his house and lend me some test ROMs that I could use to develop my ROM Reader.

#### Reverse Engineering the schematics

Once back home, I sent the schematics to Brian and Barry Silverman, who immediately started trying to figure out how the 4004 worked in detail. To aid in their quest for understanding, they entered the schematics using Dia, an open-source diagram editor similar to Microsoft Visio, wrote some scripts to translate the Dia schematics into a simulatable netlist, and built themselves a "zero propagation delay" transistor-level simulator. The end result was a beautifully animated simulation of the 4004 running a very short test program running at a clock speed of maybe 4-10Hz

[![](./assets/4001-rom-reader-thumb.jpg)](./assets/4001-rom-reader-cr-j7.jpg)

Meanwhile I continued to develop the ROM reader, periodically sending Brian and Barry my results to see if the binary data I was extracting yielded valid 4004 code. After some struggles with the unusual voltage levels used by the 4001 ROMs, we succeeded in extracting a significant fraction of the Busicom software from the ROMs Faggin had found in his basement. The bad news was that there were large strings of zeros in three out of four of the calculator ROMs. We would have to find another source.

#### Digital Archeology Expedition

Over Thanksgiving 2005, Fred Huettig had plans to see his brother in California. I made arrangements with Dag Spicer for Fred to visit the Computer History Museum to extract the digital contents of their Busicom 141-PF calculator. Fred brought with him my 4001 ROM Reader and Sellam Ismail carefully removed the ROMs, including, much to our delight, the rare 5th ROM containing the Square Root function. He then placed each 4001 in the ROM Reader for Fred to upload to his laptop. Fred also traced the wiring harness to the calculator keyboard. Mission accomplished with only a minor casualty, a broken pin on one of the ROMs.

After Fred returned to Boston, I immediately sent the ROM contents to Brian and Barry, who used Fred's wiring diagram along with printed circuit board photographs I received from Christian Bassow, a German chip collector. Within a month, they had crafted an instruction-level simulator of the 4004 as well as simulated Busicom hardware, and by January 2006, they had a completely working simulation of the Busicom 141-PF printing calculator.

#### Verilog simulation of the 4004

In parallel, Fred was working on his own schematic capture using a commercial CAD package, and was well on his way to automatically deriving a functional Verilog model of the 4004 to verify that the schematics were correct. By spring of 2006, Fred's simulator was correctly executing the lion's share of the original 4004 diagnostics ROM Faggin allowed me to keep.

#### Funding and Exhibit design

This is around the time that the project funding from the Intel Museum was approved, and work began in earnest to design the physical exhibit. Intel brought in their marketing agency to design the overall look of the exhibit. After only a few months of behind-the-scenes design work and weekly conference calls, the talented design team turned my back-of-the-envelope sketches into an attractive exhibit worthy of a museum. I worked closely with a copywriter and the Intel Museum to wordcraft the exhibit's text to explain the historical context, the function of the 4004, and the calculator software.

#### Letting visitors "look under the hood"

One of my main goals for the museum exhibit was to allow museum visitors to gain an appreciation for the "machinery under the hood," the inner workings of the 4004 and the Busicom calculator. To this end, I specified a large, animated flowchart that shows the path that the microprocessor takes through the calculator software when you press a button on the keyboard. To show the calculations in-progress, another display shows the calculator's internal registers.

#### Exhibit Detail and Construction

Once the design was completed Intel brought in an exhibit fabrication firm to detail the design and construct the non-technology parts of the exhibit. Together we fashioned a realistic scale model of the chip's package and the bond wires that connect chips to the "outside world."

#### Out of the vaults and into the world

Concurrently with the exhibit contruction, I started having conversations with Tracey behind the scenes to see if we could get Intel to release the 4004 schematics, mask works, and MCS-4 Users Manual into the public domain. After all, what is the point of keeping historic technology locked up in a vault once its only value is historical? At this writing, Intel has agreed to license these documents for non-commercial use.

<p style="border-top: medium none; padding-top: 0pt;"></p>

# Download Stuff Here ([![Creative Commons License](https://creativecommons.org/images/public/somerights20.png)](https://creativecommons.org/licenses/by-nc-sa/3.0/)) {#downloads}

- *Updated* [Busicom 141-PF calculator software, fully commented and documented](./2009/Busicom-141PF-Calculator_asm_rel-1-0-1.txt){target="_blank"} (Text, *Updated 11/17/2009*)

- [Bill Kotaska's Busicom 141-PF replica: Photos, schematics, and narrative](./busicom-replica.html) — (*v2: Updated 11/18/08*)

- [Tim McNerney's Shinshu Seiki Model-102 printer emulator for PIC18F2320](./busicom-schematics-and-simulator.html)

- [Busicom 141-PF calculator simulator with flowchart](./assets/busicom-141pf-simulator-w-flowchart-071113.zip) (Zip) [Documentation](./busicom-simulator-documentation.html)

- [Verified Intel 4004 Schematics](./assets/redrawn-4004-schematics-2006-11-12.pdf){target="_blank"} (PDF)

- [Animated Intel 4004 Simulator written in Java](./assets/4004-chipsim-demo-2006-11-13.zip) (Zip)

- [Tim McNerney's talk at 35th Anniversary event (13-Dec-2006)](./assets/tim-mcnerney-4004-talk-mono.mp3) <br/>
  (MP3, 20min 47sec, © 2006 [Computer History Museum](https://www.computerhistory.org)) <br/>
  [Transcript of talk](./tim-mcnerney-4004-talk-transcript.html)

- [Lajos Kintli's Intel 4004 netlist/layout analyzer](./assets/i400x_analyzer_repacked_20221111.zip){target="_blank"} with animated logic simulator with complete MCS-4 masks and schematics (Zip, *v2.0: updated 11/15/2018*)

<p class="titleTip"></p>

YouTube Link: [Complete video of 35th anniversary talks by Marcian "Ted" Hoff, Federico Faggin, and Tim McNerney, with Q&A session](https://www.youtube.com/watch?v=j00AULJLCNo&eurl=https://www.4004.com/)

<p class="titleTip"></p>


# Frequently Asked Questions {#FAQ style="border-top: medium none; padding-top: 0pt"}

<!--
#### Where is the Intel 4004 35th anniversary exhibit? {style="border-top: medium none; padding-top: 0pt"}

> [Intel Museum](https://www.intel.com/museum/index.htm) <br/>
> Robert Noyce Building <br/>
> 2200 Mission College Blvd <br/>
> Santa Clara, CA 95054 <br/>
> Phone: 408-765-0503 <br/>

<p class="titleTip"></p>
-->

#### How can I contact you?

If you want information about our <u>products or services</u>, you are interested in <u>volunteering</u>, or you have an interesting <u>suggestion</u>, contact me, Tim McNerney at <img align="absmiddle" alt="" />

<p class="titleTip"></p>

#### Are you looking for volunteers, interns, or collaborators?

Yes! We are looking for **electrical engineers**, **computer scientists**, and **VLSI designers** to help us analyze the inner workings of the Intel 4004 hardware down to the transistor level and the Busicom 141-PF calculator software down to the instruction level, and **K-12 teachers**, **professors**, **writers**, **graphic designers**, **information designers**, and **web technologists** to document, illustrate, and explain the elegant beauty of this historic microprocessor system to students, lay people, and future historians.

<p class="titleTip"></p>

#### Do you offer products or services?

The Intel Museum has given us permission to offer our **exhibit technology** to other museums and institutions, including fully functional 130x scale replicas of the 4004 built using discrete transistors, museum-durable keyboards and slide switches, and video display electronics.

We had planned to offer a limited edition, **Busicom 141-PF replica** built using vintage 4004-family chips, but we never figured out a good "retro" substitute for the Epsom drum printer. The vintage Intel chips are expensive and in short supply, but if there is sufficient interest in these, or a more affordable replica built using modern chips, yet still running the original Busicom software, we would be happy to revisit this, perhaps as a Kickstarter campaign.

<p class="titleTip"></p>

#### So who were those anonymous "digital archeologists" reported in the Slashdot article?

They were Fred Huettig, Brian Silverman, Barry Silverman, Lajos Kintli, and myself. <!--a target="_blank" href="http://www.vintagetech.com/"-->Sellam Ismail<!--/a--> performed the delicate surgery on the archeological artifact that [Federico Faggin](http://www.intel4004.com) donated to the [Computer History Museum](https://www.computerhistory.org)

<p class="titleTip"></p>

#### Is the Intel 4004 really the world's first microprocessor?

Yes and no, but mostly yes. The Intel 4004 is widely considered to be the world's first *general-purpose* CPU-on-a-chip.  But there were pioneers of LSI technology at other companies who also deserve credit for their work.  Some had to work in secret and wait for their work to become declassified years later. Intel makes no such bold claims (wishing to avoid more spurious lawsuits), but there is no doubt that the 4004 was the first *customer-programmable* microprocessor to reach the commercial market. You simply could not buy anything like it before its introduction on November 15, 1971...[[Read More about the nuances here.](./4004-really-first.html)]

<p class="titleTip"></p>

#### The 4004 was manufactured from 1971 to 1986, any idea why it lasted so long?

Short answer: Because it was cheap, elegant, scalable, and required no "glue logic"... [[Read more]](./why-so-long)

<p class="titleTip"></p>

#### Where can I buy individual, vintage chips?

I have seen 4004s and related chips (4001, 4002, 4003, 4008, 4009, 4040, 4201, 4289) for sale on [eBay](https://www.ebay.com/). Search for P4004 (P = plastic package), D4004 (D = brown ceramic), and C4004 (C = white ceramic). The white ceramic packages sell for hundreds of dollars, but the other packages are more affordable. The early grey-on-white ceramic packages are extremely rare.

<p class="titleTip"></p>

#### I bought a 4004 on eBay. Do you think it still works?

All these chips are *static sensitive*. Only if you (and the seller) <!--a href="https://www.nxp.com/acrobat_download/various/IC26_CHAPTER_3_2000.pdf"-->handle the chip carefully<!--/a-->, just like a memory upgrade to your computer, can you avoid "zapping" it (which would render it inoperative or intermittent). If your chip arrived in anti-static foam (usually black) and wrapped in aluminum foil or anti-static plastic (usually pink), then it may still work, even after 35 years. Right now, the only way to find out if it works for sure is to build an electronics project that uses your 4004.

![Caution Electrostatic Sensitive Devices](./static-warning.jpg)


<p class="titleTip"></p>
<p class="titleTip"></p>


# Intel 4004 35th Anniversary Exhibit Project {#exhibit style="border-top: medium none; padding-top: 0pt;"}

- [Cast of Credits](#credits)
- [The Exhibit Story](#story)
- [For More Information](./links)


<p class="titleTip"></p>


### Credits {style="border-top: medium none; padding-top: 0pt;"}

#### Team Personnel (in alphabetical order)

- Allen E. Armstrong, mechanical engineering
- Fred Huettig, netlist extraction software, electrical engineering, FPGA programming
- Lajos Kintli, reverse-engineering, software analysis, commenting, documentation
- Tim McNerney, conceptual design, project leader, digital design
- Barry Silverman, reverse-engineering, simulation software
- Brian Silverman, reverse-engineering, simulation software

#### Collaborators and advisors

- Federico Faggin, CEO Foveon, 4004 chip designer
- Sellam Ismail, proprietor, Vintage Tech
- Tom Knight, MIT CSAIL, VLSI history expert
- Tracey Mazur, Curator, Intel Museum
- Dag Spicer, Curator, Computer History Museum
- Rachel Stewart, former Intel archivist

#### Other contributors

- Christian Bassow, owner of a Busicom 141-PF, who kindly sent me photographs of the PCB.
- Karen Joyce, electronic assembler extraordinaire
- Matt McNerney, webmaster


<p class="titleTip"></p>


# Legal Notices {style="border-top: medium none; padding-top: 0pt;"}

- Intel is a registered trade mark of the Intel Corporation
- This web site is in no way affiliated with the Intel Corporation
- The opinions and statements expressed are my own.
- The software (e.g. simulator) and engineering documents (e.g. schematics) are provided "AS IS" with no warranty expressed or implied. Fitness for any particular purpose is not guaranteed. The authors do not accept any liability for use of this information.
- The works on this web site are licensed under a [Creative Commons Attribution-Noncommercial-Share Alike 3.0 License](https://creativecommons.org/licenses/by-nc-sa/3.0/).
