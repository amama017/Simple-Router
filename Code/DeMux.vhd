Library ieee;
Use ieee.std_logic_1164.all;

ENTITY DeMux IS
    PORT ( d_out1, d_out2,d_out3,d_out4 :  out std_logic_vector(7 downto 0) ;
        Sel : in std_logic_vector(1 downto 0);
        En : in std_logic;
        d_in : in std_logic_vector(7 downto 0));
END DeMux;

ARCHITECTURE RTL OF DeMux is
BEGIN
        d_out1 <= d_in when Sel = "00" and En='1';
        d_out2 <= d_in when Sel = "01" and En='1';
        d_out3 <= d_in when Sel = "10" and En='1';
        d_out4 <= d_in when Sel = "11" and En='1';
END RTL;
