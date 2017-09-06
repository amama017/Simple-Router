Library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity Router is
   port( rst, rclock, wclock: in std_logic;
          wr1,wr2,wr3,wr4: in std_logic;
          rq1,rq2,rq3,rq4: in std_logic;
         datai1,datai2,datai3,datai4 : in std_logic_vector(7 downto 0);
         datao1,datao2,datao3,datao4 : out std_logic_vector(7 downto 0));
end Router;

Architecture RTL of Router is
    
component FIFO is
   port( D_in : in std_logic_vector(7 downto 0);
         D_out : out std_logic_vector(7 downto 0);
         reset,rdclk,wrclk,r_req,w_req : in std_logic;
         empty,full : out std_logic);
end component;

component Register_8bit is
   Generic ( n : integer := 8);
   port( Clock,Reset,Clock_En : in std_logic;
         Data_in : in std_logic_vector(n-1 downto 0);
         Data_out : out std_logic_vector(n-1 downto 0));
end component;

component RRS IS
PORT ( din1, din2,din3,din4 :  in std_logic_vector(7 downto 0) ;
 clock : in std_logic;
 sel : out std_logic_vector(1 downto 0);
dout : out std_logic_vector(7 downto 0));
END component;

component DeMux IS
PORT ( d_out1, d_out2,d_out3,d_out4 :  out std_logic_vector(7 downto 0) ;
 Sel : in std_logic_vector(1 downto 0);
 En : in std_logic;
d_in : in std_logic_vector(7 downto 0));
END component; 

component Buffer1 is
   port( Clk,din : in std_logic;
         dout : out std_logic);
end component;

component Decoder4x16 is
    port(S0,S1,S2,S3 : in std_logic;
        Sv0,Sv1,Sv2,Sv3 : in std_logic_vector(1 downto 0);
        Code : out std_logic_vector(15 downto 0));
