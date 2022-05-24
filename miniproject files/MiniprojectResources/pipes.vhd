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

SIGNAL temp_pipe1_on			: std_logic;
signal temp_pipe2_on			: std_logic;
SIGNAL sizex 					: std_logic_vector(9 DOWNTO 0);
signal sizey 					: std_logic_vector(9 downto 0);  
SIGNAL pipe1_y_pos			: std_logic_vector(9 DOWNTO 0);
signal pipe2_y_pos			: std_logic_vector(9 downto 0);
SiGNAL pipe_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL pipe_x_motion			: std_logic_vector(9 DOWNTO 0);


BEGIN     
sizex <= CONV_STD_LOGIC_VECTOR(20,10); -- 20 pixels in width
sizey <= CONV_STD_LOGIC_VECTOR(100,10); -- height may change depending on random numeber
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of pipe

pipe_x_pos <= CONV_STD_LOGIC_VECTOR(600,11);
pipe1_y_pos <= CONV_STD_LOGIC_VECTOR(100,10);
pipe2_y_pos <= CONV_STD_LOGIC_VECTOR(360,10);

						-- and here is adding 0 to ball_x_pos making it unsigned
temp_pipe1_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + sizex) and ('0' & pixel_column <= '0' & pipe_x_pos + sizex) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipe1_y_pos <= pixel_row + sizey) and ('0' & pixel_row <= pipe1_y_pos + sizey) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
temp_pipe2_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + sizex) and ('0' & pixel_column <= '0' & pipe_x_pos + sizex) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipe2_y_pos <= pixel_row + sizey) and ('0' & pixel_row <= pipe2_y_pos + sizey) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
--checks if pixel is in the ball boundary 
pipe_on <= temp_pipe1_on and temp_pipe2_on;

end behavior;   