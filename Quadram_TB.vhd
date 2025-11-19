library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Quadram_TB is
end entity Quadram_TB;

architecture TBQ of Quadram_TB is

	constant ADRESS_SIZE : integer := 3;
	constant DATA_SIZE : integer := 8;
	
	signal Address :std_logic_vector(ADRESS_SIZE-1 downto 0);
	signal DataIn, DataOut :std_logic_vector(DATA_SIZE-1 downto 0);
	signal WE : std_logic := '0';
	signal CS : std_logic := '0';
	signal clock : std_logic := '0';

begin

	UUT: entity work.Quadram
	generic map (Adress_size => ADRESS_SIZE,
					 Data_size => DATA_SIZE
					)
	port map (
		clock   => clock,
		we      => WE,
		cs      => CS,
		address => Address,
		datain  => DataIn,
		dataout => DataOut
	);

	ClockGen: process is
		begin
				for i in 1 to 30 loop
				    clock <= '0';
				    wait for 5 ns;
				    clock <= '1';
				    wait for 5 ns;
				end loop;
		end process ClockGen;
	
	Stim: process is
		begin
			
			
			wait for 20 ns; -- cycle 2
			-- Initialising the inputs
			CS  <= '1';
			datain <= "00000000";
			address <= "001";
			we <= '0';

			wait for 20 ns; -- cycle 4
			-- test when writing enable is active
			we <= '1';
			datain <= "00000100";

			wait for 20 ns; -- cycle 6
			-- test for another adress
			datain <=    "00000111";
			address <= "010";

			wait for 20 ns; -- cycle 8
			-- test when writing enable isn't active
			we <= '0';
			datain <=    "00110000";
			address <= "100";
			
			wait for 20 ns; -- cycle 10
			cs <= '0';
			we <= '1';
			
			
			wait for 20 ns; -- cycle 12
			cs <= '1';
			
			wait for 40 ns; -- cycle 12

	end process;

end architecture TBQ;
