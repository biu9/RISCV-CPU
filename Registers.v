module Registers(clk,rs1Addr,rs2Addr,WriteAddr,RegWrite,WriteData,rs1Data,rs2Data);
    input clk,RegWrite;
    input [4:0] rs1Addr,rs2Addr,WriteAddr;
    input [31:0]WriteData;
    output [31:0] rs1Data, rs2Data;
    
    wire[31:0] ReadData1, ReadData2;
    wire rs1Sel,rs2Sel;
    
    RBWRegisters RBWRegisters1(
        .clk(clk), 
        .ReadRegister1(rs1Addr), 
        .ReadRegister2(rs2Addr), 
        .WriteRegister(WriteAddr), 
        .WriteData(WriteData), 
        .RegWrite(RegWrite), 
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2)
    );
    
    assign rs1Sel = RegWrite && (WriteAddr!=0) && (WriteAddr==rs1Addr);
    assign rs2Sel = RegWrite && (WriteAddr!=0) && (WriteAddr==rs2Addr);
    
    assign rs1Data = rs1Sel ? WriteData : ReadData1;
    assign rs2Data = rs2Sel ? WriteData : ReadData2;

endmodule