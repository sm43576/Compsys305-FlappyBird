library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY textToDisplay IS
	PORT(	clock_25Mhz: IN	STD_LOGIC;
		mode: IN STD_LOGIC_VECTOR(2 downto 0); --- main menu texts,score, game over text, game finished text
		pix_row, pix_col: IN STD_LOGIC_VECTOR(9 downto 0);
		character_address	:	OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
end textToDisplay;

architecture a OF textToDisplay IS
	signal p_row: integer;
	signal p_col: integer;
	signal value: std_logic_vector(5 downto 0);
	type title is array(0 to 11) of std_logic_vector(5 downto 0);
   signal sig_title : title := ("000110","001100","000001","010000",
											"010000","011001","100000", "000010", 
											"001001", "010010","000100","100000"); -- FLAPPY BIRD
	type trainTitle is array(0 to 24) of std_logic_vector(5 downto 0);
   signal sig_trainT : trainTitle := ("011000","010110","000001","001011","010000",
													"100000","001111","010001","000100","000101",
													"100000","010100","010110","000101","010111",
													"010111", "100000", "000010","011001","011000",
													"011000","010001","010000", "100000","111100"); -- TRAIN MODE PRESS BUTTON 0
	type normTitle is array(0 to 23) of std_logic_vector(5 downto 0);
   signal sig_normT : normTitle := ("000111","000001","001111","000101", "100000", 
												"001111","010001","000100","000101", "100000",
												"010100","010110","000101","010111","010111", 
												"100000", "000010","011001","011000","011000",
												"010001","010000", "100000","111101"); -- GAME MODE PRESS BUTTON 1
	

	
	
begin
process(clock_25Mhz)
begin
	p_row <= conv_integer(unsigned(pix_row));
	p_col <= conv_integer(unsigned(pix_col));
	--if(mode = '000') then
	
	-- Flappy Bird Title
	for i in 0 to 11 loop
	
		if(96<p_row and p_row<128) and (((i-1)*32)+96<p_col and p_col<96+(i*32))	 then
			value <= sig_title(i);
			character_address <= value ; -- L
			font_row <= pix_row(4 downto 2);
			font_col <= pix_col(4 downto 2);
		end if;
	end loop;
	
	-- train start instructions
	for i in 0 to 24 loop
	
		if(320<p_row and p_row<336) and (((i-1)*16)+96<p_col and p_col<96+(i*16))	 then
			value <= sig_trainT(i);
			character_address <= value ; 
			font_row <= pix_row(3 downto 1);
			font_col <= pix_col(3 downto 1);
		end if;
	end loop;
	
	-- Normal game mode start instruction
	for i in 0 to 23 loop
		if(336<p_row and p_row<352) and (((i-1)*16)+96<p_col and p_col<96+(i*16))	 then
			value <= sig_normT(i);
			character_address <= value ; 
			font_row <= pix_row(3 downto 1);
			font_col <= pix_col(3 downto 1);
		end if;
	end loop;
	--elsif (mode = '001') then
	-- score
	
	--elsif(mode = '010') then
	 -- game over text
	 
	 --elseif (mode = '011') then
	 -- game finished text
end process;	 
end a;