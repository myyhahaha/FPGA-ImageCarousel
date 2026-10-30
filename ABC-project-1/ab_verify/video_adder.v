`timescale 1ns/1ps
// Same AL_MAP_ADDER truth table as the published TD library. Resolve the
// default-zero inputs locally: Icarus 10 coerces the library tri0 input ports
// into inouts, causing artificial conflicts on multiply-connected FF outputs.
module AL_MAP_ADDER #(parameter ALUTYPE="ADD") (input a,b,c,output reg [1:0] o=0);
`ifdef VERILATOR
 // The two-state simulator's unconnected inputs already default to zero.
 wire av=a,bv=b,cv=c;
`else
 wire av=(a===1'bz)?1'b0:a,bv=(b===1'bz)?1'b0:b,cv=(c===1'bz)?1'b0:c;
`endif
 always @* case(ALUTYPE)
   "ADD":begin o[1]=(av==bv)?av:cv;o[0]=av^bv^cv;end
   "ADD_CARRY":o[1]=av;
   "SUB":begin o[1]=(av!=bv)?av:cv;o[0]=~(av^bv^cv);end
   "SUB_CARRY":o[1]=~av;
   "A_LE_B":begin o[1]=(av!=bv)?bv:cv;o[0]=~(av^bv^cv);end
   "A_LE_B_CARRY":o[1]=av;
   default:begin $display("Unsupported adder mode %s",ALUTYPE);$finish;end
 endcase
endmodule

