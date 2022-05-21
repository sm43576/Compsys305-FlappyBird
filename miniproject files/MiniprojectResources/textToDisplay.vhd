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
	type dummy_array is array(0 to 10) of std_logic_vector(5 downto 0);
   signal ins_dummy : dummy_array := ("000110","001100","000001","010000","010000","011001","100000", "000010", "001001", "010010","000100");

	
	
begin
process(clock_25Mhz)
begin
	p_row <= conv_integer(unsigned(pix_row));
	p_col <= conv_integer(unsigned(pix_col));
	--if(mode = '000') then
	
	--title[]= [];
	for i in 0 to 11 loop
	
	
	if(160<p_row and p_row<192) and (((i-1)*32)+96<p_col and p_col<96+(i*32))	 then
	   value <= ins_dummy(i);
		character_address <= value ; -- L
		font_row <= pix_row(4 downto 2);
		font_col <= pix_col(4 downto 2);
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