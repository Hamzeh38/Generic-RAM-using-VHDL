library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_1 is
end entity TB_1;

architecture TB of TB_1 is
	
	constant ADRESS_SIZE : integer := 8;
	constant DATA_SIZE : integer := 8;
	constant n : integer := 2;
	
	signal Address :std_logic_vector(ADRESS_SIZE - 1 downto 0);
	signal DataIn, DataOut :std_logic_vector(DATA_SIZE - 1 downto 0);
	signal WE, clock : std_logic := '0';

begin

	UUT10: entity work.RAM
	generic map (
		ADRESS_SIZE => ADRESS_SIZE,
		DATA_SIZE   => DATA_SIZE,
		n   => n 
	)
	port map (
		clock   => clock,
		we      => WE,
		address => Address,
		datain  => DataIn,
		dataout => DataOut
	);

	ClockGen: process is
		begin
				for i in 1 to 10 loop
				    clock <= '0';
				    wait for 5 ns;
				    clock <= '1';
				    wait for 5 ns;
			     end loop;
		end process ClockGen;
	
	Stim: process is
		begin
						
			wait for 10 ns; -- cycle 1
			-- Initialising the inputs
			datain <= X"00";
			address <= X"01"; 
			we <= '0';

			wait for 20 ns; -- cycle 2
			-- test for we
			we <= '1';

			wait for 20 ns; -- cycle 3
			-- Test for cs
			datain <= X"07";
			address <= X"21"; 

			wait for 20 ns; -- cycle 4
			-- test another adress in the same sync_block
			datain <= X"30";
			address <= X"27";
			
			wait for 20 ns; -- cycle 4
			-- test third value for cs
			datain <= X"30";
			address <= X"47";
			
			wait for 20 ns; -- cycle 4
			-- test fouth value for cs
			datain <= X"30";
			address <= X"67";
			
			wait for 20 ns;
			-- test if the case remain his value
			we <= '0';
			address <= X"21";
			
			wait for 30 ns;

	end process;

end architecture TB;
