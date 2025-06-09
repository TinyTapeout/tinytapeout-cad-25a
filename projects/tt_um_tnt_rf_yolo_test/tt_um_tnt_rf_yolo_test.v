/*
 * Copyright (c) 2025 Sylvain Munaut
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_tnt_rf_yolo_test (
	input  wire       VGND,
	input  wire       VDPWR,    // 1.8v power supply
	input  wire [7:0] ui_in,    // Dedicated inputs
	output wire [7:0] uo_out,   // Dedicated outputs
	input  wire [7:0] uio_in,   // IOs: Input path
	output wire [7:0] uio_out,  // IOs: Output path
	output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
	input  wire       ena,      // always 1 when the design is powered, so you can ignore it
	input  wire       clk,      // clock
	input  wire       rst_n     // reset_n - low to reset
);

	wire [31:0] we;
	wire [31:0] wlp;
	wire [31:0] wln;
	wire [31:0] rea;
	wire [31:0] reb;
	wire [31:0] rla;
	wire [31:0] rlb;

	control_input ctl_in_I (
		.VGND  (VGND),
		.VDPWR (VDPWR),
		.clk   (ui_in[7]),
		.data  (ui_in[6]),
		.wlp   (wlp),
		.wln   (wln)
	);

	control_word_line ctl_wl_I (
		.VGND     (VGND),
		.VDPWR    (VDPWR),
		.clk      (clk),
		.we_data  (ui_in[3]),
		.we_ena   (ui_in[2]),
		.rea_data (ui_in[5]),
		.rea_ena  (ui_in[4]),
		.reb_data (ui_in[1]),
		.reb_ena  (ui_in[0]),
		.we       (we),
		.rea      (rea),
		.reb      (reb)
	);

	rf_top rf_I (
		.VGND  (VGND),
		.VDPWR (VDPWR),
		.we    (we),
		.wlp   (wlp),
		.wln   (wln),
		.rea   (rea),
		.reb   (reb),
		.rla   (rla),
		.rlb   (rlb)
	);

	assign uio_oe  = { 8{VDPWR} };
	assign uio_out = rla[17:10];
	assign uo_out  = rlb[21:14];

endmodule
