library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Quadram is 
	generic (Adress_size : integer := 1;
				Data_size	: integer := 8
				); 	
	port (
    clock   : in  std_logic;
    we      : in  std_logic;
	 cs      : in  std_logic;
    address : in  std_logic_vector (Adress_size - 1 downto 0);
    datain  : in  std_logic_vector (Data_size - 1 downto 0);
    dataout : out std_logic_vector(Data_size - 1  downto 0)
  );

end entity Quadram;

architecture arch_Quadram of Quadram is

	type ram_type is array (0 to (2**Adress_size) -1 ) of std_logic_vector(Data_size - 1 downto 0);
	signal ram : ram_type;
	signal dataout_reg : std_logic_vector(Data_size - 1 downto 0);

Begin

	RamProc: process(clock) is

	begin
	
	if rising_edge(clock) then
		if cs = '1' then
			dataout_reg <= ram(to_integer(unsigned(address)));
			if we = '1'  then
				ram(to_integer(unsigned(address))) <= datain;
			end if;
		else 
			dataout_reg <=(others => 'Z');
		end if;
	end if;
	end process RamProc;
	
	dataout <= dataout_reg;

end architecture arch_Quadram;

