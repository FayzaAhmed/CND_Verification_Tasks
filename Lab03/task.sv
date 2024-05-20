module Producer_Consumer;

typedef enum {CONTROL, COMMAND, MESSAGE} PacketType;

typedef struct  {
    int ID;
    time PacketTime;
    int unsigned Data;
    PacketType Type;
} Packet;

bit [4:0] NumberPackets = 20;

typedef mailbox #(Packet) Mailbox;
Mailbox mb = new();
Packet packet;

// Task to produce packets
task produce();
    for (int i = 1; i <= NumberPackets; i = i + 1) begin
        if (i == 1) begin
            packet.Type = CONTROL;
        end
        else if (i == 2) begin
            packet.Type = COMMAND;
        end
        else begin
            packet.Type = MESSAGE;
        end
        packet.ID = i;
        packet.PacketTime = $realtime;
        packet.Data = $urandom_range(32'h0, 32'hFFFFFFFF);
        #10;
        $display($time, "The %0d packet is : %p", packet.ID, packet);
        mb.put(packet);        
    end  
endtask

// Task to consume packets
task consume();
    Packet read;
    for (int i = 1; i <= NumberPackets; i = i + 1) begin
        #5;
        mb.get(read);
        $display($time, "The %0d packet is : %p\n", read.ID, read);
    end
endtask

initial begin
    fork
        produce();
        consume();
    join
end

endmodule
