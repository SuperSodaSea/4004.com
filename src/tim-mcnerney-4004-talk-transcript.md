---
title: Tim McNerney talk transcript
copyright: Copyright © 2006, Tuva Design | Modified on 2006-Dec-03
---

#### Tim McNerney's talk at the Computer History Museum on 4004 35th anniversary project

It's really apropos that I am speaking here, because without the Computer History Museum we just could not have done this project. That gift that Federico Faggin talked about, the calculator relic that he donated to the Computer History Museum contained socketed ROMs. That was really the only historical artifact that we could have extracted the Busicom software from. And so without Federico's help, and without the Computer History Museum, Dag Spicer, and Sellam Ismail... we just couldn't have done it without them. So we really thank you guys. It's a great place.

The other thing that I think is just great is, how can you be talking about historical innovation only 35 years ago with the inventors all living? It's just amazing to have a living history like this. It's just great. [Faggin makes inaudiable comment, followed by audience laughter]

I got interested in computers in the late 60's, when I was maybe six years old. I knew I wanted a computer when I grew up and could afford a house that I could fit the computer in. Then I moved from Italy, where I lived, to Silicon Valley, and had the fortune of being able to have access to computers. I remember fondly the husband of my French teacher who worked for Hewlett Packard, who would bring home calculators, pocket calculators, big calculators, and lent these to me over the weekend so I could learn how to program. And I eventually learned how to program a PDP-8 and various machines after that.

So what you would call me in this case? I was introduced in my professional hat—what I do at my job—but in this case I am a "history detective." And it was really a very interesting journey because we really didn't know what was available. We didn't know what was in the Intel Archives that could help us with this project. We never really had any idea that we would be able to find the software for the calculator. So things started out modest. We had really no idea what kind of resources we were going to find along the way, so I did a lot of research into what the 4004 was about, who the people were, etc., and that really helped know what to look for.

So let me give you an outline of the talk. I'm going to tell you a little bit about the project, and give you a little historical perspective on how did people do engineering back then, and how do people do engineering now—it's quite, quite different really—and maybe a few words on the educational value of these kinds of designs, being able to go back to the vaults, go back to the archives and have material for people to study.

So what did we do? Well, I first approached Tracey Mazur of the Intel Museum with a crazy idea. I wanted to build a chip that people could see—to make the invisible visible. And how would I do that? Well, you know these chips were pretty small, 3 by 4 mm, the transistors very tiny, and I wanted to make something big. say this big [gestures with hands, showing a rectange about 16 x 22 inches] so that you could actually see the transistors with the naked eye. And this is what I pitched to them. I pitched to them a fully functional replica of the 4004 using discrete transistors, surface-mounted onto a printed circuit board about 16 by 22 inches. This [pointing to the slide] is the sort of the "fly-over" view, and all the black dots are transistors, and this is the silkscreen of the original maskworks, and then printed circuits underneath that.

It was something that I thought I could do alone, but it turned out to take a team of about 4-5 people in addition to myself, software people and hardware people, electrical engineers, mechanical engineers, to make this exhibit, graphic designers, exhibit designers... It was really a collaborative effort, an interdisciplanary effort.

So we started by reverse-engineering. I went to the Intel Museum. I went to the Corporate Archives, and Rachel Stewart, the corporate archivist for Intel, was able to dig up the check plots these binders with transparencies in them that have, not the original maskworks, but colored plots that you could look at different layers and see how they lined up. And she found the schematics.

Federico and I went to the Intel Archives, and it was such a fast thing. I had no idea how big these schematics were how many there were, how many drawings there were. Federico sits down at this table, and Rachel hands him three sheets of rolled up vellum, and he goes "one, two, three... yup that's all of them." [laughter] and "see, these schematics are drawn just like the chip is layed out."

And that is really something that, to me, is great about this: that you can really look at the functional units. It's not a vast city that you don't understand. It's something you can really see the functional blocks with your naked eye. Well, excuse me, your naked eye through a microscope for the original chip. So that was great.

So now we had the schematics, and eventually they found the maskworks. And what we wanted the maskworks for was we wanted to lay out the printed circuit board really as closely as possible to the original chip. And in fact that's what we did. We were able to, thanks to Fred Huettig, who is my electrical engineer here. He did schematic capture using modern CAD tools to capture the schematics that we had drawings of [and using his "homebrew" circuit extraction software to convert the maskworks into schematics along with transistor locations].

