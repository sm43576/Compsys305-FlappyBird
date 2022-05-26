
-- Modified from https://surf-vhdl.com/how-to-implement-galois-multiplier-in-vhdl/
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY randomNum IS
  PORT (Clk, Rst: IN std_logic;
        output: OUT std_logic_vector (7 DOWNTO 0));
END randomNum;

ARCHITECTURE generator OF randomNum IS
  	signal holder         : std_logic;
	
	signal bitVector: integer := 8;  

begin
process(clk,Rst)
variable randVector: std_logic_vector(7 downto 0):= ('0','0','0','1','1','1','1','0');
  begin
  
	--randVector <= (others<='0');
   
	for i in 0 to bitVector-1 loop
	
		holder <= randVector(7);
		randVector(7) := randVector(6);
		randVector(6) := randVector(5);
		randVector(5) := randVector(4);
		randVector(4) := randVector(3) xor holder;
		randVector(3) := randVector(2) xor holder;
		randVector(2) := randVector(1) xor holder;
		randVector(1) := randVector(0);
		randVector(0) := holder;
	
	  output <= randVector;
	end loop;
  END PROCESS;
  

END generator;