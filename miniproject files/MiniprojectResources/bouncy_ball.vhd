LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		( pb1, clk, vert_sync	: IN std_logic;
			mouse_col: IN std_logic_vector(9 downto 0);
			ball_x : out std_logic_vector(10 downto 0);
			ball_y : out std_logic_vector(9 downto 0);
			ball_on: out std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			 mode : IN std_logic_vector(2 downto 0));		
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL temp_ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0); --changed from 10 to 9
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);


BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

						-- and here is adding 0 to ball_x_pos making it unsigned
temp_ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
--checks if pixel is in the ball boundary 
ball_on <= temp_ball_on;




Move_Ball: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	--if powerup
		--gravity warp change, click reverses gravity
	
	
	--else
	if (rising_edge(vert_sync)) then			
		if (pb1='1' and   ball_y_pos > CONV_STD_LOGIC_VECTOR(1,10)+size)then
			ball_y_motion <= -CONV_STD_LOGIC_VECTOR(8,10); -- ball goes up and stops it from going too high
			
	elsif (ball_y_pos < CONV_STD_LOGIC_VECTOR(475,10)-size)  then 
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(4,10); -- gravity
	
		
	else 
			ball_y_motion <=  CONV_STD_LOGIC_VECTOR(0,10); --stops it from falling past ground
			
		end if;
		-- Compute next ball Y position
		ball_y_pos <= ball_y_pos + ball_y_motion;
		ball_x_pos <= '0'& mouse_col;
		ball_x <= ball_x_pos;
		ball_y <= ball_y_pos;
	end if;
end process Move_Ball;

END behavior;

