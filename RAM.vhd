library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RAM is  
generic (
	ADRESS_SIZE : integer := 4;
	DATA_SIZE : integer := 8;
	n : integer := 2 -- n should be smaller than ADRESS_SIZE
);
port (
	address : 			 in std_logic_vector  (ADRESS_SIZE - 1 downto 0);  
	datain  : 			 in std_logic_vector  (DATA_SIZE - 1 downto 0);	
	dataout : 			 out std_logic_vector (DATA_SIZE - 1 downto 0); 
	we , clock  : 		 in std_logic
	);
end entity RAM;

architecture arch_ram of RAM is

signal cs : std_logic_vector ((2**n) -1 downto 0); 		          

begin 

	Decoder : entity work.Decoder
		generic map (n => n)
		port map (
			in_dec => address (ADRESS_SIZE - 1 downto (ADRESS_SIZE - n)),           
			out_dec => cs	
		);

	ram_block_generation :
		for i in 0 to (2**n -1) generate

		block_ram : entity work.Quadram
		generic map (Adress_size => ADRESS_SIZE - n,
						 Data_size => DATA_SIZE
		)
		port map (
			clock   => clock,
			we      => we,
			cs      => cs (i),
			address => address (ADRESS_SIZE - n - 1 downto 0),
			datain  => datain,
			dataout => dataout
		);
	
	end generate ram_block_generation;
end architecture arch_ram;
