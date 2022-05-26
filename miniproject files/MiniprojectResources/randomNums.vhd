
-- Modified from http://www.asic-world.com/examples/vhdl/lfsr.html
 library ieee;
  9     use ieee.std_logic_1164.all;
 10 
 11 entity randomNum is
 12   port (
 13     cout   :out std_logic_vector (7 downto 0);     enable :in  std_logic;                   -- Enable counting
 15     clk    :in  std_logic;                   -- Input rlock
 16     reset  :in  std_logic                    -- Input reset
 17   );
 18 end entity;
 19 
 20 architecture rtl of randomNum is
 21     signal count           :std_logic_vector (7 downto 0);
 22     signal linear_feedback :std_logic;
 23 
 24 begin
 25     linear_feedback <= not(count(7) xor count(3));
 26 
 27 
 28     process (clk, reset) begin
 29         if (reset = '1') then
 30             count <= (others=>'0');
 31         elsif (rising_edge(clk)) then
 32             if (enable = '1') then
 33                 count <= (count(6) & count(5) & count(4) & count(3) 
 34                           & count(2) & count(1) & count(0) & 
 35                           linear_feedback);
 36             end if;
 37         end if;
 38     end process;
 39     cout <= count;
 40 end architecture rtl;