library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Background IS
	PORT(	clock_25Mhz: IN	STD_LOGIC;
			mode: IN STD_LOGIC_VECTOR (2 downto 0); --- main menu, training mode, game mode, game over, last difficulty background
			backgroundOn: OUT std_logic;
			red_out, green_out, blue_out	: OUT	STD_LOGIC_VECTOR(3 downto 0));
end Background;

architecture a OF Background IS

	signal p_row,p_col: integer;
begin
modeColours:process(clock_25Mhz,mode)
begin
backgroundOn <= '1';
	if(mode = "000") then
	-- Main menu colour (white)
		red_out <= "1111";
		green_out <= "1111";
		blue_out <= "1111";
	
	elsif(mode = "001") then
	--- Training mode
		
		red_out <= "0000";
		green_out <= "1111";
		blue_out <= "1111";

	elsif(mode = "010") then
	--- Game mode
		red_out <= "1000";
		green_out <= "1111";
		blue_out <= "1111";
		
	elsif(mode = "011") then
	--- Game Over

		red_out <= "0000";
		green_out <= "0000";
		blue_out <= "0000";

		
	elsif(mode = "101") then
	--- Last difficulty in game mode
		
		red_out <= "1111";
		green_out <= "1111";
		blue_out <= "0000";
	end if;
	end process modeColours;
end a;

	