end component;
    
    signal databi1,databi2,databi3,databi4 : std_logic_vector(7 downto 0);  --- the output data from input buffer
    signal databo11,databo12,databo13,databo14,databo21,databo22,databo23,databo24,databo31,databo32,databo33,databo34,databo41,databo42,databo43,databo44 : std_logic_vector(7 downto 0);  --- the input data to output buffer
    signal do11,do12,do13,do14,do21,do22,do23,do24,do31,do32,do33,do34,do41,do42,do43,do44,b1,b2,b3,b4 : std_logic_vector(7 downto 0);               ---the output data from mux and enter to fifo
    signal s1,s2,s3,s4, Sel1, Sel2, Sel3, Sel4 : std_logic_vector(1 downto 0);    --- mux selector 
    signal wrb1,wrb2,wrb3,wrb4,temp1,temp2,temp3,temp4,rqb1,rqb2,rqb3,rqb4 : std_logic;
    signal Code,Empty,Full,Read : std_logic_vector(15 downto 0);
    
    begin 
        i1: Register_8bit port map (wclock,rst,wr1,datai1,databi1);
        i2: Register_8bit port map (wclock,rst,wr2,datai2,databi2);
        i3: Register_8bit port map (wclock,rst,wr3,datai3,databi3);
        i4: Register_8bit port map (wclock,rst,wr4,datai4,databi4);
        
        B10: Buffer1 port map (wclock,wr1,wrb1);
        B20: Buffer1 port map (wclock,wr2,wrb2);
        B30: Buffer1 port map (wclock,wr3,wrb3);
        B40: Buffer1 port map (wclock,wr4,wrb4);
        
        B11: Buffer1 port map (rclock,rq1,temp1);
        B21: Buffer1 port map (rclock,rq2,temp2);
        B31: Buffer1 port map (rclock,rq3,temp3);
        B41: Buffer1 port map (rclock,rq4,temp4);
        
        B12: Buffer1 port map (rclock,temp1,rqb1);
        B22: Buffer1 port map (rclock,temp2,rqb2);
        B32: Buffer1 port map (rclock,temp3,rqb3);
        B42: Buffer1 port map (rclock,temp4,rqb4);
        
        s1<= databi1(1 downto 0);
        s2<= databi2(1 downto 0);
        s3<= databi3(1 downto 0);
        s4<= databi4(1 downto 0);
        
        d1: DeMux port map (do11,do12,do13,do14,s1,wrb1,databi1);
        d2: DeMux port map (do21,do22,do23,do24,s2,wrb2,databi2);
        d3: DeMux port map (do31,do32,do33,do34,s3,wrb3,databi3);
        d4: DeMux port map (do41,do42,do43,do44,s4,wrb4,databi4);
        
        Dec1: Decoder4x16 port map(wrb1,wrb2,wrb3,wrb4,s1,s2,s3,s4,Code);
        Dec2: Decoder4x16 port map(rq1,rq2,rq3,rq4,Sel1,Sel2,Sel3,Sel4,Read);
        
        fifo11: FIFO port map (do11,databo11,rst,rclock,wclock,Read(0),Code(0),Empty(0),Full(0));
        fifo12: FIFO port map (do21,databo12,rst,rclock,wclock,Read(1),Code(4),Empty(1),Full(1));
        fifo13: FIFO port map (do31,databo13,rst,rclock,wclock,Read(2),Code(8),Empty(2),Full(2));
        fifo14: FIFO port map (do41,databo14,rst,rclock,wclock,Read(3),Code(12),Empty(3),Full(3));
        
        fifo21: FIFO port map (do12,databo21,rst,rclock,wclock,Read(4),Code(1),Empty(4),Full(4));
        fifo22: FIFO port map (do22,databo22,rst,rclock,wclock,Read(5),Code(5),Empty(5),Full(5));
        fifo23: FIFO port map (do32,databo23,rst,rclock,wclock,Read(6),Code(9),Empty(6),Full(6));
        fifo24: FIFO port map (do42,databo24,rst,rclock,wclock,Read(7),Code(13),Empty(7),Full(7));
        
        fifo31: FIFO port map (do13,databo31,rst,rclock,wclock,Read(8),Code(2),Empty(8),Full(8));
        fifo32: FIFO port map (do23,databo32,rst,rclock,wclock,Read(9),Code(6),Empty(9),Full(9));
        fifo33: FIFO port map (do33,databo33,rst,rclock,wclock,Read(10),Code(10),Empty(10),Full(10));
        fifo34: FIFO port map (do43,databo34,rst,rclock,wclock,Read(11),Code(14),Empty(11),Full(11));
        
        fifo41: FIFO port map (do14,databo41,rst,rclock,wclock,Read(12),Code(3),Empty(12),Full(12));
        fifo42: FIFO port map (do24,databo42,rst,rclock,wclock,Read(13),Code(7),Empty(13),Full(13));
        fifo43: FIFO port map (do34,databo43,rst,rclock,wclock,Read(14),Code(11),Empty(14),Full(14));
        fifo44: FIFO port map (do44,databo44,rst,rclock,wclock,Read(15),Code(15),Empty(15),Full(15));
    
        rrs1: RRS  port map (databo11,databo12,databo13,databo14,rq1,Sel1,b1);
        rrs2: RRS  port map (databo21,databo22,databo23,databo24,rq2,Sel2,b2);
        rrs3: RRS  port map (databo31,databo32,databo33,databo34,rq3,Sel3,b3);
        rrs4: RRS  port map (databo41,databo42,databo43,databo44,rq4,Sel4,b4);
        
        o1: Register_8bit port map (rclock,rst,rqb1,b1,datao1);
        o2: Register_8bit port map (rclock,rst,rqb2,b2,datao2);
        o3: Register_8bit port map (rclock,rst,rqb3,b3,datao3);
        o4: Register_8bit port map (rclock,rst,rqb4,b4,datao4);
        
    end RTL;
