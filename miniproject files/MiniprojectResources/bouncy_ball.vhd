LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		( pb1, clk, vert_sync	: IN std_logic;
			mouse_col: IN std_logic_vector(9 downto 0);
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			 mode : IN std_logic_vector(2 downto 0);
		  red, green, blue, ball_on 			: OUT std_logic);		
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL temp_ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0); --change to match mouse movement.
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);


BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

ball_x_pos <= CONV_STD_LOGIC_VECTOR(590,11);
--ball_y_pos <= CONV_STD_LOGIC_VECTOR(10,10);

						-- and here is adding 0 to ball_x_pos making it unsigned
temp_ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
--checks if pixel is in the ball boundary 
ball_on <= temp_ball_on;

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <=  '1';
Green <= not temp_ball_on;
Blue <=  not temp_ball_on;



Move_Ball: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then			
		if (pb1='1' and   ball_y_pos > CONV_STD_LOGIC_VECTOR(0,10))then
			ball_y_motion <= -CONV_STD_LOGIC_VECTOR(2,10); -- ball goes up 
			
		elsif (ball_y_pos < CONV_STD_LOGIC_VECTOR(479,10)) then 
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(2,10); -- stops ball at height
	
		
	elsif ( ball_y_pos > CONV_STD_LOGIC_VECTOR(479,10)) then
			ball_y_motion <=  CONV_STD_LOGIC_VECTOR(0,10); 
			
		end if;
		-- Compute next ball Y position
		ball_y_pos <= ball_y_pos + ball_y_motion;
	end if;
end process Move_Ball;

END behavior;

