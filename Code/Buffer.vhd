Library ieee;
Use ieee.std_logic_1164.all;

Entity Buffer1 is
   port( Clk,din : in std_logic;
         dout : out std_logic);
end Buffer1;

Architecture RTL of Buffer1 is
begin
    process(Clk)
        begin
            if(rising_edge(Clk)) then
               dout <= din;
            end if;
        end process;
end RTL;

