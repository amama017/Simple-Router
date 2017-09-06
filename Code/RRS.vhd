Library ieee;
Use ieee.std_logic_1164.all;

ENTITY RRS IS
    PORT ( din1, din2,din3,din4 :  in std_logic_vector(7 downto 0) ;
        clock : in std_logic;
        sel : out std_logic_vector(1 downto 0);
        dout : out std_logic_vector(7 downto 0));
END RRS;

ARCHITECTURE  RTL OF RRS is
signal counter: integer range 0 to 3 := 3;
begin
    
    process_counter: process (clock)
    begin
    	if (clock'event and clock = '1') then
    	    if(counter = 3) then
    	        counter <= 0;
   	     else
    			    counter <= counter + 1;
 			end if;
    	end if;
    end process;
    
    Sel <= "00" when counter = 0
    else "01" when counter = 1
    else "10" when counter = 2
    else "11";
    
    dout <= din1 when counter = 0
    else din2 when counter = 1
    else din3 when counter = 2
    else din4;
END RTL;

