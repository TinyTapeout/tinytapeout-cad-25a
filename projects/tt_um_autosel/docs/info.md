<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This is a prototype for automatic project selection in Tiny Tapeout. It reads the design id from an I2C EEPROM and selects the corresponding project. The design id is stored in the first two bytes of the EEPROM memory as a big endian 16-bit number. The design id is then used to select the project by setting the `ctrl_sel_inc` signal to the lowest 10 bits of the design id.

The project also prints the 16-bit number read from the EEPROM to the UART port on `uo_out[4]` (baud rate 115200, 8N1) for debugging purposes.

The design also contains a ring oscillator that can be enabled by setting `rosc_clk_en` (ui_in[7]) to 1. The ring oscillator is used to generate a clock signal on the `rosc_clk_out` pin (uo_out[7]) that can be fed back to the `clk` input, so no external clock is needed. 

The ring oscillator has 11 stages and a 5-bit divider. We estimate the frequency of the ring oscillator to be around 550 MHz, and the frequency of the divided clock to be around 17.2 MHz.

## How to test

You need to connect a 1 kbit or 2 kbit I2C EEPROM (e.g. 24C01 or 24C02), program the selected Tiny Tapeout design address into the first two bytes of the EEPROM memory, and connect the EEPROM to the SCL/SDA pins with a 10k pull-up resistor. After connecting the EEPROM, reset the design, and and then observe the ctrl output pins to see if the design id is correctly read from the EEPROM:

- `ctrl_sel_rst_n` should go low, and then high
- `ctrl_sel_inc` should pulse high according to the lowest 10 bits of the number stored in the EEPROM
- `ctrl_ena` should go high

For more information about those signals, please refer to the [Tiny Tapeout Multiplexer documentation](https://github.com/TinyTapeout/tt-multiplexer/blob/main/docs/INFO.md).

You can clock the design externally with a 20 MHz clock signal, or enable the ring oscillator by setting `rosc_clk_en` to 1 and connect the `rosc_clk_out` pin to the `clk` input.

## External hardware

I2C EEPROM (24C01 or 24C02) and two 10k pull-up resistors on SCL and SDA pins.
