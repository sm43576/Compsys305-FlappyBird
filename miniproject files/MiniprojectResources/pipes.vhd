LIBRARY IEEE;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY pipes IS
	PORT
		( clk, vert_sync	: IN std_logic;
			mode: IN std_logic_vector(2 downto 0);
			randomNumber: IN std_logic_vector(7 downto 0);
        pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  resetNumGen: 	out std_logic;
		  pipe_on 			: OUT std_logic;
		  pipe_x : out std_logic_vector(10 downto 0));		
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
signal newLength :std_logic_vector(9 downto 0);
signal gap : std_logic_vector(9 downto 0):= "0001100100"; -- 50 pixel gap
signal reset: std_logic:='1';
signal y1:integer;
signal y2:std_logic_vector(9 downto 0);


BEGIN     
--dimension 639x479
		-- random number generator for new length and gap where length 25<=x<=450, gap 50<=x<=200
		
		sizex <= CONV_STD_LOGIC_VECTOR(20,10); -- 20 pixels in width
		sizey <= newLength; -- height may change depending on random numeber
		-- ball_x_pos and ball_y_pos show the (x,y) for the centre of pipe
		y2<= newLength+gap;  -- determiens y2 pos
		--pipe_x_pos <= CONV_STD_LOGIC_VECTOR(600,11);
		pipe1_y_pos <= CONV_STD_LOGIC_VECTOR(0,10);
		pipe2_y_pos <= y2;

								-- and here is adding 0 to ball_x_pos making it unsigned
		temp_pipe1_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + sizex) and ('0' & pixel_column <= '0' & pipe_x_pos + sizex) 	-- x_pos - size <= pixel_column <= x_pos + size
							and ('0' & pixel_row >= pipe1_y_pos) and ('0' & pixel_row <= sizey) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
					'0';
		temp_pipe2_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + sizex) and ('0' & pixel_column <= '0' & pipe_x_pos + sizex) 	-- x_pos - size <= pixel_column <= x_pos + size
							and ('0' & pipe2_y_pos <= pixel_row) and ('0' & pixel_row <= 479) and (mode = "001" or mode = "010") )  else	-- y_pos - size <= pixel_row <= y_pos + size
					'0';
--checks if pixel is in the ball boundary 
pipe_on <= temp_pipe1_on or temp_pipe2_on;

Spawn_Move_pipe: process (vert_sync,newLength,y2)  	
variable holdLength:std_logic_vector(9 downto 0);
begin
-- change x1 and x2 accordingly and set it
--then move
	if (rising_edge(vert_sync)) then
		if(pipe_x_pos <= CONV_STD_LOGIC_VECTOR(0,11) or mode = "000") then

			holdLength := "00"& randomNumber;
			
			if (holdLength <= "0000110010") then -- less than 50 pixels
				holdLength:= holdLength + "0000110010"; -- add 50 pixels
	
			end if;
			
			newLength<=holdLength;
			
			pipe_x_pos <= CONV_STD_LOGIC_VECTOR(638,11);	
		
		elsif (pipe_x_pos > CONV_STD_LOGIC_VECTOR(0,11)and pipe_x_pos < CONV_STD_LOGIC_VECTOR(639,11))  then
			pipe_x_motion <= -CONV_STD_LOGIC_VECTOR(12,11); -- move left to right
			pipe_x_pos <= pipe_x_pos + pipe_x_motion;
			pipe_x  <= pipe_x_pos;
		
		end if;
		resetNumGen<='1';
		-- Compute next ball Y position
end if;

end process Spawn_Move_pipe;



end behavior;   