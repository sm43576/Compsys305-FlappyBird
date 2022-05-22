library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Priority IS
	PORT(	clock_25Mhz, vert_sync: IN	STD_LOGIC;
			redBird, greenBird, blueBird, birdOn		: IN	STD_LOGIC;
			redPipe, greenPipe, bluePipe, pipeOn		: IN	STD_LOGIC;
			redBgn, greenBgn, blueBgn, bgnOn				: IN	STD_LOGIC;
			redText, greenText, blueText, textOn		: IN	STD_LOGIC;
			redPowerUp, greenPowerUp, bluePowerUp, powerUpOn		: IN	STD_LOGIC;
			red_out, green_out, blue_out	: OUT	STD_LOGIC);
end Priority;

architecture a OF Priority IS
	signal tempRedOut, tempGreenOut, tempBlueOut: std_logic;
	
begin
prioritise: process (clock_25Mhz)  	
begin
-- Assume first if is in foreground and last elsif is in background
	if(rising_edge(clock_25Mhz)) then
		if(birdOn = '1') then
			tempRedOut <= redBird;
			tempGreenOut <= greenBird;
			tempBlueOut <= blueBird;
		
		elsif(pipeOn = '1') then
			tempRedOut <= redPipe;
			tempGreenOut <= greenPipe;
			tempBlueOut <= bluePipe;
		
		elsif(powerUpOn = '1') then
			tempRedOut <= redPowerUp;
			tempGreenOut <= greenPowerUp;
			tempBlueOut<= bluePowerUp;
		
		elsif(textOn = '1') then
			tempRedOut <= redText;
			tempGreenOut<= greenText;
			tempBlueOut <= blueText;
		
		elsif(bgnOn ='1') then
			tempRedOut <= redBgn;
			tempGreenOut <= greenBgn;
			tempBlueOut <= blueBgn;
		end if;
	red_out <= tempRedOut;
	green_out <= tempGreenOut;
	blue_out <= tempBlueOut;
	end if;
end process prioritise;
end a;