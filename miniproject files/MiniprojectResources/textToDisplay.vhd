library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

ENTITY textToDisplay IS
	PORT(	clock_25Mhz: IN	STD_LOGIC;
		mode: IN STD_LOGIC_VECTOR(2 downto 0); --- main menu texts,score, game over text, game finished text
		pix_row, pix_col: IN STD_LOGIC_VECTOR(9 downto 0);
		score: IN integer;
		lives: IN integer;
		character_address	:	OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		textOn: OUT  STD_LOGIC);
end textToDisplay;

architecture a OF textToDisplay IS
	signal p_row: integer;
	signal p_col: integer;
	signal charvalue: std_logic_vector(5 downto 0);
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
	type livesTitle is array(0 to 5) of std_logic_vector(5 downto 0);
   signal sig_lifeT : livesTitle := ("001100","001001","010110","000101","010011","100000"); --lives[space]
	type scoreTitle is array(0 to 5) of std_logic_vector(5 downto 0);
   signal sig_scoreT : scoreTitle := ("010011","000011","001111","010010","000101","100000") ; -- Score[space]
	
	type numberScore is array(0 to 9) of std_logic_vector(5 downto 0);
	signal sigNumScore: numberScore:= ("110000","110001", "110010", "110011", "110100", "110101", "110110", "110111", "111000", "111001");
	-- numbers from 0 to 9
	
	type gameOver is array(0 to 9) of std_LOGIC_VECTOR(5 downto 0);
	signal siggameOver: gameOver:= ("000111","000001","001101","000101", "100000","001111","011001","000101","010010","100000");
	
	
	
	

	
	
begin
process(clock_25Mhz,p_row,p_col,pix_row,pix_col,mode,sig_title,sig_trainT,sig_normT, sigNumScore,siggameOver,charvalue, sig_lifeT, score, sig_scoreT,lives)
variable tens, ones, hundereds: integer := 0;
begin

	
	if rising_edge(clock_25Mhz)then
		p_row <= conv_integer(pix_row);
		p_col <= conv_integer(pix_col);
		textOn <= '0';
		
		if (score < 10) then
					ones := score;
					tens:= 0;
					hundereds := 0;
		elsif(score > 9) then
					ones := score mod 10;
					tens := score/10;
					hundereds := 0;
		elsif(score >99) then
					ones := score mod 100;
					tens := score mod 10;
					hundereds := score/100;
		end if;
		 
		
		------------------------------------------------ Flappy Bird Title
		if(mode = "000") then
			
			for i in 0 to 11 loop
				if(96<p_row and p_row<128) and (((i-1)*32)+96<p_col and p_col<96+(i*32))	 then
					textOn <= '1';
					charvalue <= sig_title(i);
					character_address <= charvalue ; -- L
					font_row <= pix_row(4 downto 2);
					font_col <= pix_col(4 downto 2);
				elsif((96<p_row and p_row<128) and p_col<64) then -- to get rid of the lines
					character_address <= "100000";
				end if;
			end loop;
		
			-- train start instructions
			for i in 0 to 24 loop
				
				if(320<p_row and p_row<336) and (((i-1)*16)+96<p_col and p_col<96+(i*16))	 then
					textOn <='1';
					charvalue <= sig_trainT(i);
					character_address <= charvalue ; 
					font_row <= pix_row(3 downto 1);
					font_col <= pix_col(3 downto 1);
				end if;
			end loop;
		
			-- Normal game mode start instruction
			for i in 0 to 23 loop
				if(336<p_row and p_row<352) and (((i-1)*16)+96<p_col and p_col<96+(i*16))	 then
					textOn <='1';
					charvalue <= sig_normT(i);
					character_address <= charvalue ; 
					font_row <= pix_row(3 downto 1);
					font_col <= pix_col(3 downto 1);
				end if;
			end loop;
		
		
		--------------------------------------------------------------TrainingMode (639x479)
		elsif (mode = "001") then 
		
				for i in 0 to 5 loop
					if(32<p_row and p_row<48) and (((i-1)*16)+16<p_col and p_col<16+(i*16))	 then
						textOn <= '1';
						charvalue <= sig_lifeT(i);
						character_address <= charvalue ; -- L
						font_row <= pix_row(3 downto 1);
						font_col <= pix_col(3 downto 1);
						end if;
				end loop;
					
				if(32<p_row and p_row<48) and (96<p_col and p_col<112) then
						textOn <= '1';
						charvalue <= sigNumScore(lives);		-- display life
						font_row <= pix_row(3 downto 1);
						font_col <= pix_col(3 downto 1);
				else
					textOn<='0';
				end if;
				
				--------------------------------- Check score
					
				for i in 0 to 8 loop
					if(96<p_row and p_row<128) and (((i-1)*32)+224<p_col and p_col<224+(i*32))	 then
						textOn <= '1';
						
						-- display numbers 
							if (i = 6) then
								charvalue <=sigNumScore(hundereds);
							elsif(i = 7) then
								charvalue <= sigNumScore(tens);
							elsif(i = 8) then
								charvalue <=sigNumScore(ones);
							
							-- display SCORE[space]
							else
								charvalue <= sig_scoreT(i);
							end if;
				
							character_address <= charvalue ; -- L
							font_row <= pix_row(4 downto 2);
							font_col <= pix_col(4 downto 2);
						end if;
					end loop;

		
		
		
		
		
		
		-------------------------------------------------------------- Game mode
		
		elsif (mode = "010") then 
		
					for i in 0 to 5 loop
						if(32<p_row and p_row<48) and (((i-1)*16)+16<p_col and p_col<16+(i*16))	 then
						textOn <= '1';
						character_address <= charvalue ; -- L
						font_row <= pix_row(3 downto 1);
						font_col <= pix_col(3 downto 1);
						end if;
					end loop;
					
					
					if(32<p_row and p_row<48) and (96<p_col and p_col<112)	then
						textOn <= '1';
						charvalue <= sigNumScore(lives);		-- display life
						font_row <= pix_row(3 downto 1);
						font_col <= pix_col(3 downto 1);
					else
						textOn <= '0';
					end if;
					--------------------------------- Check score
				
					
					for i in 0 to 8 loop
		
						if(96<p_row and p_row<128) and (((i-1)*32)+224<p_col and p_col<224+(i*32))	 then
							textOn <= '1';
							-- display numbers 
							if (i = 6) then
								charvalue <=sigNumScore(hundereds);
							elsif(i = 7) then
								charvalue <= sigNumScore(tens);
							elsif(i = 8) then
								charvalue <=sigNumScore(ones);
							
							-- display SCORE[space]
							else
								charvalue <= sig_scoreT(i);
							end if;
						
							character_address <= charvalue ; -- L
							font_row <= pix_row(4 downto 2);
							font_col <= pix_col(4 downto 2);
						end if;
					end loop;
					
		 
		
		elsif(mode = "011") then
			for i in 0 to 9 loop
					if(96<p_row and p_row<128) and (((i-1)*32)+224<p_col and p_col<224+(i*32))	 then
						textOn <= '1';
						charvalue <= siggameOver(i);
						character_address <= charvalue ; -- L
						font_row <= pix_row(4 downto 2);
						font_col <= pix_col(4 downto 2);
					end if;
					end loop;
		 
		end if;
	end if;
end process;	 
end a;