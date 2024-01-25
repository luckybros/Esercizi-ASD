library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity demux_1_4 is 
	port(	b, s0, s1 : in STD_LOGIC;
			y0, y1, y2, y3 : out STD_LOGIC;
	);		
end demux_1_4;

architecture structural of demux_1_4 is 
	signal u0, u1 : STD_LOGIC;
	
	component demux_1_2 is 
		port(   a, s : in STD_LOGIC;
				w0, w1 : out STD_LOGIC;
		);
	end component;

	begin
		demux0: demux_1_2
			port map(	a => b,
						s => s0,
						w0 => u0,
						w1 => u1
			);
		demux1: demux_1_2
			port map(	a => u0,
						s => s1,
						w0 => y0,
						w1 => y1
			);
		demux2: demux_1_2
			port map(	a => u1,
						s => s1,
						w0 => y2,
						w1 => y3
			);
end structural;