<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project consists of two R-C oscillators, originally designed for the Efabless
Frigate project's timing subsystem.  Both run on a 3.3V supply and produce an output
in the 1.8V (digital) domain.  Both are enabled by a single "enable" input in the
1.8V (digital) domain.  One runs at 500kHz, the other at 16MHz.  Each oscillator
has three copies, to help measure cross-coupling and frequency variation across
factors like position on the wafer.

## How to test

The project has size oscillators with the enable pins at "ui_in[0]" to "ui_in[5]".
Four oscillators (2 each 500kHz and 16MHz) have outputs connected to "uo_out[0]"
to "uo_out[3]".  The remaining two oscillators (one each 500kHz and 16MHz) have
outputs connected to analog outputs ua[0] and ua[1].

## External hardware

Note that the two analog outputs will swing only to 1.8V.
The outputs can be read directly by an oscilloscope or frequency counter.
