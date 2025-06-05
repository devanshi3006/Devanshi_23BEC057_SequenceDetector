/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09
// Date      : Tue Jun  3 13:40:25 2025
/////////////////////////////////////////////////////////////


module seq_det ( data_in, Clock, reset, detected );
  input data_in, Clock, reset;
  output detected;
  wire   N7, N8, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20;
  wire   [1:0] current_state;

  DFFX1_RVT \current_state_reg[0]  ( .D(N7), .CLK(Clock), .Q(current_state[0]), 
        .QN(n19) );
  DFFX1_RVT \current_state_reg[1]  ( .D(N8), .CLK(Clock), .Q(current_state[1]), 
        .QN(n20) );
  INVX0_RVT U12 ( .A(n20), .Y(n7) );
  INVX0_RVT U13 ( .A(n7), .Y(n8) );
  INVX0_RVT U14 ( .A(n19), .Y(n9) );
  INVX0_RVT U15 ( .A(n9), .Y(n10) );
  INVX0_RVT U16 ( .A(reset), .Y(n11) );
  INVX0_RVT U17 ( .A(n11), .Y(n12) );
  INVX0_RVT U18 ( .A(data_in), .Y(n13) );
  INVX0_RVT U19 ( .A(n13), .Y(n14) );
  NAND2X1_RVT U20 ( .A1(current_state[1]), .A2(n10), .Y(n16) );
  NOR2X0_RVT U21 ( .A1(n14), .A2(n16), .Y(detected) );
  INVX1_RVT U22 ( .A(n12), .Y(n17) );
  AND4X1_RVT U23 ( .A1(n14), .A2(n10), .A3(n8), .A4(n17), .Y(N7) );
  NAND2X0_RVT U24 ( .A1(current_state[0]), .A2(n8), .Y(n15) );
  NAND2X0_RVT U25 ( .A1(n16), .A2(n15), .Y(n18) );
  AND3X1_RVT U26 ( .A1(n14), .A2(n18), .A3(n17), .Y(N8) );
endmodule

