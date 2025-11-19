library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is
	generic 
	(n : integer := 2
	);
	port 
	(in_dec : in std_logic_vector (n-1 downto 0);
    out_dec : out std_logic_vector ((2**n) - 1 downto 0)
	);
end entity Decoder;

architecture gen_decoder_func of Decoder is 

begin 

	Out_dec <= std_logic_vector(shift_left(to_unsigned(1, Out_dec'length),  to_integer(unsigned(in_dec))));

end architecture gen_decoder_func;