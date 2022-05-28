LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY collision IS
	PORT
		( clk, vert_sync	: IN std_logic;
			 ball_x, pipe1_x, pipe2_x : IN std_logic_vector(10 downto 0);
			 ballOn, Pipe1On,  Pipe2On	: IN std_logic; --  to check y position of ball with y position of pipe
			 pUp_x, pUp_y: std_logic_vector(9 downto 0);
			 mode : IN std_logic_vector(2 downto 0);
		  lives, score			: OUT Integer);		
END collision;

architecture behavior of collision is

SIGNAL temp_lives	: integer;
signal temp_score: integer;
signal counter:integer:=0;



BEGIN
checkCollison: process(vert_sync)
BEGIN
	if(mode = "000") then
		temp_lives <= 3;
		temp_score <= 0;
		lives <= temp_lives;
		score <= temp_score;
	end if;
		
	if (temp_lives<=0)then
		temp_lives<=0;
		
	--Checks if ball has been hit
	elsif((ballOn = '1' and pipe1On = '1') or (ballOn = '1' and pipe2On = '1')) then
	
		if (counter >20) then
			temp_lives<=temp_lives-1;
			counter<=0;
		end if;
	
		
	elsif((ball_x >= pipe1_x) and (ballOn /= pipe1On) ) then -- if ball is between the gap
		temp_score<=temp_score+1;
		
	end if;
	
	lives <= temp_lives;
	score <= temp_score;
	counter<= counter+1;
	
end process checkCollison;
end behavior;