module register #(
    parameter WIDTH = 32) 
(
    input clk,
    input rst,
    input LD,
    input [WIDTH - 1:0] datain,
    output reg [WIDTH - 1:0] out
);

always @(negedge clk) begin

    if (!rst) begin
        out <= {WIDTH{1'b0}};
    end
    else if (!LD) begin
        out <= datain;
    end
    else
        out <= out;
end

endmodule