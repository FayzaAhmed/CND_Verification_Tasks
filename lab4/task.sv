class comm_component;
    bit [31:0] data;
    bit [31:0] address;

    // Constructor to initialize data and address
    function new();
        data = 0;
        address = 0;
    endfunction

    function display;
        $display("data = %0d, address = %0d", data, address);
    endfunction
endclass

class transmitter extends comm_component;
    function new();
        super.new();
        data = $urandom;
        address = $urandom;
    endfunction

    function transmit(mailbox mb_data);
        bit [31:0] tx_data = $urandom;
        bit [31:0] tx_address = $urandom;
        mb_data.try_put(tx_data);
        mb_data.try_put(tx_address);
        this.data = tx_data;
        this.address = tx_address;
    endfunction
endclass


class receiver extends comm_component;
    function new();
        super.new();
    endfunction

    function receive(mailbox mb_data);
        bit [31:0] rx_data;
        bit [31:0] rx_address;
		
        // Loop until data is received
        repeat (1) begin
            if (mb_data.try_get(rx_data) && mb_data.try_get(rx_address)) begin
                // Data received successfully
                this.data = rx_data; // Assign received data to class variable
                this.address = rx_address; // Assign received address to class variable
                break;
            end
        end
    endfunction
endclass

module lab4();
    mailbox mb_data; // Single mailbox for both transmission and reception

    // Instantiate receiver and transmitter
    receiver R = new();
    transmitter T = new();

    // Initialize mailbox
    initial begin
        mb_data = new();
    end

    // Task for transmitting packets
    task transmit();
    begin
        for (int i = 0; i < 10; i = i + 1) begin
            T.transmit(mb_data);
            #5; // Wait for transmission to complete
            T.display();
            $display("Packet transmitted\n");
        end
    end
    endtask

    // Task for receiving packets
    task receive();
    begin
        for (int i = 0; i < 10; i = i + 1) begin
            #10;
            R.receive(mb_data);
            R.display();
            $display("Packet received\n");
        end
    end
    endtask

    // Initial block to start transmit and receive tasks
    initial begin
        fork
            transmit();
            receive();
        join
        $finish; // Terminate simulation
    end
endmodule

