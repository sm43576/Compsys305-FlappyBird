
-- Modified from https://surf-vhdl.com/how-to-implement-galois-multiplier-in-vhdl/

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY randomNum IS
  PORT (Clk, Rst: IN std_logic;
        output: OUT std_logic_vector (7 DOWNTO 0));
	
END randomNum;

ARCHITECTURE generator OF randomNum IS
  	signal holder         : std_logic;
	signal bitVector: integer := 8;  
	signal randVector: std_logic_vector(7 downto 0):=  (others =>('0'));

begin
process(clk,Rst)

  begin
  
	--randVector <= (others<='0');
   if(rising_edge(Clk)) then
	if(Rst = '1') then
		randVector <= "00011101";
	end if;
	for i in 0 to bitVector-1 loop
	
		holder <= randVector(7);
		randVector(7) <= randVector(6);
		randVector(6) <= randVector(5);
		randVector(5) <= randVector(4);
		randVector(4) <= randVector(3) xor holder;
		randVector(3) <= randVector(2) xor holder;
		randVector(2) <= randVector(1) xor holder;
		randVector(1) <= randVector(0);
		randVector(0) <= holder;
	end loop;
	  output <= randVector;
	
	end if;
  END PROCESS;
  

END generator;