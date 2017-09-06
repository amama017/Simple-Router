Library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- FIFO Controller that receive requests from inputs
-- and check validation then operate

Entity fifocon is
   port( reset, rdclk, wrclk, r_req, w_req : in std_logic;
         write_valid, read_valid, empty, full :out std_logic;
         wr_ptr, rd_ptr : out std_logic_vector(3 downto 0));
end fifocon;

Architecture RTL of fifocon is
    
  component Buffer1 is
   port( Clk,din : in std_logic;
         dout : out std_logic);
  end component;
    
  signal read_ptr, write_ptr : std_logic_vector(3 downto 0);
  signal Sempty, Sfull, set_empt, set_full, rst_empt, rst_full : std_logic ;
 
  begin 
     process(reset,wrclk)
       begin
         if(reset = '1') then 
               write_ptr <= "1111";
               write_valid <= '0';
               set_full <= '0';
               rst_empt <= '0';
         elsif rising_edge(wrclk) then
                if (w_req = '1' and Sfull = '0') then
                  --Next slot to write
                  if(write_ptr+1 = read_ptr) then
                      --FIFO is Full
                      set_full <= '1';
                      write_valid <= '0';
                  else
                      --DeQueue data
                      rst_empt <= '1';
                      write_valid <= '1';
                  end if;
                  
                  if(write_ptr < "1111")then
                      --Increment Ptr
                      write_ptr <= write_ptr+ 1;
                  else
                      --Increment Ptr
                      write_ptr <= "0000";
                  end if;
              else
                  --Deassert valid bit
                  set_full <= '0';
                  rst_empt <= '0';
                  write_valid <= '0';
             end if;   
           end if;
       end process;
	   
    process(reset,rdclk)
       begin
           if(reset = '1') then 
               read_ptr <= "1111";
               read_valid <= '0';
               set_empt <= '0';
               rst_full <= '0';
         elsif rising_edge(rdclk) then
	     if(r_req = '1' and Sempty = '0') then
                  --Next slot to read
                  if(read_ptr < "1111")then
                      read_ptr <= read_ptr + 1;  
                  else
                      read_ptr <= "0000";
                      --Increment read Ptr
                  end if;
                  
                  if(read_ptr+1 = write_ptr) then
                      --FIFO is Empty
                      set_empt <= '1';
                      read_valid <= '1';
                  else
                      --EnQueue data
                      rst_full <= '1';
                      read_valid <= '1';
                  end if;
                  
              else
                  --Deassert valid bit
                  read_valid <= '0';
                  set_empt <= '0';
                  rst_full <= '0';
              end if;
	 end if;
       end process;
       
    process(reset, rdclk, wrclk)
        begin
            if(reset = '1') then
                Sempty <= '1';
                Sfull <= '0';
            else
                Sempty <= set_empt or ((not rst_empt) and Sempty);
                Sfull <= set_full or ((not rst_full) and Sfull);
            end if;
        end process;
        
   rd_ptr <= read_ptr;
   wr_ptr <= write_ptr;
   empty <= Sempty;
   full <= Sfull;
   
end RTL;
