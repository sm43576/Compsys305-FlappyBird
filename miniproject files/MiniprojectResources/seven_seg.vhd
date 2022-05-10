library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity seven_seg is
  port (Din : in unsigned(3 downto 0);
        Dout : out unsigned(6 downto 0));
end entity;

architecture arc2 of seven_seg is
begin
  process (Din)
  begin
    case Din is 
      when "0000" => Dout <= "1000000"; -- 0
      when "0001" => Dout <= "1111001"; -- 1 11111001
		  when "0010" => Dout <= "0100100"; -- 2 10100100
      when "0011" => Dout <= "0110000"; -- 3 10110000
      when "0100" => Dout <= "0011001"; -- 4 10011001
      when "0101" => Dout <= "0010010"; -- 510010010
      when "0110" => Dout <= "0000010"; -- 6 10000010
      when "0111" => Dout <= "1111000"; -- 7 11111000
      when "1000" => Dout <= "0000000"; -- 8 10000000
      when "1001" => Dout <= "0010000"; -- 9 10010000
      when others => Dout <= "1111111"; 
    end case;

  end process; 
end architecture arc2;