module fsm_1011 (
    input clk, 
    input rst_b, 
    input i, 
    output reg o
);
    // Define states
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg [2:0] state, next_state;

    // FSM state transition logic
    always @(*) begin
        // Default values
        next_state = state;
        o = 0;

        case (state)
            S0: begin
                if (i) next_state = S1;  // Waiting for '1'
                else next_state = S0;    // Stay in S0
            end
            S1: begin
                if (!i) next_state = S2;  // Waiting for '0'
                else next_state = S1;    // Stay in S1
            end
            S2: begin
                if (i) next_state = S3;  // Waiting for '1'
                else next_state = S0;    // Back to S0 if '0'
            end
            S3: begin
                if (i) next_state = S4;  // Waiting for final '1'
                else next_state = S2;    // Back to S2 if '0'
            end
            S4: begin
                o = 1;  // Pattern detected, set output
                next_state = S1;  // Start detecting new pattern
            end
            default: next_state = S0;
        endcase
    end

    // State register update
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b)
            state <= S0;  // Reset to initial state
        else
            state <= next_state;  // Update state
    end

endmodule

module fsm_1011_tb;
    reg clk, rst_b, i;
    wire o;

    // Instantiate the FSM
    fsm_1011 uut (
        .clk(clk), 
        .rst_b(rst_b), 
        .i(i), 
        .o(o)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period 10ns

    initial begin
        // Initialize signals
        clk = 0;
        rst_b = 0;
        i = 0;
        #10 rst_b = 1;  // Release reset after 10ns
    end

    initial begin
        // Apply input sequence for detecting '1011'
        #20; i = 1;  // First 1
        #10; i = 0;  // First 0
        #10; i = 1;  // Second 1
        #10; i = 1;  // Third 1, full pattern detected
        #10; i = 0;  // Reset after detection
        #20; i = 1;  // Start detecting another pattern
        #10; i = 0;  // First 0
        #10; i = 1;  // Second 1
        #10; i = 1;  // Third 1, another detection
    end

    // Monitor output
    initial begin
        $monitor("Time: %0d, i: %b, o: %b", $time, i, o);
    end
endmodule