I had two engineers in Canada who really were software experts, Brian Silverman and Barry Silverman. Actually, Brian Silverman is known to the Computer History Museum because he helped with the PDP-1 project, resurecting arguably the first video game, the PDP-1 Spacewar. And he is no stranger to reverse engineering.

So we get the schematics, and Barry and Brian just "eat it up." And they had no idea what to expect either. The thing that they enjoyed about all this was that it was so simple. It's really the minimal microprocessor. Anything less is not a microprocessor, and anything more is more complicated.

So, first they started staring at the diagrams and trying to follow the traces and then they made a simulation of it—a transistor-level simulation—which is available at our web site, 4004.com. So there is an animated simulation that you can see. You can see the transistors turning on and off, and the wires turning red to green—logic false and logic true—and they used that to understand better how the processor worked. And within a couple of weeks, they deeply knew this design, and really had a lot of fun doing it. So when we went back to making the board, we had corrected schematics. We had schematics that we knew worked. We had designers who knew how this stuff worked, and so when Fred went to do his schematic capture he had good schematics to work from without any kind of [errors].

It's worth noting that this project [the original 4004 project] was done with really no CAD essentially. I don't want to talk about things that these guys can talk about [gesturing towords Faggin and Hoff] but there were some simulation tools, on what we would call on the Spice level, that Faggin and his team used to understand how the transistors would work and what size devices to use to drive different sized busses, etc., but that was about it. Instead of using simulators the way we do today...

[Addressing Faggin] Didn't the guys at Busicom actually make some sort of discrete [implementation of the 4004]?

Faggin: Yes, yes, they did do that, but it wasn't useful for the 4004 design because it was done afterward, so that they could develop the software at Busicom.

McNerney: Okay, so it was really...

Faggin: It was really done subsequently to the 4004 design.

McNerney: Okay, fine, so that wasn't really a design verification step.

Faggin: It wasn't a design verification. It was simply a tool to allow them to develop the software.

McNerney: Right, so the design verification, from what I understand, was that these guys looked over the plots made out of...

Faggin: It was actually "steel trap mind." [audience laughter] Shima could find any mistake you could possible make. He was unbelievable. So Shima was the computer-aided design. [audience laughter]

McNerney: So what Faggin is referring to is staring at small sections of of the maskworks. I think they were about a meter by a meter and a half.

Faggin: Much bigger

McNerney: Much bigger? How big?

Faggin: It was 500x so...

McNerney: 500x, okay, thank you, so...

Faggin: ...it was 2 meters by 1.75, (something) 1.50 (yeah).

McNerney: That's why it's great to have folks around. [laughter]

So anyway... So these guys didn't really have any CAD, and we did. [laughter] So we were able to immediately simulate the processor and get it working on a small piece of software. So that was the beginning of the reverse-engineering effort.

The other piece of the reverse-engineering effort really only started when we got our hands on the software. So that's back to where the Computer History Museum came in.

There are very few of these calculators in the world. I want someone to correct me, but my understanding is *under ten*. I guess there were 60 to 100,000 of these things built, but they got thrown away or something. [laughter] Old business machines just go to the scrap heap.

So there aren't very many of these things, and in particular, the one that the Computer History Museum has has socketed ROMs. Faggin was so kind as to give me several 4001 ROMs. One that I could keep and destroy, as I put it, and four that I had to treat like sacred [relics]. And those were the Busicom ROMs, but it turns out, after I made this custom-mode ROM reader, they had holes in them. There were strings of zeros. The chips were defective in some way, or maybe it was storage, or something like that.

So we had 80 or 90% of the software. We could tell something about the software, and we knew that the ROM reader was right, and then I sent Fred to the Computer History Museum with the ROM reader, and we got the actual flawless bits, which are still on display. You can't see them, but they're on display. [laughter]

So then, again, we got the bits. We get them back to Barry and Brian Silverman, and again they "eat this for lunch." And within a couple of months (and these guys are just working on weekends; they have day jobs), they had stared at the disassembled code, and figured out how it was working. Then they made a simulator where they simulated all of the hardware. Fred had traced the wiring diagram from this relic [gestures toward the exhibit halls] I had photographs from a collector in Germany, Christian Bassow. He had a calculator that he had taken [photos of] the front and back side of the printed circuit board. And I made an "X-ray diagram" of the two sides, so you could see all the traces. So I traced the circuit board.

