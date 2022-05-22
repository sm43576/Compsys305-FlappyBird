library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fsm is
    Port (reset : in  STD_LOGIC;
			 pb1_in: in STD_LOGIC;
			 pb2_in: in STD_LOGIC;
			 input : in  STD_LOGIC;
			 x		 : in STD_LOGIC;
			 parity: out STD_LOGIC;
			 mode_out : out  STD_LOGIC_VECTOR (2 downto 0);
			 clk : in  STD_LOGIC);
end fsm;


architecture Mealy of fsm is 
type state_type is (S0,S1,S2,S3,S4,S5);


-- S0 mainmenu
--	S1 trainingmode
--	S2 actualmode
-- S3 gameover
-- S4 (maybe different background harder difficulyt
--
signal state,next_state: state_type;

begin
SYNC_PROC: process(clk)
begin
	if rising_edge(clk) then
		if (reset='0') then
			state <=S0;
		else
			state<= next_state;
		end if;
		
	end if;

end process;

OUTPUT_DECODE : process(state,pb1_in,pb2_in,x)
begin
	mode_out<="000";
		case(state) is
			--Mainmenu
			when S0 =>
				if(pb1_in='0') then
					mode_out <="001";	--trainingmode
				
				elsif(pb2_in='0') then
					mode_out <="010";	--actualmode
				end if;
				
			--S1 in training mode
			when S1 =>
				if(x='0') then
					mode_out <="011"; -- game over screen
				end if;
			when S2 => -- S2 in actual game mode
				if(x='0') then
					mode_out <="011";
				end if;
			when others =>
				mode_out <= "000";
			--pass
			--when S1 =>
			--	if(x='1') then
			--		parity <= '1';
			--	end if;
			--S2 does not have a finish, endless
		end case;
end process OUTPUT_DECODE;		
NEXT_STATE_DECODE: process(state,pb1_in,pb2_in,x)
begin
	next_state<=s0;
	case (state) is
		when S0 =>
			if(pb1_in='0') then
				next_state<=S1;	--trainingmode
			elsif(pb2_in='0') then
				next_state<=S2;	--actualmode
			end if;	
		when S1 =>
			if(x='0') then
				next_state<=S3;
				
			elsif(x='1') then
				next_state<=S0;
			end if;
		when S2 =>
			if(x='0') then
				next_state<=S3;
			end if;
		when others =>
			next_state <= S0;
	end case;
end process NEXT_STATE_DECODE;
end Mealy;		
		
	