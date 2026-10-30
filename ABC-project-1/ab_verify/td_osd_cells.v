`timescale 1ns/1ps
// Synchronous DP8K/9-bit, read-only PDPW8K/18-bit, SP8K/9-bit BRAM,
// distributed RAM and split signed/unsigned 9x9 multiplier subset.
// Port/parameter declarations follow the locally installed TD EG4 library.
// Functional models only: no analog/timing or unspecified modes. Assertions
// reject any exported configuration outside the subset exercised here.
module EG_PHY_BRAM (
  dia, csa,
  addra, cea, ocea, clka, wea, rsta,
  dib, csb,
  addrb, ceb, oceb, clkb, web, rstb,
  doa,
  dob);

output  [8:0] doa;                     //  [Template:Port A reads data. ]
output  [8:0] dob;                     //  [Template:Port B reads data. ]
input   [8:0] dia;                     //  [Template:Port A writes data.]
input   [8:0] dib;                     //  [Template:Port B writes data.]
input   [2:0] csa;                    
input   [2:0] csb;                    
input   cea, ocea, clka, wea, rsta;   
input   ceb, oceb, clkb, web, rstb;   
input   [12:0] addra;                  //  [Template:Port A writes the address.]
input   [12:0] addrb;                  //  [Template:Port B writes the address.]


parameter MODE = "DP8K";
parameter DATA_WIDTH_A = "9";
parameter DATA_WIDTH_B = "9";
parameter READBACK = "OFF";
parameter REGMODE_A = "NOREG";
parameter REGMODE_B = "NOREG";
parameter WRITEMODE_A = "NORMAL";
parameter WRITEMODE_B = "NORMAL";
parameter GSR = "ENABLE";
parameter RESETMODE = "SYNC";
parameter ASYNC_RESET_RELEASE = "SYNC";
parameter CEAMUX = "SIG";
parameter CEBMUX = "SIG";
parameter OCEAMUX = "SIG";
parameter OCEBMUX = "SIG";
parameter RSTAMUX = "SIG";
parameter RSTBMUX = "SIG";
parameter CLKAMUX = "SIG";
parameter CLKBMUX = "SIG";
parameter WEAMUX = "SIG";
parameter WEBMUX = "SIG";
parameter CSA0 = "SIG" ;
parameter CSA1 = "SIG" ;
parameter CSA2 = "SIG" ;
parameter CSB0 = "SIG" ;
parameter CSB1 = "SIG" ;
parameter CSB2 = "SIG" ;


    parameter INIT_FILE = "NONE";
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
 wire[8191:0]data_init={INIT_1F,INIT_1E,INIT_1D,INIT_1C,INIT_1B,INIT_1A,INIT_19,INIT_18,INIT_17,INIT_16,INIT_15,INIT_14,INIT_13,INIT_12,INIT_11,INIT_10,INIT_0F,INIT_0E,INIT_0D,INIT_0C,INIT_0B,INIT_0A,INIT_09,INIT_08,INIT_07,INIT_06,INIT_05,INIT_04,INIT_03,INIT_02,INIT_01,INIT_00};
 wire[1023:0]parity_init={INITP_03,INITP_02,INITP_01,INITP_00};

 reg[8:0]mem[0:1023];integer i;
 initial for(i=0;i<1024;i=i+1)mem[i]={parity_init[i],data_init[i*8+:8]};
 function mux;input sig;input[23:0]sel;begin case(sel)"0":mux=0;"1":mux=1;"INV":mux=~sig;default:mux=sig;endcase end endfunction
 wire ca=mux(cea,CEAMUX),cb=mux(ceb,CEBMUX),wa=mux(wea,WEAMUX),wb=mux(web,WEBMUX);
 wire ra=mux(rsta,RSTAMUX),rb=mux(rstb,RSTBMUX);
 reg[8:0]qa=0,qb=0;
 generate if(MODE=="PDPW8K" && DATA_WIDTH_B=="18")begin
  always @(posedge clka)if(ca && wa)begin mem[{addra[12:4],1'b0}]<=dia;mem[{addra[12:4],1'b1}]<=dib;end
  always @(posedge clkb)if(rb)begin qa<=0;qb<=0;end else if(cb)begin qa<=mem[{addrb[12:4],1'b0}];qb<=mem[{addrb[12:4],1'b1}];end
 end else begin
  always @(posedge clka)begin
   if(ca && wa)mem[addra[12:3]]<=dia;
   if(ra)qa<=0;else if(ca && !wa)qa<=mem[addra[12:3]];
  end
  always @(posedge clkb)begin
   if(cb && wb)mem[addrb[12:3]]<=dib;
   if(rb)qb<=0;else if(cb && !wb)qb<=mem[addrb[12:3]];
  end
 end endgenerate
 assign doa=qa;assign dob=qb;
 initial if(!((MODE=="PDPW8K" && DATA_WIDTH_A=="18" && DATA_WIDTH_B=="18") || ((MODE=="DP8K" || MODE=="SP8K") && DATA_WIDTH_A=="9" && DATA_WIDTH_B=="9")) || REGMODE_A!="NOREG" || REGMODE_B!="NOREG" || WRITEMODE_A!="NORMAL" || WRITEMODE_B!="NORMAL")begin $display("FAIL unsupported BRAM %m");$finish;end

endmodule
module EG_PHY_MULT18(input[17:0]a,b,input clk,rstbn,output[35:0]p);
 parameter CEBMUX="1",CLKMUX="SIG",INPUTREGA="DISABLE",INPUTREGB="ENABLE",MODE="MULT9X9C",OUTPUTREG="DISABLE",RSTBNMUX="SIG",SIGNEDAMUX="1",SIGNEDBMUX="1",SRMODE="ASYNC";
 reg[17:0]bq=0;
 always @(posedge clk or negedge rstbn)if(!rstbn)bq<=0;else bq<=b;
 wire[17:0]bb=INPUTREGB=="ENABLE"?bq:b;
 // EG4 vendor eg_phy_mult18.v extends each lane to 18 bits according to
 // SIGNEDAMUX/SIGNEDBMUX, then retains the low 18 product bits per lane.
 wire[17:0]a0={{9{(SIGNEDAMUX=="1") && a[8]}},a[8:0]};
 wire[17:0]a1={{9{(SIGNEDAMUX=="1") && a[17]}},a[17:9]};
 wire[17:0]b0={{9{(SIGNEDBMUX=="1") && bb[8]}},bb[8:0]};
 wire[17:0]b1={{9{(SIGNEDBMUX=="1") && bb[17]}},bb[17:9]};
 wire[17:0]p0=a0*b0,p1=a1*b1;
 assign p={p1,p0};
 initial if(INPUTREGA!="DISABLE" || OUTPUTREG!="DISABLE" || MODE!="MULT9X9C" ||
  (SIGNEDAMUX!="1" && SIGNEDAMUX!="0") || (SIGNEDBMUX!="1" && SIGNEDBMUX!="0") ||
  (INPUTREGB!="ENABLE" && INPUTREGB!="DISABLE") ||
  (INPUTREGB=="ENABLE" && (SRMODE!="ASYNC" || CEBMUX!="1" || CLKMUX!="SIG" || RSTBNMUX!="SIG")))
  begin $display("FAIL unmodelled OSD MULT mode %m");$finish;end
endmodule

module EG_LOGIC_DRAM16X4(input[3:0]di,waddr,input we,wclk,input[3:0]raddr,output[3:0]do);
 parameter INIT_D0=16'h0,INIT_D1=16'h0,INIT_D2=16'h0,INIT_D3=16'h0;
 reg[3:0]mem[0:15];integer i;
 initial for(i=0;i<16;i=i+1)mem[i]={INIT_D3[i],INIT_D2[i],INIT_D1[i],INIT_D0[i]};
 always @(posedge wclk)if(we)mem[waddr]<=di;
 assign do=mem[raddr];
endmodule
