<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

Implements the Dempsey-Gorman DAC architecture, combining two resistor ladder DACs
into a segmented DAC without voltage buffering.

See more details in Analog's [MT-016 tutorial](https://www.analog.com/media/en/training-seminars/tutorials/mt-016.pdf).

## How to test

Set the desired voltage using `ui_in[7:0]`.
The analog output should map this 8-bit value to the 0V to 3.3V voltage range.

## External hardware

Multimeter or any other device that can measure voltages (oscilloscope, microcontroller with ADC, etc.)
