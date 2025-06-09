<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

Contains a LFSR that updates on every clock cycle and outputs on all output pins. It uses dynamic DFFs, which means they will loose their state if the clock speed gets too low.

## How to test

Release from reset with all ui_in pins zero.

## External hardware

RP2040 or LEDs to see the output state.
