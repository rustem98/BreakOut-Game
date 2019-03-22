library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.Constants.all;

entity Sync is
  Port (
        clock, left, right, start: in std_logic;     
        ControlDifficulty: in std_logic_vector(1 downto 0);
        points: out std_logic_vector(6 downto 0);  
        hSync, vSync: out std_logic;
        r, g, b: out std_logic_vector(3 downto 0));        
end Sync;

architecture Behavioral of Sync is


signal CurrentPositionHorizontal, NextPositionHorizontal: integer range 1 to TOT_H;
signal CurrentPositionVertical, NextPositionVertical: integer range 1 to TOT_V;



signal CurrentRGB, NextRGB: std_logic_vector(11 downto 0);

signal VisibPad, VisibBall: boolean;
signal brick0Visible, brick1Visible, brick2Visible, brick3Visible, brick4Visible: boolean;
signal brick5Visible, brick6Visible, brick7Visible, brick8Visible, brick9Visible: boolean;
signal brick10Visible, brick11Visible, brick12Visible, brick13Visible, brick14Visible: boolean;
signal brick15Visible, brick16Visible, brick17Visible, brick18Visible, brick19Visible: boolean;
signal brick20Visible, brick21Visible, brick22Visible, brick23Visible, brick24Visible: boolean;
signal CursorPad: integer range (FP_H + SP_H + BP_H + 1) to (TOT_H - PADDLE_WIDTH):= FP_H + SP_H + BP_H + VIS_H / 2 - (PADDLE_WIDTH + 1) / 2;
signal LeftPad, RightPad: integer range 0 to PRESCALER_PADDLE:= 0;
signal CursorBallHorizontal: integer range (FP_H + SP_H + BP_H + 1) to (TOT_H - BALL_SIDE);
signal CursorBallVertical: integer range (FP_V + SP_V + BP_V + 1) to (TOT_V - BALL_SIDE);
signal CounterBall: integer:= 0;
signal moveBall: std_logic:= '0';
signal Currentplay: std_logic;
signal PlayerLoses: std_logic;
signal brickVI: std_logic_vector(24 downto 0);

signal WidthPad: integer:= PADDLE_WIDTH;
signal brickLength: integer:= (TOT_H - FP_H - SP_H - BP_H - 4)/5;
signal score: std_logic_vector(6 downto 0);


--Component that provides information about the balls position and game logic
component BallController is
    Port (
            PosPaddle: in integer range TOT_H - VIS_H + 1 to TOT_H - PADDLE_WIDTH;
            brickVis: out std_logic_vector(24 downto 0);
            points: out std_logic_vector(6 downto 0);
            start, move: in std_logic;
            PositionX: out integer range TOT_H - VIS_H + 1 to TOT_H - BALL_SIDE;
            PositionY: out integer range TOT_V - VIS_V + 1 to TOT_V;
            play, LostGame: out std_logic;
            WidthPad: in integer);
