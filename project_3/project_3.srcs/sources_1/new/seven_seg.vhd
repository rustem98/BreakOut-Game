library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity seven_seg is
Port ( 
           Myclock : in STD_LOGIC;   
           sw : in STD_LOGIC_VECTOR (6 downto 0);
           a_to_g :  out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end seven_seg;

architecture Behavioral of seven_seg is
signal r_counter:  STD_LOGIC_VECTOR (19 downto 0);
signal x:  STD_LOGIC_VECTOR (3 downto 0);
signal a:  STD_LOGIC_VECTOR (3 downto 0);
signal b:  STD_LOGIC_VECTOR (3 downto 0);
signal LED_activating_counter: std_logic_vector(1 downto 0);
begin

process(Myclock) 
begin 
    if(rising_edge(Myclock)) then
        r_counter <= r_counter + 1;
    end if;
end process;


process(x)
    begin
        case x is
        when "0000" => a_to_g <="1000000";--0
        when "0001" => a_to_g <="1111001";--1
        when "0010" => a_to_g <="0100100";--2
        when "0011" => a_to_g <="0110000";--3
        when "0100" => a_to_g <="0011001";--4
        when "0101" => a_to_g <="0010010";--5
        when "0110" => a_to_g <="0000010";--6
        when "0111" => a_to_g <="1111000";--7
        when "1000" => a_to_g <="0000000";--8
        when "1001" => a_to_g <="0010000";--9
        when others => a_to_g <="1000000";--0
        
        
        end case;
    end process;

LED_activating_counter <= r_counter(19 downto 18);



process(sw)
begin
    case sw is 
when "0000000" =>
    a <= "0000";
    b <= "0000";
        
when "0000001" =>
    a <= "0000";
    b <= "0001";

when "0000010" =>
    a <= "0000";
    b <= "0010";
            
when "0000011" =>
    a <= "0000";
    b <= "0011";

when "0000100" =>
    a <= "0000";
    b <= "0100";
        
when "0000101" =>
    a <= "0000";
    b <= "0101";

when "0000110" =>
    a <= "0000";
    b <= "0110";
            
when "0000111" =>
    a <= "0000";
    b <= "0111";


when "0001000" =>
    a <= "0000";
    b <= "1000";
        
when "0001001" =>
    a <= "0000";
    b <= "1001";

when "0001010" =>
    a <= "0001";
    b <= "0000";
            
when "0001011" =>
    a <= "0001";
    b <= "0001";

when "0001100" =>
    a <= "0001";
    b <= "0010";
        
when "0001101" =>
    a <= "0001";
    b <= "0011";

when "0001110" =>
    a <= "0001";
    b <= "0100";
            
when "0001111" =>
    a <= "0001";
    b <= "0101";

when "0010000" =>
    a <= "0001";
    b <= "0110";
        
when "0010001" =>
    a <= "0001";
    b <= "0111";

when "0010010" =>
    a <= "0001";
    b <= "1000";
            
when "0010011" =>
    a <= "0001";
    b <= "1001";

when "0010100" =>
    a <= "0010";
    b <= "0000";
        
when "0010101" =>
    a <= "0010";
    b <= "0001";

when "0010110" =>
    a <= "0010";
    b <= "0010";
            
when "0010111" =>
    a <= "0010";
    b <= "0011";


when "0011000" =>
    a <= "0010";
    b <= "0100";
        
when "0011001" =>
    a <= "0010";
    b <= "0101";

when "0011010" =>
    a <= "0010";
    b <= "0110";
            
when "0011011" =>
    a <= "0010";
    b <= "0111";

when "0011100" =>
    a <= "0010";
    b <= "1000";
        
when "0011101" =>
    a <= "0010";
    b <= "1001";

when "0011110" =>
    a <= "0011";
    b <= "0000";
            
when "0011111" =>
    a <= "0011";
    b <= "0001";

when "0100000" =>
    a <= "0011";
    b <= "0010";
        
when "0100001" =>
    a <= "0011";
    b <= "0011";

when "0100010" =>
    a <= "0011";
    b <= "0100";
            
when "0100011" =>
    a <= "0011";
    b <= "0101";

when "0100100" =>
    a <= "0011";
    b <= "0110";
        
when "0100101" =>
    a <= "0011";
    b <= "0111";

when "0100110" =>
    a <= "0011";
    b <= "1000";
            
when "0100111" =>
    a <= "0011";
    b <= "1001";


when "0101000" =>
    a <= "0100";
    b <= "0000";
        
when "0101001" =>
    a <= "0100";
    b <= "0001";

when "0101010" =>
    a <= "0100";
    b <= "0010";
            
when "0101011" =>
    a <= "0100";
    b <= "0011";

when "0101100" =>
    a <= "0100";
    b <= "0100";
        
when "0101101" =>
    a <= "0100";
    b <= "0101";

when "0101110" =>
    a <= "0100";
    b <= "0110";
            
when "0101111" =>
    a <= "0100";
    b <= "0111";

when "0110000" =>
    a <= "0100";
    b <= "1000";
        
when "0110001" =>
    a <= "0100";
    b <= "1001";

when "0110010" =>
    a <= "0101";
    b <= "0000";
            
when "0110011" =>
    a <= "0101";
    b <= "0001";

when "0110100" =>
    a <= "0101";
    b <= "0010";
        
when "0110101" =>
    a <= "0101";
    b <= "0011";

when "0110110" =>
    a <= "0101";
    b <= "0100";
            
when "0110111" =>
    a <= "0101";
    b <= "0101";


when "0111000" =>
    a <= "0101";
    b <= "0110";
        
when "0111001" =>
    a <= "0101";
    b <= "0111";

when "0111010" =>
    a <= "0101";
    b <= "1000";
            
when "0111011" =>
    a <= "0101";
    b <= "1001";

when "0111100" =>
    a <= "0110";
    b <= "0000";
        
when "0111101" =>
    a <= "0110";
    b <= "0001";

when "0111110" =>
    a <= "0110";
    b <= "0010";
            
when "0111111" =>
    a <= "0110";
    b <= "0011";

when "1000000" =>
    a <= "0110";
    b <= "0100";
        
when "1000001" =>
    a <= "0110";
    b <= "0101";

when "1000010" =>
    a <= "0110";
    b <= "0110";
            
when "1000011" =>
    a <= "0110";
    b <= "0111";

when "1000100" =>
    a <= "0110";
    b <= "1000";
        
when "1000101" =>
    a <= "0110";
    b <= "1001";

when "1000110" =>
    a <= "0111";
    b <= "0000";
            
when "1000111" =>
    a <= "0111";
    b <= "0001";


when "1001000" =>
    a <= "0111";
    b <= "0010";
        
when "1001001" =>
    a <= "0111";
    b <= "0011";

when "1001010" =>
    a <= "0111";
    b <= "0100";
            
when "1001011" =>
    a <= "0111";
    b <= "0101";

    
when others => 
    a <= "0000";
    b <= "0000";            
end case;
end process;

process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        an <= "0111"; 
        x <= "0000";
    when "01" =>
        an<= "1011"; 
        x <= a;
    when "10" =>
        an <= "1101"; 
        x <= b;    
        when "11" =>
        an <= "1110";         
        x <= "0000";
    when others => 
    
    end case;
end process;
    

end Behavioral;
