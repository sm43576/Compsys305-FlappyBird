-- Testbench.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- Testbench for the counter.
entity test_bench_rng is
end entity test_bench_rng;

architecture my_test of test_bench_rng is
  signal t_clk, t_reset: std_logic;
  signal t_output: integer;
  
  component randomNums is
    PORT (Clk, Rst: IN std_logic;
        output: OUT integer);
  end component;
  
begin
 DUT: randomNums port map (t_clk,t_reset,t_output);

 -- Initialization process (code that executes only once). 
 init: process
  begin
	t_reset <= '1', '0' after 20 ns, '1' after 30 ns, '0' after 50 ns, '1' after 70 ns, '0' after 100 ns;
    wait;
  end process init;
 -- clock generation
  clk_gen: process
  begin
    t_clk <= '1'; 
    wait for 10 ns; -- should be 500 ms but it'll take too long
    t_clk <= '0';
    wait for 10 ns;
  end process clk_gen;
  
end architecture my_test; 