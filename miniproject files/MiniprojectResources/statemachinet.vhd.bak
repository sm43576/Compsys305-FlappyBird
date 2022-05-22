architecture Mealy of Parity is 
type state_type is (S0,S1,S2,S3,S4,S5)


-- S0 mainmenu
--	S1 trainingmode
--	S2 actualmode
-- S3 gameover
-- S4 (maybe different background harder difficulyt
--
signal state,next_state: state_type;

being
SYNC_PROC: process(clk)
being
	if rising_edge(clk) then
		if (reset='1') then
			state <=S0;
		else
			state<= next_state;
		end if;
		
	end if;

end process

OUTPUT_DECODE : process(state,x)
being
parity<='0'
		case(state) is
			--Mainmenu
			when S0 =>
				if(x='0') then
					parity <='0';	--trainingmode
				end if;
			when S0 =>
				if(x='1') then
					parity <='1';	--actualmode
				end if;
				
			--game over section
			when S1 =>
				if(x='0') then
					parity <='0';
				end if;
			when S2 =>
				if(x='0') then
					parity <='0';
				end if;
				
			--pass
			when S1 =>
				if(x='1')
					parity <= '1'
				end if;
			--S2 does not have a finish, endless
				
		end case
		
NEXT_STATE_DECODE: process(state,x)
begin
	next_state<=s0;
	case (state) is
		when S0 =>
			if(x='0') then
				next_state<=S1	--trainingmode
			end if;
		when S0 =>
			if(x='1') then
				next_state<=S2	--actualmode
			end if;
		when S1 =>
			if(x='0') then
				next_state<=S3
			end if;
		when S1 =>
			if(x='1') then
				next_state<=S0
			end if;
		when S2 =>
			if(x='0') then
				next_state<=S3
			end if;
		
end case;
end process;
end Mealy;		
		
	