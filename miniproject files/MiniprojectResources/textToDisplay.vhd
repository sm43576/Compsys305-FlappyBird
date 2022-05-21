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
	
	if(100<p_row and p_row<132) and (100<p_col and p_col<132)then
			--- main menu texts
		character_address <= "000001";
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
	end if;
	
	if(100<p_row and p_row<132) and (132<p_col and p_col<164)then
			--- main menu texts
		character_address <= "000010";
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