## How it works

- Stores a 7-bit secret code using flip-flops. Another flip-flop stores whether the safe is open.
- Unlocks the safe when the input (bits 0-6) matches the stored secret code. Locks the safe when RESET is pressed.
- Updates the secret code when input bit 7 is high.
- The 7-segment display shows "L" if the safe is locked and "U" if unlocked.

## How to test

- Set the clock to free-running mode, e.g. at 10 kHz.
- Set the desired secret code using pins 0-6. Toggle pin 7 ON, then OFF.
- Change the inputs 0-6 to prevent the safe from automatically unlocking.
- Press RESET to lock the safe. The display should show "L" (for locked).
- Change the inputs 0-6 to try opening the safe. It should only show "U" (for unlocked) once the secret code is entered. Then it should stay unlocked until the next RESET.

## External hardware

None
