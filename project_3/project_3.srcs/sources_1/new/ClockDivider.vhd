library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDivider is
    Port (
          InClk: in std_logic;
          OutClk: out std_logic);
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal Divider1, Divider2: std_logic:= '0';
    begin


        process(InClk, Divider1) 
        begin
            if InClk'event and InClk = '1' then 
                Divider1 <= not Divider1;
            end if;
            if Divider1'event and Divider1 = '1' then 
                Divider2 <= not Divider2;
            end if;
        end process;
        OutClk <= Divider2;
end Behavioral;
