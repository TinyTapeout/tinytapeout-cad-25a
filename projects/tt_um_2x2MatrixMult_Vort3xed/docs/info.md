<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a 2x2 matrix multiplier that communicates via UART. The design receives two 2x2 matrices through UART serial communication, performs matrix multiplication, and transmits the result back via UART.

**Matrix Multiplication Process:**
- Input: Two 2x2 matrices A and B
- Matrix A = [[A0, A1], [A2, A3]]
- Matrix B = [[B0, B1], [B2, B3]]
- Result C = A × B = [[C00, C01], [C10, C11]]

Where:
- C00 = A0×B0 + A1×B2
- C01 = A0×B1 + A1×B3
- C10 = A2×B0 + A3×B2
- C11 = A2×B1 + A3×B3

**Communication Protocol:**
- UART configuration: 115,200 baud, 8N1 (8 data bits, no parity, 1 stop bit)
- Input: 8 bytes sent sequentially (A0, A1, A2, A3, B0, B1, B2, B3)
- Output: 4 bytes sent sequentially (C00, C01, C10, C11) - lower 8 bits of each result
- Parallel output: Result matrix elements are also available on dedicated output pins

**State Machine:**
1. Wait for UART input (8 bytes)
2. Compute matrix multiplication
3. Transmit results via UART (4 bytes)
4. Return to waiting state

## How to test

**Required Setup:**
- UART terminal or microcontroller capable of serial communication
- Connection to ui[0] (UART RX) and uio[0] (UART TX)
- 100MHz clock input
- Active-low reset

**Testing Procedure:**

1. **Connect UART interface:**
   - Connect UART TX from your device to ui[0] (chip's RX input)
   - Connect UART RX from your device to uio[0] (chip's TX output)
   - Set terminal to 120,000 baud, 8N1

2. **Send test matrices:**
   Send 8 bytes in sequence representing matrices A and B:
   ```
   Example: A = [[1,2],[3,4]], B = [[5,6],[7,8]]
   Send bytes: 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08
   ```

3. **Receive results:**
   The chip will respond with 4 bytes representing the result matrix C:
   ```
   Expected result: C = [[19,22],[43,50]]
   Received bytes: 0x13, 0x16, 0x2B, 0x32
   ```

4. **Monitor parallel outputs:**
   - uo[0]: C00 (lower 8 bits)
   - uo[1]: C01 (lower 8 bits)  
   - uo[2]: C10 (lower 8 bits)
   - uo[3]: C11 (lower 8 bits)

**Test Cases:**
- Identity matrix: A = [[1,0],[0,1]], B = [[5,6],[7,8]] → C = [[5,6],[7,8]]
- Zero matrix: A = [[0,0],[0,0]], B = any matrix → C = [[0,0],[0,0]]
- Small values: Test with single-digit numbers to verify correctness
- Edge cases: Test with values that might cause overflow (results > 255)

## External hardware

**Required:**
- USB cable (USB-A to Micro-USB or USB-C, depending on your development board. Testing was performed using a Micro-USB cable.)
- No additional UART adapter needed - uses built-in USB-UART bridge

**Optional:**
- Logic analyzer or oscilloscope for debugging UART communication
- LED indicators connected to parallel output pins (uo[0:3]) to visualize results
- Push button for manual reset control

**Connection Setup:**
- **USB Connection**: Connect USB cable directly to development board
- **UART Interface**: Automatically available through built-in FTDI USB-UART bridge
  - ui[0]: Connected to FTDI TX (receives data from computer)
  - uio[0]: Connected to FTDI RX (sends data to computer)
- **Parallel Outputs**: uo[0:3] available for monitoring or LED indicators
- **Clock/Reset**: Handled by board's built-in clock and reset circuitry

**Computer Setup:**
- Install FTDI drivers if not automatically detected
- The board will appear as a COM port (Windows) or /dev/ttyUSB* (Linux/Mac)
- You may use the mmult_comm.py file at the base of this repository to test the chip. 

**UART Settings:**
- Baud rate: 120,000 
- Data bits: 8
- Parity: None
- Stop bits: 1
- Flow control: None

**Usage:**
1. Connect USB cable to development board
2. Open serial terminal and connect to the board's COM port
3. Send 8 bytes representing your two 2x2 matrices
4. Receive 4 bytes back representing the result matrix
5. Optionally monitor parallel outputs on uo[0:3] pins

**Credits**
- Special thanks to Mr. Tim Edwards for his assistance and mentorship throughout this project
- Mr. Zach Kingman for providing the opportunity to complete this project during school hours. 
- Tiny Tapeout team