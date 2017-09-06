library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Block_RAM is
  port (D_in : in std_logic_vector(7 downto 0);
      D_out : out std_logic_vector(7 downto 0);
      WEA, REA : in std_logic;
      ADDRA, ADDRB : in std_logic_vector(3 downto 0);
      CLKA, CLKB : in std_logic);
end entity Block_RAM;

architecture RTL of Block_RAM is
    type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal ram : ram_type;
  begin
  process(CLKA) is
  begin
    if rising_edge(CLKA) then
      if WEA = '1' then
        ram(to_integer(unsigned(ADDRA))) <= D_in;
      end if;
    end if;
  end process;
  process(CLKB) is
  begin
    if rising_edge(CLKB) then
      if REA = '1' then
        D_out <= ram(to_integer(unsigned(ADDRB)));
      end if;
    end if;
  end process;
end architecture RTL;
