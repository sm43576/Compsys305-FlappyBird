LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipes IS
	PORT
		( clk, vert_sync	: IN std_logic;
			mode: IN std_logic_vector(2 downto 0);
        pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  pipe_on 			: OUT std_logic);		
END pipes;

architecture behavior of pipes is

SIGNAL temp_ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL top_pipe_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL pipe_x_pos				: std_logic_vector(10 DOWNTO 0); --change to match mouse movement.
SIGNAL pipe_x_motion			: std_logic_vector(9 DOWNTO 0);


BEGIN        
size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

ball_x_pos <= CONV_STD_LOGIC_VECTOR(590,11);
--ball_y_pos <= CONV_STD_LOGIC_VECTOR(10,10);

						-- and here is adding 0 to ball_x_pos making it unsigned
temp_ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
--checks if pixel is in the ball boundary 
ball_on <= temp_ball_on;

end behavior;   