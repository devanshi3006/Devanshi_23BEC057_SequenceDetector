module seq_det (data_in, Clock, reset, detected); 
input data_in;
input Clock, reset;
output reg detected;

reg [1:0] current_state, next_state;

// State encoding
parameter IDLE = 2'b00;
parameter S1   = 2'b01;  // Got '1'
parameter S11  = 2'b10;  // Got '11'

// State register
always @ (posedge Clock)
        begin
                if (reset)
                        current_state <= IDLE;
                else
                        current_state <= next_state;
        end

// Next state logic and output logic (Mealy machine)
always @ * 
        begin
                detected = 1'b0;  // Default output
                next_state = current_state;  // Default next state
                
                case (current_state)
                        IDLE: begin
                                if (data_in == 1'b1)
                                        next_state = S1;
                                else
                                        next_state = IDLE;
                        end
                        
                        S1: begin
                                if (data_in == 1'b1)
                                        next_state = S11;
                                else
                                        next_state = IDLE;
                        end
                        
                        S11: begin
                                if (data_in == 1'b0) begin
                                        detected = 1'b1;  // Sequence '110' detected immediately
                                        next_state = IDLE;
                                end
                                else
                                        next_state = S11;  // Stay in S11 for consecutive 1's
                        end
                        
                        default: next_state = IDLE;
                endcase
        end 

endmodule