end component;
begin
 
    ballControl: BallController 
        port map (start => start,
                  move => moveBall, 
                  WidthPad => WidthPad,
                  PosPaddle => CursorPad,
                  PositionX => CursorBallHorizontal,
                  PositionY => CursorBallVertical,
                  play =>  Currentplay,
                  brickVis => brickVI,
                  points => score,
                  LostGame => PlayerLoses);
 



    process(clock)
    begin 
        if clock'event and clock = '1' then
 
            if CounterBall = PRESCALER_BALL then
                moveBall <= not moveBall;
                CounterBall <= 0;
            else 
                CounterBall <= CounterBall + 1;
            end if;
  
  
            if Currentplay = '1' then
                if right = '1' and left = '0' then
                    RightPad <= RightPad + 1;
                    LeftPad <= 0;
                elsif left = '1' and right = '0' then
                    LeftPad <= LeftPad + 1;
                    RightPad <= 0;
                else 
                    RightPad <= 0;
                    LeftPad <= 0;
                end if;
  
  
                if RightPad = (PRESCALER_PADDLE - 5000) and CursorPad < TOT_H - WidthPad then
                    CursorPad <= CursorPad + 1;
                elsif LeftPad = (PRESCALER_PADDLE - 5000) and CursorPad > FP_H + SP_H + BP_H + 1 then
                    CursorPad <= CursorPad - 1;
                end if;  
  
  
  
  
  
  
  
            else 
                CursorPad <= FP_H + SP_H + BP_H + VIS_H / 2 - (PADDLE_WIDTH + 1) / 2;
            end if;
  
  
            CurrentPositionHorizontal <= NextPositionHorizontal;
            CurrentPositionVertical <= NextPositionVertical;
            CurrentRGB <= NextRGB;
        end if;
    end process;
  
  
  
    with ControlDifficulty select WidthPad <= 
        PADDLE_WIDTH when "00",
        PADDLE_WIDTH_EASY when "01",
        PADDLE_WIDTH_HARD when "10",
        PADDLE_WIDTH when others;  
  
  
  

 
 
 
 
    VisibPad <= ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 1) and (CurrentPositionHorizontal > CursorPad + 8) and (CurrentPositionHorizontal < CursorPad + WidthPad - 8)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 1) and (CurrentPositionHorizontal > CursorPad + 7) and (CurrentPositionHorizontal < CursorPad + WidthPad - 7)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 2) and (CurrentPositionHorizontal > CursorPad + 6) and (CurrentPositionHorizontal < CursorPad + WidthPad - 6)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 3) and (CurrentPositionHorizontal > CursorPad + 5) and (CurrentPositionHorizontal < CursorPad + WidthPad - 5)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 4) and (CurrentPositionHorizontal > CursorPad + 4) and (CurrentPositionHorizontal < CursorPad + WidthPad - 4)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 5) and (CurrentPositionHorizontal > CursorPad + 3) and (CurrentPositionHorizontal < CursorPad + WidthPad - 3)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 6) and (CurrentPositionHorizontal > CursorPad + 2) and (CurrentPositionHorizontal < CursorPad + WidthPad - 2)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 7) and (CurrentPositionHorizontal > CursorPad + 1) and (CurrentPositionHorizontal < CursorPad + WidthPad - 1)) or
                     (((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 8) or (CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 9) or (CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 10)) 
                     and (CurrentPositionHorizontal > CursorPad) and (CurrentPositionHorizontal < CursorPad + WidthPad)) or
                     ((CurrentPositionVertical = TOT_V - PADDLE_HEIGHT + 11) and (CurrentPositionHorizontal > CursorPad + 1) and (CurrentPositionHorizontal < CursorPad + WidthPad - 1));



    VisibBall <= (((CurrentPositionVertical = CursorBallVertical) or (CurrentPositionVertical = CursorBallVertical + BALL_SIDE)) and (CurrentPositionHorizontal > CursorBallHorizontal + 3) and (CurrentPositionHorizontal <= CursorBallHorizontal + 7)) or
                   (((CurrentPositionVertical = CursorBallVertical + 1) or (CurrentPositionVertical = CursorBallVertical + BALL_SIDE - 1)) and (CurrentPositionHorizontal > CursorBallHorizontal + 1) and (CurrentPositionHorizontal <= CursorBallHorizontal + 9)) or
                   (((CurrentPositionVertical = CursorBallVertical + 2) or (CurrentPositionVertical = CursorBallVertical + BALL_SIDE - 2)
                   or (CurrentPositionVertical = CursorBallVertical + 3) or (CurrentPositionVertical = CursorBallVertical + BALL_SIDE - 3)) and (CurrentPositionHorizontal > CursorBallHorizontal) and (CurrentPositionHorizontal <= CursorBallHorizontal + 10)) or
                   ((CurrentPositionVertical > CursorBallVertical + 2) and (CurrentPositionVertical <= CursorBallVertical + 7) and (CurrentPositionHorizontal >= CursorBallHorizontal) and (CurrentPositionHorizontal <= CursorBallHorizontal + 11));






    brick0Visible <= brickVI(0) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + brickLength and CurrentPositionVertical > BP_V + SP_V + FP_V and CurrentPositionVertical <= BP_V + SP_V + FP_V + 20;
    
    brick1Visible <= brickVI(1) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + brickLength + 1 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and CurrentPositionVertical > BP_V + SP_V + FP_V and CurrentPositionVertical <= BP_V + SP_V + FP_V + 20;
    
    brick2Visible <= brickVI(2) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 2*brickLength + 2 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and CurrentPositionVertical > BP_V + SP_V + FP_V and CurrentPositionVertical <= BP_V + SP_V + FP_V + 20;
    
    brick3Visible <= brickVI(3) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 3*brickLength + 3 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and CurrentPositionVertical > BP_V + SP_V + FP_V and CurrentPositionVertical <= BP_V + SP_V + FP_V + 20;
    
    brick4Visible <= brickVI(4) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 4*brickLength + 4 and CurrentPositionHorizontal <= TOT_H and CurrentPositionVertical > BP_V + SP_V + FP_V and CurrentPositionVertical <= BP_V + SP_V + FP_V + 20;
    



    brick5Visible <= brickVI(5) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + brickLength and CurrentPositionVertical > BP_V + SP_V + FP_V + 21 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 41;
    
    brick6Visible <= brickVI(6) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + brickLength + 1 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and CurrentPositionVertical > BP_V + SP_V + FP_V + 21 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 41;
    
    brick7Visible <= brickVI(7) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 2*brickLength + 2 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and CurrentPositionVertical > BP_V + SP_V + FP_V + 21 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 41;
    
    brick8Visible <= brickVI(8) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 3*brickLength + 3 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and CurrentPositionVertical > BP_V + SP_V + FP_V + 21 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 41;
    
    brick9Visible <= brickVI(9) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 4*brickLength + 4 and CurrentPositionHorizontal <= TOT_H and CurrentPositionVertical > BP_V + SP_V + FP_V + 21 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 41;

    
    brick10Visible <= brickVI(10) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + brickLength and CurrentPositionVertical > BP_V + SP_V + FP_V + 42 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 62;
    
    brick11Visible <= brickVI(11) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + brickLength + 1 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and CurrentPositionVertical > BP_V + SP_V + FP_V + 42 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 62;
    
    brick12Visible <= brickVI(12) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 2*brickLength + 2 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and CurrentPositionVertical > BP_V + SP_V + FP_V + 42 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 62;
    
    brick13Visible <= brickVI(13) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 3*brickLength + 3 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and CurrentPositionVertical > BP_V + SP_V + FP_V + 42 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 62;
    
    brick14Visible <= brickVI(14) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 4*brickLength + 4 and CurrentPositionHorizontal <= TOT_H and CurrentPositionVertical > BP_V + SP_V + FP_V + 42 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 62;

    
    
    brick15Visible <= brickVI(15) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + brickLength and CurrentPositionVertical > BP_V + SP_V + FP_V + 63 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 83;
    
    brick16Visible <= brickVI(16) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + brickLength + 1 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and CurrentPositionVertical > BP_V + SP_V + FP_V + 63 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 83;
    
    brick17Visible <= brickVI(17) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 2*brickLength + 2 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and CurrentPositionVertical > BP_V + SP_V + FP_V + 63 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 83;
    
    brick18Visible <= brickVI(18) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 3*brickLength + 3 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and CurrentPositionVertical > BP_V + SP_V + FP_V + 63 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 83;
    
    brick19Visible <= brickVI(19) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 4*brickLength + 4 and CurrentPositionHorizontal <= TOT_H and CurrentPositionVertical > BP_V + SP_V + FP_V + 63 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 83;
    
 
 
    brick20Visible <= brickVI(20) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + brickLength and CurrentPositionVertical > BP_V + SP_V + FP_V + 84 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 104;
    
    brick21Visible <= brickVI(21) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + brickLength + 1 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and CurrentPositionVertical > BP_V + SP_V + FP_V + 84 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 104;
    
    brick22Visible <= brickVI(22) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 2*brickLength + 2 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and CurrentPositionVertical > BP_V + SP_V + FP_V + 84 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 104;
    
    brick23Visible <= brickVI(23) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 3*brickLength + 3 and CurrentPositionHorizontal <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and CurrentPositionVertical > BP_V + SP_V + FP_V + 84 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 104;
    
    brick24Visible <= brickVI(24) = '1' and CurrentPositionHorizontal > FP_H + SP_H + BP_H + 4*brickLength + 4 and CurrentPositionHorizontal <= TOT_H and CurrentPositionVertical > BP_V + SP_V + FP_V + 84 and CurrentPositionVertical <= BP_V + SP_V + FP_V + 104;
 
    
    --Scanning the Pixels
    NextPositionHorizontal <= CurrentPositionHorizontal + 1 when CurrentPositionHorizontal < TOT_H else 1;
    NextPositionVertical <= CurrentPositionVertical + 1 when CurrentPositionHorizontal = TOT_H and CurrentPositionVertical < TOT_V else
                1 when CurrentPositionHorizontal = TOT_H and CurrentPositionVertical = TOT_V else CurrentPositionVertical;




	--Color Selection with a multiplexer
    NextRGB <= "001011110001" when VisibPad else
               "001101111111" when VisibBall else                    
               "000000001111" when brick0Visible or brick1Visible  or brick2Visible or brick3Visible or brick4Visible else
               "101111110011" when brick5Visible or brick6Visible  or brick7Visible or brick8Visible or brick9Visible else
               "111111111111" when brick10Visible or brick11Visible  or brick12Visible or brick13Visible or brick14Visible else
               "101111110011" when brick15Visible or brick16Visible  or brick17Visible or brick18Visible or brick19Visible else
               "111111111111" when brick20Visible or brick21Visible  or brick22Visible or brick23Visible or brick24Visible else
               "000000000000";    




    hSync <= '0' when (CurrentPositionHorizontal > FP_H) and (CurrentPositionHorizontal < FP_H + SP_H + 1) else '1';
    vSync <= '0' when (CurrentPositionVertical > FP_V) and (CurrentPositionVertical < FP_V + SP_V + 1) else '1';
    r <= CurrentRGB(11 downto 8);
    g <= CurrentRGB(7 downto 4);
    b <= CurrentRGB(3 downto 0);
    points <= score;    
end Behavioral;