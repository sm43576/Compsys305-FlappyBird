library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity programableTimer is
  port(clock,Start: in std_logic;
        DataIn: in unsigned(9 downto 0);
        TimeOut: out std_logic;
        Qmins,QTens,Qones: out unsigned(7 downto 0));
end entity programableTimer;

architecture behaviour of programableTimer is
  component BCD_counter is 
    port(Clk,Init,Enable,Direction: in std_logic;
          Q_out: out unsigned(3 downto 0));
  end component BCD_counter;
  
  component BCD2SevenSeg is 
    port (digit : in unsigned(3 downto 0);
          all_off : in std_logic;
          LED_out : out unsigned(7 downto 0));
  end component BCD2SevenSeg;
  
  signal enableOnes: std_logic;
  signal enableMins: std_logic;
  signal enableTens: std_logic;
  signal tempOutOnes: unsigned(3 downto 0);
  signal tempOutTens: unsigned(3 downto 0);
  signal tempOutMins: unsigned(3 downto 0);
  signal resetOnes: std_logic;
  signal resetTens: std_logic;
  signal resetMin: std_logic;
  
  signal inputOnes: unsigned(3 downto 0);
  signal inputTens: unsigned(3 downto 0);
  signal inputMins: unsigned(1 downto 0);
  signal TempTimeOut: std_logic := '0';
  signal turnOffLED: std_logic;
  signal count: integer:=1;
  signal tmp : std_logic := '0';
  
  begin 
	process(clock, Start)
	begin
	if(Start = '0') then
		count<=1;
		tmp<='0';
	elsif(clock'event and clock='1') then
		count <=count+1;
		if (count = 5000000) then
			tmp <= NOT tmp;
			count <= 1;
		end if;
	 end if;
	 end process;
	  --- Assigning DataIn input to signals for comparision
    inputMins <= DataIn(9 downto 8);
    inputTens <= DataIn(7 downto 4);
    inputOnes <= DataIn(3 downto 0);
    
    
    --- Create Portmap of BCD counter
    secOnes: BCD_counter port map(Clk => tmp, Init => resetOnes, Enable => enableOnes, Direction => '0', Q_out => tempOutOnes);     
    secTens: BCD_counter port map(Clk => tmp, Init => ResetTens, Enable => enableTens, Direction => '0', Q_out => tempOutTens);
    mins: BCD_counter  port map(Clk => tmp, Init => resetMin, Enable => enableMins, Direction => '0', Q_out => tempOutMins);
    
    enableOnes <= '0' when TempTimeOut = '1' else '1';    
    enableTens <= '1' when tempOutOnes = "1001" else '0' when TempTimeOut = '1' else '0'; --- Allows Tens to increment once ones reach "1001" (9) 
    resetOnes <= '1' when tempOutOnes = "1001" or Start = '0' else '0'; --- Resets ones when it reaches "1001" (9) or when the test first starts
    resetTens <= '1' when tempOutTens = "0110" or Start = '0' else '0'; --- Resets Tens when it reaches "0110" (6) or when test first starts
	 resetMin <= '1' when Start = '0' else '0' ;
    enableMins <= '1' when (tempOutTens = "0101" and tempOutOnes = "1001") else '0' when TempTimeOut = '1' else '0'; -- Allows Mins to increment once Tens is "0110" and Ones is "0000" ie: 60 seconds
   
    
    -- Output signal Time_Out will change from '0' to '1' when the specified time elapsed (or in other words when the timer times out)
    TempTimeOut <= '1' when tempOutMins = inputMins and tempOutTens = inputTens and tempOutOnes = inputOnes else '0';
    
    TimeOut <= TempTimeOut;
    
    --- Add to BCD2Seven seg
    LEDOnes: BCD2SevenSeg port map(digit => tempOutOnes, all_off => turnOffLED,LED_out =>QOnes);
    LEDTens: BCD2SevenSeg port map(digit => tempOutTens, all_off => turnOffLED, LED_out =>QTens);
    LEDMins: BCD2SevenSeg port map(digit => tempOutMins, all_off=> turnOffLED, LED_out=>QMins);
    
    turnoffLED <= '0';
end architecture behaviour;