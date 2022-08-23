module FIFO 
#(parameter data_width =32,parameter addr_width=4)
(input clk,//CLK
input rd_en,//enable for reading
input wr_en,//enable for writing
input [data_width-1:0] data_in, //input data
input reset ,//reset 
output reg [data_width-1:0] data_out ,
output  empty,
output  full,
output reg [addr_width-1:0] data_counter//To count how many data slots full in FIFO
);
//memory 
reg [data_width-1:0] memory [2**addr_width-1:0];//array 2_D to implement FIFO memory  
//pointer
reg [addr_width-1:0] rd_counter;
reg [addr_width-1:0] wr_counter;
//if needed or you can increase it or decrease it using + / - 
reg add;//signal to increase counters 
reg sub;//signal to decrease counters
assign empty =(data_counter==0) ? 1:0;
assign full=(data_counter==2**addr_width) ? 1:0 ;






always @ (posedge clk,negedge reset)begin
 if (!reset)begin
    //full <= 1'b0;
    //empty <= 1'b1;
    data_counter <= 4'b0000;
    rd_counter <= 4'b0000;
    wr_counter <= 4'b0000;
 end
 else begin
     if (wr_en==1'b1)begin
    memory[wr_counter]<= data_in;
    wr_counter<=wr_counter+1;
     end
    else if (rd_en==1'b1) begin
    data_out<=memory[rd_counter];
    rd_counter<=rd_counter+1;
    end
    else;
 end
end
 
always @ (*)begin
   if(rd_en==1'b1)
   data_counter=data_counter-1;
   else if (wr_en==1'b1)
   data_counter=data_counter+1;
   else ;
end


/*
always @ (posedge clk,negedge reset,posedge rd_en)begin
 if (!reset)begin
    full <= 1'b0;
    empty <= 1'b1;
    data_counter <= 4'b0000;
    rd_counter <= 4'b0000;
    wr_counter <= 4'b0000;
    data_out <=0;
 end 
 else begin
     if (rd_en)begin
     if (data_counter == 4'b0000)
     empty <= 1'b1;
     else begin
    data_out <= memory[rd_counter];
    full <= 1'b0;
    empty <= 1'b0;
    data_counter <= data_counter-1;
    if (rd_counter==4'b1111)
    rd_counter <=4'b0000;
    else
    rd_counter <= rd_counter+1;

 end
 end
 end 

end */

endmodule