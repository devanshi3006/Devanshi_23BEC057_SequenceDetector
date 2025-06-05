// IC Compiler II Version W-2024.09 Verilog Writer
// Generated on 6/3/2025 at 14:29:47
// Library Name: SEQ_DET_LIB
// Block Name: seq_det
// User Label: 
// Write Command: write_verilog ./results/seq_det.routed.v
module seq_det ( data_in , Clock , reset , detected ) ;
input  data_in ;
input  Clock ;
input  reset ;
output detected ;

wire [1:0] current_state ;

DFFX1_RVT \current_state_reg[0] ( .D ( N7 ) , .CLK ( ctosc_drc_0 ) , 
    .Q ( current_state[0] ) , .QN ( n19 ) ) ;
DFFX1_RVT \current_state_reg[1] ( .D ( N8 ) , .CLK ( ctosc_drc_0 ) , 
    .Q ( current_state[1] ) , .QN ( n20 ) ) ;
NBUFFX2_RVT ctosc_drc_inst_336 ( .A ( ctosc_drc_1 ) , .Y ( ctosc_drc_0 ) ) ;
NBUFFX4_RVT ctosc_drc_inst_427 ( .A ( Clock ) , .Y ( ctosc_drc_1 ) ) ;
INVX0_RVT ctmTdsLR_1_428 ( .A ( tmp_net2 ) , .Y ( N8 ) ) ;
NAND3X0_RVT ctmTdsLR_2_429 ( .A1 ( data_in ) , .A2 ( HFSNET_0 ) , 
    .A3 ( n18 ) , .Y ( tmp_net2 ) ) ;
INVX2_RVT HFSINV_83_0 ( .A ( reset ) , .Y ( HFSNET_0 ) ) ;
NAND2X0_RVT U20 ( .A1 ( current_state[1] ) , .A2 ( n19 ) , .Y ( n16 ) ) ;
NOR2X0_RVT U21 ( .A1 ( data_in ) , .A2 ( n16 ) , .Y ( detected ) ) ;
AND4X1_RVT U23 ( .A1 ( data_in ) , .A2 ( n19 ) , .A3 ( n20 ) , 
    .A4 ( HFSNET_0 ) , .Y ( N7 ) ) ;
NAND2X0_RVT U24 ( .A1 ( current_state[0] ) , .A2 ( n20 ) , .Y ( n15 ) ) ;
NAND2X0_RVT U25 ( .A1 ( n16 ) , .A2 ( n15 ) , .Y ( n18 ) ) ;
endmodule


