module top_module ();
    initial `probe_start;
    
    //The vector "in" represents my 5 inputs in this order: E, D, C, B, A
    reg [4:0] in={5'd24};
	initial begin
        for(int i=0; i<24; i++) #10 in <= i + 5'd0;
		#5 $finish;            // Quit the simulation
	end
    fiveToTwentyFourDecoder decoder ( .in(in) );

endmodule

module threeToEightDecoder(input [2:0] in, input e0, e1, e2);
    output [7:0] out;
    wire enable;
    assign enable = e0 & ~e1 & ~e2;
    assign out[0] = ~(~in[2] & ~in[1] & ~in[0] & enable);
    assign out[1] = ~(~in[2] & ~in[1] & in[0] & enable);
    assign out[2] = ~(~in[2] & in[1] & ~in[0] & enable);
    assign out[3] = ~(~in[2] & in[1] & in[0] & enable);
    assign out[4] = ~(in[2] & ~in[1] & ~in[0] & enable);
    assign out[5] = ~(in[2] & ~in[1] & in[0] & enable);
    assign out[6] = ~(in[2] & in[1] & ~in[0] & enable);
    assign out[7] = ~(in[2] & in[1] & in[0] & enable);
    `probe(out[0]);
    `probe(out[1]);
    `probe(out[2]);
    `probe(out[3]);
    `probe(out[4]);
    `probe(out[5]);
    `probe(out[6]);
    `probe(out[7]);
endmodule

module fiveToTwentyFourDecoder(input [4:0] in);
    threeToEightDecoder firstEightMaxterms (.in(in[2:0]), .e0(1'b1), .e1(in[3]), .e2(in[4]));
    threeToEightDecoder secondEightMaxterms (.in(in[2:0]), .e0(in[3]), .e1(in[4]), .e2(1'b0));
    threeToEightDecoder lastEightMaxterms (.in(in[2:0]), .e0(in[4]), .e1(in[3]), .e2(1'b0));
	
    `probe(in[4]);
    `probe(in[3]);
    `probe(in[2]);
    `probe(in[1]);
    `probe(in[0]);
endmodule