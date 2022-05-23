library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Background IS
	PORT(	clock_25Mhz: IN	STD_LOGIC;
			mode: IN STD_LOGIC_VECTOR (2 downto 0); --- main menu, training mode, game mode, game over, last difficulty background
			pix_row, pix_col: IN STD_LOGIC_VECTOR(9 downto 0);
			red_out, green_out, blue_out, backgroundOn	: OUT	STD_LOGIC);
end Background;

architecture a OF Background IS
	signal tempRedOut, tempGreenOut, tempBlueOut: std_logic;
	signal p_row,p_col: integer;
begin
modeColours:process(clock_25Mhz,mode)
begin
p_row <= conv_integer(unsigned(pix_row));
p_col <= conv_integer(unsigned(pix_col));
backgroundOn <= '1';
	if(mode = "000") then
	-- Main menu colour (white)
		if ((p_row >= 0 and p_row <639) and (p_col >=0 and p_col<479)) then
			red_out <= '1';
			green_out <= '1';
			blue_out <= '1';
		end if;
	
	elsif(mode = "001") then
	--- Training mode
		if ((p_row >= 0 and p_row <639) and (p_col >=0 and p_col<479)) then
			red_out <= '1';
			green_out <= '0';
			blue_out <= '0';
		end if;
	
	elsif(mode = "010") then
	--- Game mode
		if ((p_row >= 0 and p_row <639) and (p_col >=0 and p_col<479)) then
			red_out <= '0';
			green_out <= '1';
			blue_out <= '0';
		end if;
		
	elsif(mode = "011") then
	--- Game Over
		if ((p_row >= 0 and p_row <639) and (p_col >=0 and p_col<479)) then
			red_out <= '0';
			green_out <= '0';
			blue_out <= '0';
		end if;
		
	elsif(mode = "100") then
	--- Last difficulty in game mode
		if ((p_row >= 0 and p_row <639) and (p_col >=0 and p_col<479)) then
			red_out <= '1';
			green_out <= '1';
			blue_out <= '0';
		end if;
	end if;
	end process modeColours;
end a;

	