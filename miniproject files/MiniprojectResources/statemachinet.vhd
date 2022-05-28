library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fsm is
    Port (reset : in  STD_LOGIC; -- connected to pb2
			 pb0_in: in STD_LOGIC;
			 pb1_in: in STD_LOGIC;
			 lives: 	in integer;
			 mode_out : out  STD_LOGIC_VECTOR (2 downto 0);
			 clk : in  STD_LOGIC);
end fsm;


architecture Mealy of fsm is 
type state_type is (S0,S1,S2,S3,S4,S5);


-- S0 mainmenu
--	S1 trainingmode
--	S2 actualmode
-- S3 gameover (u died screen)
-- S4 (maybe different background harder difficulyt
signal state,next_state: state_type;
signal pb1,pb2: std_logic;

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

OUTPUT_DECODE : process(state,pb0_in,pb1_in,lives)
begin
		case(state) is
			--Mainmenu
			when S0 =>
				mode_out<="000";
				
			--S1 in training mode
			when S1 =>
				mode_out<="001";
			when S2 => -- S2 in actual game mode
				mode_out <="010";
			when S3 => -- Game over screen
				mode_out <= "011";
			when others =>
				mode_out <= "000";
		end case;
end process OUTPUT_DECODE;		
NEXT_STATE_DECODE: process(state,pb0_in,pb1_in,lives)
begin

	case (state) is
		when S0 => -- MAIN MENU ---
			if(pb0_in='0') then
				next_state<=S1;	--trainingmode
			elsif(pb1_in='0') then
				next_state<=S2;	--actualmode
			else -- Stay on main menu if nothing happens
				next_state<=S0;
			end if;	
			
		when S1 =>	--- TRAIN MODE ---
			if(lives = 0) then
				next_state<=S3; -- Go to game over screen
			elsif(reset='0') then
				next_state<=S0;
			else	-- Stay on training mode if no inputs
				next_state<=S1;
			end if; 
			
		when S2 =>	--- GAME MODE ---
			if(lives= 0) then
				next_state<=S3; -- go to game over screen
			elsif(reset='0') then
				next_state<=S0;
			else -- stay on game mode if no inputs
				next_state<=S2;
			end if;
			
		when S3 => 	--- GAME OVER ---
			if (reset = '0') then
				next_state <= S0; -- go back to main menu
			else
				next_state <= S3; -- stay on game over screen if no inputs
			end if;
			
		when others =>
			next_state <= S0;
	end case;
end process NEXT_STATE_DECODE;
end Mealy;		
		
	