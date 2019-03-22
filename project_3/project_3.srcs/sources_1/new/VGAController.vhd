library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGAController is
  Port (clock, centerButton, upButton, leftButton, rightButton, downButton: in std_logic;
        difficultyControl: in std_logic_vector(1 downto 0);
        a_to_g :  out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0);
        hSync, vSync: out std_logic;
        VGARed, VGAGreen, VGABlue: out std_logic_vector(3 downto 0));
end VGAController;

architecture Behavioral of VGAController is


component ClockDivider is
    Port (
           InClk: in std_logic;
           OutClk: out std_logic);
end component;  
component Sync is
    Port (
            clock, left, right, start: in std_logic;     
            ControlDifficulty: in std_logic_vector(1 downto 0);
            points: out std_logic_vector(6 downto 0);  
            hSync, vSync: out std_logic;
            r, g, b: out std_logic_vector(3 downto 0));
end component;


component seven_seg is 
    Port (Myclock : in STD_LOGIC;   
          sw : in STD_LOGIC_VECTOR (6 downto 0);
          a_to_g :  out STD_LOGIC_VECTOR (6 downto 0);
          an : out STD_LOGIC_VECTOR (3 downto 0));
end component;



signal VGAClock: std_logic;
signal score: std_logic_vector(6 downto 0);   

begin
    Component1: ClockDivider 
                    port map(Inclk => clock,
                             Outclk => VGAClock);
    Component2: Sync
                    port map(clock => VGAClock,
                             left => leftButton,
                             right => rightButton,
                             start => centerButton,
                             ControlDifficulty => difficultyControl,
                             points => score,
                             hSync => hSync,
                             vSync => vSync,
                             r => VGARed,
                             g => VGAGreen,
                             b => VGABlue);
    Component3: seven_seg 
                    port map(Myclock => clock,
                    sw => score,
                    a_to_g => a_to_g,
                    an => an);
end Behavioral;