So we had now a lot of the hardware, the wiring diagram. We knew something about the printer and how the keyboard was wired up. And these guys made a simulator in Java that would let them get the calculator working completely in software. That was absolutely indispensable when we were then going to do this in hardware. It's just fantastic to have a team of people who are so enamored with reverse-engineering.

Some of the things that we found out was that this is really a nice, *layered* design. The statement from Shima [read by the moderator] talked about "interdisciplinary." Well, we have device physics, we have computer architecture. Shima, I think, came from a software background. He was really a man of many hats. And these guys all worked together, not just on their own layer. Shima helped Faggin with the design of the chip, and Stan Mazor helped with some parts of the software. They were working across a bunch of different layers, all at the same time, to make the minimal amount of hardware, the minimal amount of software, the minimal amount of printed circuit board. Nothing was under-engineered. It was really just optimal.

And part of this, I think, is because the parts were expensive. Someone's going to correct me if I'm wrong, but I understand that in 1971 dollars, the 4001 ROMs were about 5 cents a byte. And if you scale that to modern dollars that's 20 to 25 cents a byte. So an extra ROM, that was a lot. You didn't want an extra 256 byte ROM.

So talking about the layers, there was the processor layer, then, they built stuff written in 4004 code. And what they did with this 4004 code plus hardware—the chip set—was they simulated the machine that Busicom came to Intel with in the first place.

Busicom had a fully fleshed-out design that was this calculator machine. It was special-purpose, just for this particular product. It used shift-register memory, it had a ROM for control store, and it was a much bigger machine than the 4004 and the associated chips.

They didn't want to abandon that design, and what they ended up doing was using the 4004 plus, let's call it microcode, to make a virtual machine that was now this calculator machine. If anybody watches Dr. Who, it's like the "Tardis." On the outside it's the size of a phone booth, and on the inside it's it's the size of a TV studio. [laughter]

So it's a fantastic case study of layer-across-layer engineering. This is very different than how people do design these days. First of all, significant designs are never done by teams this small. This was a small team. We saw all the helpers and draftmen and the like [on Faggin's credits slide] and we don't want to discredit them. But the core of the team was four people, and that's just unheard of. And they did it in a very short amount of time, and they all worked together.

Nowadays, as Brian Silverman likes to say, abstraction is king. Now I think abstraction is great. Abstraction barriers, it's taught at MIT. And APIs and object-oriented programming where you are very careful about the object hierarchies so that you don't have to know anything about the levels below. It's a black box. I can just program to the API. I don't need to know what's underneath the hood.

That wasn't what was going on here.

Shima knew *exactly* what was under the hood, and if he didn't like what was under the hood he went back and said, I want this instruction to, say, decode the keyboard for me so I can save a few bytes [of code].

And they squeezed this whole calculator, without the square root (let's forget the square root for a second)... they squeezed the whole calculator into *1k bytes.*

So this is very different from what we do these days. Gosh, we know how big programs are nowadays.

One of the things I'm really very happy that I was able to be involved in, is the release of the schematics that Tracey Mazur and I worked on. A great way to celebrate the 35th anniversary of such a historic product is to make the design public, at least for non-commercial use. And so now anybody can contact Intel and get digital files of the original drawings for the 4004, the maskworks, and the users manual, that they can use to write a book, teach a course, study, play with. And I think that we need more of these case studies (because this is just a wonderful case study).

In the field of law the cases are all out there. It's an open book. You can go back to the cases, and see what lawyers did before you. If you are a student, you can see what lawyers did in the past.

With computer science and electrical engineering a lot of stuff ends up being in filing cabinets. Sometimes it gets thrown out, like the HP 9100. All those engineering drawings were thrown out when HP's Calculator Division moved to Corvalis, Oregon—lost! The Computer History Museum has a 9100, but there aren't any drawings.

So I will leave you now with the notion that using designs like this to help our young people learn about engineering and be inspired by engineering and go into VLSI design and electrical engineering is something that I'd like to encourage. If there are captains of industry here, and you have some designs in your vaults and your corporate archives, that aren't part of your core business anymore, but would make just a tremendous case study...

...let it out of the vault!
