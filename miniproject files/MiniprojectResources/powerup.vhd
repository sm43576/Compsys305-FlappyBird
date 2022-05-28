-- put the power up so that pipe is infront of the poweru
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY powerup IS
	PORT
		( clk, vert_sync	: IN std_logic;
		  mode: IN std_logic_vector(2 downto 0);
        pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue,powerup 			: OUT std_logic;	
		  powerup_on 			: OUT std_logic);		
END powerup;

architecture behavior of powerup is

SIGNAL temp_powerup_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL powerup_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL powerup_x_pos				: std_logic_vector(10 DOWNTO 0); --changed from 10 to 9
SIGNAL powerup_x_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN     
--dimension 639x479
		-- random number generator for new length and gap where length 25<=x<=450, gap 50<=x<=200
		
size <= CONV_STD_LOGIC_VECTOR(6,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

						-- and here is adding 0 to ball_x_pos making it unsigned
temp_powerup_on <= '1' when ( ('0' & powerup_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & powerup_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & powerup_y_pos <= pixel_row + size) and ('0' & pixel_row <= powerup_y_pos + size) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
--checks if pixel is in the ball boundary 
powerup_on <= temp_powerup_on	;

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <=  not temp_powerup_on;
Green <= not temp_powerup_on;
Blue <=  '1';

Spawn_Powerup: process (vert_sync)  
variable counter :integer:=0;	
begin
-- change x1 and x2 accordingly and set it
--then move
	if (rising_edge(vert_sync)) then
		-- how many seconds per vert_sync ,640 by 480
		
		if (powerup_x_pos <= CONV_STD_LOGIC_VECTOR(0,11) or mode = "000")then
			counter := 0;
			
		elsif (counter < 3000) then--81.38 frames per second so for 4
			counter := counter+1;
			
		elsif(counter = 3000) then
			powerup_x_pos <= CONV_STD_LOGIC_VECTOR(638,11);	
			
		end if;
		
		
		if (powerup_x_pos > CONV_STD_LOGIC_VECTOR(0,11)and powerup_x_pos < CONV_STD_LOGIC_VECTOR(639,11))  then
			powerup_x_motion <= -CONV_STD_LOGIC_VECTOR(6,11); -- move left to right
			powerup_x_pos <= powerup_x_pos + powerup_x_motion	;
			
			
	   end if;
		
end if;

end process Spawn_Powerup;



end behavior;    