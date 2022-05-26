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
SIGNAL pipe_x_motion			: std_logic_vector(10 DOWNTO 0);
signal newLength :integer;
signal gap : integer;
signal y1:integer;
signal y2:integer;


BEGIN     
--dimension 639x479
		-- random number generator for new length and gap where length 25<=x<=450, gap 50<=x<=200
		newLength <= 25; --length of first pipe?
		gap <= 50; --gap

		y2<= newLength+gap;  --329
		sizex <= CONV_STD_LOGIC_VECTOR(20,10); -- 20 pixels in width
		sizey <= CONV_STD_LOGIC_VECTOR(newLength,10); -- height may change depending on random numeber
		-- ball_x_pos and ball_y_pos show the (x,y) for the centre of pipe

		--pipe_x_pos <= CONV_STD_LOGIC_VECTOR(600,11);
		pipe1_y_pos <= CONV_STD_LOGIC_VECTOR(0,10);
		pipe2_y_pos <= CONV_STD_LOGIC_VECTOR(y2,10);

								-- and here is adding 0 to ball_x_pos making it unsigned
		temp_pipe1_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + sizex) and ('0' & pixel_column <= '0' & pipe_x_pos + sizex) 	-- x_pos - size <= pixel_column <= x_pos + size
							and ('0' & pixel_row >= 0) and ('0' & pixel_row <= sizey) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
					'0';
		temp_pipe2_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + sizex) and ('0' & pixel_column <= '0' & pipe_x_pos + sizex) 	-- x_pos - size <= pixel_column <= x_pos + size
							and ('0' & pipe2_y_pos <= pixel_row) and ('0' & pixel_row <= 479) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
					'0';
--checks if pixel is in the ball boundary 
pipe_on <= temp_pipe1_on or temp_pipe2_on;

Spawn_Move_pipe: process (vert_sync)  	
variable resetPipe: std_logic := '1';
begin
-- change x1 and x2 accordingly and set it
--then move
	if (rising_edge(vert_sync)) then
		if(pipe_x_pos <= CONV_STD_LOGIC_VECTOR(0,11) or mode = "000") then
			resetPipe := '1';
		end if;
		
		if (resetPipe = '1')  then 
			
			pipe_x_pos <= CONV_STD_LOGIC_VECTOR(638,11);
			resetPipe := '0';
			
		
		elsif (pipe_x_pos > CONV_STD_LOGIC_VECTOR(0,11)and pipe_x_pos < CONV_STD_LOGIC_VECTOR(639,11))  then 
			pipe_x_motion <= -CONV_STD_LOGIC_VECTOR(2,11); -- move left to right
			pipe_x_pos <= pipe_x_pos + pipe_x_motion;
		
		end if;
	
		-- Compute next ball Y position
		
	end if;

end process Spawn_Move_pipe;



end behavior;   