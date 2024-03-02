// !!! check this code, repeat is not working!


class comm_component;

bit [31:0] data;
bit [31:0] address;

function new();
	data =0;
	address =0;

endfunction

function display;
	$display ("data = %0d , address %0d ", data, address);
	
endfunction

endclass


class transmitter extends comm_component;

function new();
	super.new();
endfunction
function transmit (mailbox mb_data,mailbox mb_address);
// 	$randomize;
	mb_data.try_put($urandom(data));
	mb_address.try_put($urandom(address));
endfunction

endclass

class receiver extends comm_component;
function new();
	super.new();
endfunction
function receive (mailbox mb_data,mailbox mb_address);
  	mb_data.try_get(data);
	 mb_address.try_get(address);
endfunction

endclass

module lab4();
	mailbox mb_data,mb_address;

//   mb_data.create();
//   mb_address.create();
receiver R = new();
transmitter T = new();

initial begin
    // Create the mailboxes
    mb_data = new();
    mb_address = new();

    // Alternatively, you can create the mailboxes using the create method
    // mb_data.create();
    // mb_address.create();

    // Loop for 10 iterations
    for (int i = 0; i < 10; i++) begin
        // Transmit data
        T.transmit(mb_data, mb_address);
        #5; // Wait for transmission to complete

        // Display transmitted data
        T.display();
        $display("Packet transmitted");

        // Receive data
        R.receive(mb_data, mb_address);
        #5; // Wait for reception to complete

        // Display received data
        R.display();
        $display("Packet received");
    end
    $finish; // Terminate simulation after 10 iterations
// end

end

  
//   $finish;


endmodule

