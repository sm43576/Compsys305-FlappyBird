-- Testbench.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- Testbench for the counter.
entity test_bench_programmableTimer is
end entity test_bench_programmableTimer;

architecture my_test of test_bench_programmableTimer is
  signal t_clk, t_start,t_timeout: std_logic;
  signal t_datain: unsigned(9 downto 0);
  signal t_Qmins, t_Qtens, t_Qones: unsigned(7 downto 0);
  
  component programableTimer is
    port(clock, Start: in std_logic;
        DataIn: in unsigned(9 downto 0);
        TimeOut: out std_logic;
        Qmins,QTens,Qones: out unsigned(7 downto 0));
  end component;
begin
 DUT: programableTimer port map (clock => t_clk, Start => t_start,DataIn => t_datain, TimeOut => t_timeout,
                                 Qmins => t_Qmins, QTens => t_Qtens,QOnes => t_Qones);

 -- Initialization process (code that executes only once). 
 init: process
  begin
    t_datain <= "0100110101"; --- 1 min and 35 seconds
    t_start <= '1', '0' after 2 ns, '1' after 10 ns, '0' after 15 ns, '1' after 1100 ns, '0' after 1110 ns;
    
    wait;
  end process init;
 -- clock generation
  clk_gen: process
  begin
    t_clk <= '1'; 
    wait for 5 ns; -- should be 500 ms but it'll take too long
    t_clk <= '0';
    wait for 5 ns;
  end process clk_gen;
  
end architecture my_test; 
