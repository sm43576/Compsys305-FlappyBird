library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD_counter is
  port(Clk,Init,Enable,Direction: in std_logic;
        Q_out: out unsigned(3 downto 0));
end entity BCD_counter;

architecture behaviour of BCD_counter is
  begin 
      process(Clk,Init,Enable, Direction)
        variable counter: unsigned(3 downto 0);
      begin
        if (rising_edge(Clk)) then
          
          if (Init = '1') then
            if(Direction = '0')then --- initialises for counting up
              counter := "0000";
            
            elsif(Direction = '1') then -- initialises for counting down
              counter := "1001";
            end if;
             Q_out <= counter;
          
          else
              
            if (Enable = '1') then
          
              if (Direction = '0') then --- Incrementing
                counter := counter + "0001";
              elsif(Direction = '1') then --- Decrementing
                counter := counter - "0001";
              end if;
            end if;
          end if;
           Q_out <= counter;
        end if;
      end process;
      
end architecture behaviour;