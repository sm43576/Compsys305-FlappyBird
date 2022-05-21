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
begin
process(clock_25Mhz)
begin
	p_row <= conv_integer(unsigned(pix_row));
	p_col <= conv_integer(unsigned(pix_col));
	--if(mode = '000') then
	
	--title[]= ["000110", "001100", "000001", "010000", "010000", "011001", "100000", "000010", "001001", "010010", "000100"];
	
	
	if(96<p_row and p_row<128) and (96<p_col and p_col<128)then
			--- main menu texts
		character_address <= "000110"; -- F
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	
	elsif(96<p_row and p_row<128) and (128<p_col and p_col<160)then
			--- main menu texts
		character_address <= "001100"; -- L
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (160<p_col and p_col<192)then
			--- main menu texts
		character_address <= "000001"; -- A
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
		
	elsif(96<p_row and p_row<128) and (192<p_col and p_col<224)then
			--- main menu texts
		character_address <= "010000"; -- P
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (224<p_col and p_col<256)then
			--- main menu texts
		character_address <= "010000"; -- P
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (256<p_col and p_col<288)then
			--- main menu texts
		character_address <= "011001"; --Y
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (288<p_col and p_col<320)then
			--- main menu texts
		character_address <= "100000"; -- space
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (320<p_col and p_col<352)then
			--- main menu texts
		character_address <= "000010"; -- B
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (352<p_col and p_col<384)then
			--- main menu texts
		character_address <= "001001"; --I
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	elsif(96<p_row and p_row<128) and (384<p_col and p_col<416)then
			--- main menu texts
		character_address <= "010010"; -- R
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	elsif(96<p_row and p_row<128) and (416<p_col and p_col<448)then
			--- main menu texts
		character_address <= "000100"; -- D
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	elsif(((96<p_row and p_row<128)and(0<p_col and p_col<96)) or((96<p_row and p_row<128)and(448<p_col)) ) then
		character_address <= "100000"; -- space
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	
	end if;
	--elsif (mode = '001') then
	-- score
	
	--elsif(mode = '010') then
	 -- game over text
	 
	 --elseif (mode = '011') then
	 -- game finished text
end process;	 
end a;