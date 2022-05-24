LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipes IS
	PORT
		( clk, vert_sync	: IN std_logic;
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

end behavior;   