// Code your testbench here
// or browse Examples
module Producer_Consumer;

typedef enum {CONTROL, COMMAND, MESSAGE} PacketType;
typedef enum {LOW, MEDIUM, HIGH} PriorityLevel;

typedef struct  {
    int ID;
    time SentTime;
    PacketType Type;
    PriorityLevel Priority;
    int unsigned Data;
} Packet;

bit [4:0] MaxNumberPackets = 20;

typedef mailbox #(Packet) Mailbox;
Mailbox mb = new();
Packet packet;

// Task to produce packets
task produce();
begin
    int numPackets = $urandom_range(1, MaxNumberPackets); // Randomize number of packets
    for (int i = 1; i <= numPackets; i = i + 1) begin
        // Randomize packet attributes
        packet.ID = i;
        packet.SentTime = $realtime;
        packet.Type = $urandom_range(CONTROL, MESSAGE);
        packet.Priority = $urandom_range(LOW, HIGH);
        packet.Data = $urandom_range(32'h0, 32'hFFFFFFFF);
        
        #5; // Write packet into mailbox every 5ns
        mb.put(packet);
        $display($time, " Packet %0d put: Type = %s, Priority = %s, Data = %h", packet.ID, packet.Type, packet.Priority, packet.Data);
    end
end
endtask

  
// Task to consume packets
task consume();
begin
  	int numPackets = $urandom_range(1, MaxNumberPackets); // Randomize number of packets
    for (int i = 1; i <= numPackets; i = i + 1) begin
      	Packet read;
      	automatic Packet highestPacket;
    	automatic PriorityLevel currentHighestPriority = LOW; // Initialize with lowest priority
     
  		#20
        // Loop through all packets currently in the mailbox
        while (mb.try_get(read)) begin
            // Check if the current packet has higher priority than the previously found highest priority
            if (read.Priority > currentHighestPriority) begin
                // Update the highest priority
                currentHighestPriority = read.Priority;
                highestPacket = read;

            end
        end
		
        $display($time, " Packet %0d get: Type = %s, Priority = %s, Data = %h", highestPacket.ID, highestPacket.Type, highestPacket.Priority, highestPacket.Data);
  
   end
end
endtask



initial begin
    fork
        produce();
        consume();
    join
end

endmodule

