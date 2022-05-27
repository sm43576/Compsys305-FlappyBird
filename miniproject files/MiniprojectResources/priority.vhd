library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Priority IS
	PORT(	clock_25Mhz, vert_sync: IN	STD_LOGIC;
			birdOn		: IN	STD_LOGIC;
			pipeOn		: IN	STD_LOGIC;
			redBgn, greenBgn, blueBgn: in STD_LOGIC_VECTOR(3 downto 0);
			bgnOn,powerUpOn	: IN	STD_LOGIC;
			textBoxOn,textOn		: IN	STD_LOGIC;
			redPowerUp, greenPowerUp, bluePowerUp  : IN	STD_LOGIC_VECTOR(3 downto 0);
			red_out, green_out, blue_out	: OUT	STD_LOGIC_VECTOR(3 downto 0));
end Priority;

architecture a OF Priority IS
	signal tempRedOut, tempGreenOut, tempBlueOut: STD_LOGIC_VECTOR(3 downto 0);
	
begin
red_out <= tempRedOut;
green_out <= tempGreenOut;
blue_out <= tempBlueOut;
prioritise: process (clock_25Mhz)  	
begin
-- Assume first if is in foreground and last elsif is in background
	if(rising_edge(clock_25Mhz)) then
		if(birdOn = '1') then
			tempRedOut <= "1111";
			tempGreenOut <= "0000";
			tempBlueOut <= "0000";
		
		elsif(pipeOn = '1') then
			tempRedOut <= "0100";
			tempGreenOut <= "1111";
			tempBlueOut <= "0100";
		
		elsif(powerUpOn = '1') then
			tempRedOut <= redPowerUp;
			tempGreenOut <= greenPowerUp;
			tempBlueOut<= bluePowerUp;
		
		elsif(textBoxOn = '1') then -- if the location of pixels is in text
			if(textOn = '1') then -- if there is a text in the pixel
				tempRedOut <= "0000";
				tempGreenOut<= "0000";
				tempBlueOut <= "0000";
			else
				tempRedOut <= redBgn;
				tempGreenOut <= greenBgn;
				tempBlueOut <= blueBgn;
			end if;
			
		elsif(bgnOn = '1') then -- background
			tempRedOut <= redBgn;
			tempGreenOut <= greenBgn;
			tempBlueOut <= blueBgn;
		end if;
	end if;
end process prioritise;
end a;