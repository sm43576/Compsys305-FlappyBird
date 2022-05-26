LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY collision IS
	PORT
		( clk, vert_sync	: IN std_logic;
			resetTrainMode, resetGameMode		: IN std_logic_;
			 ball_x, pipe1_x, pipe2_x : IN std_logic_vector(10 downto 0);
          ball_y	: IN std_logic_vector(9 DOWNTO 0);
			 pipe1Top_Maxy, pipe1Bottom_Miny	: IN std_logic_vector(9 downto 0); -- top pipe ranges from 0 to A, bottom pipe ranges from B to 479 
			 pipe2Top_Maxy, pipe2Bottom_Miny	: IN std_logic_vector(9 downto 0);
			 pUp_row, pUp_col : std_logic_vector(9 downto 0);
			 mode : IN std_logic_vector(2 downto 0);
		  lives, score			: OUT Integer);		
END collision;

architecture behavior of collision is

SIGNAL isCollision					: std_logic;



BEGIN
checkCollison: process(clk)
BEGIN
	if(resetTrainMode = '1') then
		lives = 5;
		score = 0;
	elsif(mode = '0') then
		lives = 3;
		score = 0;
	end if;
		
	-- Checks if ball has been hit
	if((ball_x = pipe1_x and ((ball_y >= 0 and ball_y <= pipe1Top_Maxy)  -- Ball in range of top pipe 0 <=y<= Top pipe max
											or (ball_y >= pipe1Bottom_Miny and ball_y <= 479)) )) then -- ball in range of bottom pipe: min bottom pipe <=y <= 479
		lives = lives -1;
	
	elsif(ball_x = pipe2_x and (ball_y >= 0 and ball_y<= pipe2Top_Maxy) 
											or(ball_y >= pipe2Bottom_Miny and ball_y <= 479))) then
		lives = lives -1;
		
	elsif(ball_x = pipe1_x and ((ball_y > pipe1Top_Maxy and ball_y < pipe1Bottom_Miny) 
												or(ball_y > pipe2Top_Maxy and ball_y < pipe2Bottom_Miny))) then -- if ball is between the gap
		score = score +1;
		
	end if;
	
	
end process checkCollison;
end behavior;