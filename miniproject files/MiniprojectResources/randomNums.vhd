
-- Modified from https://surf-vhdl.com/how-to-implement-galois-multiplier-in-vhdl/

library IEEE; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity randomNums IS
  PORT (Clk, Rst: in std_logic;
        output: out std_logic_vector (7 DOWNTO 0));
	
end entity randomNums;

architecture behaviour OF randomNums IS
 	signal holder         : std_logic:='1'; 
	signal randVector: std_logic_vector(7 downto 0):="01111011";


begin
  process (Clk,Rst,randVector)

  begin
if (rising_edge(Clk))then 
  if (Rst ='1') then
    --randVector <= "10101010";
  
  --elsif (Rst = '') then
	for i in 0 to 7 loop
	
		holder <= randVector(i);
		randVector(7) <= randVector(6);
		randVector(6) <= randVector(5);
		randVector(5) <= randVector(4);
		randVector(4) <= randVector(3) xor holder;
		randVector(3) <= randVector(2) xor holder;
		randVector(2) <= randVector(1) xor holder;
		randVector(1) <= randVector(0);
		randVector(0) <= holder;
		
	end loop;
	 end if;
	 for j in 0 to 7 loop
	  output(j)<=randVector(j);
	 end loop;
end if;

	
  end process;
  

end architecture behaviour;

