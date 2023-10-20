`timescale 1ns/1ps

`include "../src/register.sv"

module memtest;
    
    parameter WIDTH = 32;

    reg clk, rst, ld;
    reg [WIDTH-1:0] datain;
    wire [WIDTH-1:0] dataout;

    register #(.WIDTH(WIDTH)) dut 
    (  
        .rst(rst), 
        .clk(clk), 
        .LD(ld),
        .datain(datain), 
        .out(dataout)
    );

    initial clk = 0;
    always #100 clk = ~clk;

    initial begin
        $dumpfile("register_tb.vcd");
        $dumpvars;

        $display("%d %m: Starting Simulation....", $stime);
        
        rst = 1'b1;
        datain = {WIDTH{1'b0}};
        ld = 1'b1;
    end

    always begin

        @(posedge clk)
        rst = 1'b0;

        @(negedge clk)
        #1 

        $display("%d <-- Marker", $stime);

        if (dataout != 32'h0) begin
            $display("%d %m: ERROR - (0) PC output incorrect (%h).", $stime, dataout);
            $finish;
        end
        
        @(posedge clk)
        rst = 1'b1;
        datain = 32'h00A0;
        ld = 1'b0;

        @(negedge clk)
        #1 

        if (dataout != 32'h00A0) begin
            $display("%d %m: ERROR - (1) PC output incorrect (%h).", $stime, dataout);
            $finish;
        end

        @(posedge clk)
        rst = 1'b0;
        ld = 1'b1;

        @(negedge clk)
        #1 

        if (dataout != 32'h0) begin
            $display("%d %m: ERROR - (2) PC output incorrect (%h).", $stime, dataout);
            $finish;
        end

        #50 $display("%d %m: TestBench Simulation Complete..", $stime);
        $finish;

    end

endmodule