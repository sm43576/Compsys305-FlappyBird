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
	
	isCollisionPipe <= '1' when ((ball_x = pipe1_x) and(ball_y <= pipetop_y or ball_y >= pipebtm_y))  	--- ball colliding with bottom pipe (pipebtm_y<= ball_y< 479)
								else		'0' when ((ball_x /= pipe1_x) and (ball_y >pipetop_y) and (ball_y< pipebtm_y)); -- ball is between gap 
	---isCollisionPipe <= '1' when (ballOn = '1' and pipe1On = '1') else '0';
	
	
checkCollison: process(vert_sync, clk, mode)

BEGIN
								 							
	if(rising_edge(clk) and vert_sync = '1') then
		if(mode = "000") then
			temp_lives <= 2;
			counter <= 0;
			temp_score <= 0;
			lives <= temp_lives;
			score <= temp_score;
		elsif (temp_lives <= 0)then
			temp_lives<=0;
		
		--Checks if ball has been hit
		elsif((isCollisionPipe = '1') and counter > 100000) then
			temp_lives<=temp_lives-1;
			counter<=0;
		
		elsif(counter>100000) then
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