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
   signal sig_trainT : trainTitle := ("010100","010010","000001","001001","001110","100000", -- TRAIN[SPACE]
												"001101","001111","000100","000101","100000", -- MODE[SPACE]
												"010000","010010","000101","010011","010011", "100000", --PRESS[SPACE]
												"000010","010101","010100","010100","001111","001110", --- BUTTON
												"100000", "110000"); -- [SPACE]0
	type normTitle is array(0 to 23) of std_logic_vector(5 downto 0);
   signal sig_normT : normTitle := ("000111","000001","001101","000101", "100000", -- GAME[space]
												"001101","001111","000100","000101", "100000", -- MODE[SPACE]
												"010000","010010","000101","010011","010011","100000", -- PRESS[SPACE]
												"000010","010101","010100","010100","001111","001110", "100000", -- BUTTON[SPACE]
												"110001"); -- 1
	

	
	
begin
process(clock_25Mhz,p_row,p_col,pix_row,pix_col,		mode,sig_title,sig_trainT,sig_normT)
begin
	p_row <= conv_integer(unsigned(pix_row));
	p_col <= conv_integer(unsigned(pix_col));
	
	if(mode = "000") then
	
		-- Flappy Bird Title
		for i in 0 to 11 loop
		
			if(96<p_row and p_row<128) and (((i-1)*32)+96<p_col and p_col<96+(i*32))	 then
				value <= sig_title(i);
				character_address <= value ; -- L
				font_row <= pix_row(4 downto 2);
				font_col <= pix_col(4 downto 2);
			elsif((96<p_row and p_row<128) and p_col<64) then -- to get rid of the lines
				character_address <= "100000";
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
	elsif (mode = "001") then
		if((96<p_row and p_row<128) and (96<p_col and p_col<128)) then
			character_address <= "000001" ;
			font_row <= pix_row(4 downto 2);
			font_col <= pix_col(4 downto 2);
		end if;
	
	
	--elsif(mode = "010'") then
	 -- game over text
	 
	--elsif (mode = "011") then
	 -- game finished text
	end if;
end process;	 
end a;