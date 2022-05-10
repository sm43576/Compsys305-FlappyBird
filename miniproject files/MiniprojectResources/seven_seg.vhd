library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity BCD2SevenSeg is
  port (digit : in unsigned(3 downto 0);
        LED_out : out unsigned(7 downto 0));
end entity;

architecture arc2 of BCD2SevenSeg is
begin
  process (digit)
  begin
    case digit is 
      when "0000" => LED_out <= "11000000"; -- 0
      when "0001" => LED_out <= "11111001"; -- 1 11111001
		  when "0010" => LED_out <= "10100100"; -- 2 10100100
      when "0011" => LED_out <= "10110000"; -- 3 10110000
      when "0100" => LED_out <= "10011001"; -- 4 10011001
      when "0101" => LED_out <= "10010010"; -- 510010010
      when "0110" => LED_out <= "10000010"; -- 6 10000010
      when "0111" => LED_out <= "11111000"; -- 7 11111000
      when "1000" => LED_out <= "10000000"; -- 8 10000000
      when "1001" => LED_out <= "10010000"; -- 9 10010000
      when others => LED_out <= "11111111"; 
    end case;

  end process; 
end architecture arc2;