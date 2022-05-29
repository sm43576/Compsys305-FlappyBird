LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY collision IS
	PORT
		( clk, vert_sync	: IN std_logic;
			 ball_x, pipe1_x, pipe2_x : IN std_logic_vector(10 downto 0);
			 ballOn, Pipe1On	: IN std_logic; --  to check y position of ball with y position of pipe
			 pipetop_y, pipebtm_y, ball_y : IN std_logic_vector(9 downto 0);
			 pUp_x, pUp_y: IN std_logic_vector(9 downto 0);
			 mode : IN std_logic_vector(2 downto 0);
		    lives, score			: OUT Integer);		
END collision;

architecture behavior of collision is
signal temp_lives	: integer:=3 ;
signal temp_score: integer;
signal counter:integer:=0;
signal isCollisionPipe: std_logic;
signal pipeTopMin_y : std_logic_vector(9 downto 0);
signal pipeBtmMax_y : std_logic_vector(9 downto 0);


BEGIN
	pipeTopMin_y <="0000000000"; -- 0
	pipeBtmMax_y <="0111011111"; -- 479
	
	--isCollisionPipe <= '1' when (ballOn = '1' and Pipe1on = '1') else '0';---isCollisionPipe <= '1' when (ballOn = '1' and pipe1On = '1') else '0';
	
	
checkCollison: process(vert_sync, clk)

BEGIN

	if(mode = "000" or mode = "011") then
		temp_lives <= 3;
		counter <= 0;
		temp_score<=0;
		lives <= temp_lives;
		score <= temp_score;
								 							
	elsif(rising_edge(clk) and vert_sync = '1' and (mode = "001" or mode = "010")) then
		
		--Checks if ball has been hit
		if (temp_lives <= 0)then
			temp_lives<=0;
		
		
		elsif((ballOn = '1' and Pipe1on = '1') and (ball_x  < pipe1_x + 20  and ball_x +8 > pipe1_x) and (ball_y < pipetop_y or ball_y > pipebtm_y)
			and counter > 100000000) then
			temp_lives<=temp_lives-1;
			counter<=0;
			
		
		
		
		elsif(counter>100000000) then --betrween 250 - 800 million
 -- if ball is between the gap
			temp_score<=temp_score+1;
			counter<=0;
		end if;
	
		-- Update lives and score outputs
		lives <= temp_lives;
		score <= temp_score;
		counter <= counter+1;
	end if;
	
end process checkCollison;
end behavior;