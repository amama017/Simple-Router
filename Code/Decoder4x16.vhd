Library ieee;
Use ieee.std_logic_1164.all;

Entity Decoder4x16 is
    port(S0,S1,S2,S3 : in std_logic;
        Sv0,Sv1,Sv2,Sv3 : in std_logic_vector(1 downto 0);
        Code : out std_logic_vector(15 downto 0));
end Decoder4x16;

Architecture RTL of Decoder4x16 is
    begin
        Code(3 downto 0) <= "0001" when Sv0 = "00" and S0 = '1'
        else "0010" when Sv0 = "01" and S0 = '1'
        else "0100" when Sv0 = "10" and S0 = '1'
        else "1000" when Sv0 = "11" and S0 = '1'
        else "0000";
        
        Code(7 downto 4) <= "0001" when Sv1 = "00" and S1 = '1'
        else "0010" when Sv1 = "01" and S1 = '1'
        else "0100" when Sv1 = "10" and S1 = '1'
        else "1000" when Sv1 = "11" and S1 = '1'
        else "0000";
        
        Code(11 downto 8) <= "0001" when Sv2 = "00" and S2 = '1'
        else "0010" when Sv2 = "01" and S2 = '1'
        else "0100" when Sv2 = "10" and S2 = '1'
        else "1000" when Sv2 = "11" and S2 = '1'
        else "0000";
        
        Code(15 downto 12) <= "0001" when Sv3 = "00" and S3 = '1'
        else "0010" when Sv3 = "01" and S3 = '1'
        else "0100" when Sv3 = "10" and S3 = '1'
        else "1000" when Sv3 = "11" and S3 = '1'
        else "0000";
end RTL;