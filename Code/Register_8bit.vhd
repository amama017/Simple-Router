Library ieee;
Use ieee.std_logic_1164.all;

-- 8bit Register with positive-edge clock

Entity Register_8bit is
   Generic ( n : integer := 8);
   port( Clock,Reset,Clock_En : in std_logic;
         Data_in : in std_logic_vector(n-1 downto 0);
         Data_out : out std_logic_vector(n-1 downto 0));
end Register_8bit;

Architecture RTL of Register_8bit is
begin
   process(Clock,Reset)
   --Change when 'Clock' or 'Reset' change
   begin
      if Reset = '1' then
          -- Reset the saved Data
          Data_out <= (others=>'0');
      elsif rising_edge(Clock) then
         -- if 'Clock_En' = 0 NoChange
         if Clock_En = '1' then
            -- Save the 'Data_in'
            Data_out <= Data_in;
         end if;
      end if;
   end process;
end RTL;