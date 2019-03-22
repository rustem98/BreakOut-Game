library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Constants.all;
use IEEE.std_logic_unsigned.all;

entity BallController is

  Port (
        PosPaddle: in integer range TOT_H - VIS_H + 1 to TOT_H - PADDLE_WIDTH;
        brickVis: out std_logic_vector(24 downto 0);
        points: out std_logic_vector(6 downto 0);
        start, move: in std_logic;
        PositionX: out integer range TOT_H - VIS_H + 1 to TOT_H - BALL_SIDE;
        PositionY: out integer range TOT_V - VIS_V + 1 to TOT_V;
        play, LostGame: out std_logic;
        WidthPaddle: in integer);
end BallController;

architecture Behavioral of BallController is



signal Xcur: integer range TOT_H - VIS_H + 1 to TOT_H - BALL_SIDE:= BALL_INITIAL_X;
signal Ycur: integer range TOT_V - VIS_V + 1 to TOT_V:= BALL_INITIAL_Y;
signal CurrPlay: std_logic:= '0';
signal LoosingCurrent: std_logic:= '0';
signal brickVI: std_logic_vector(24 downto 0):= "1111111111111111111111111";
signal brickLength: integer:= (TOT_H - BP_H - SP_H - FP_H - 4)/5;
signal score: std_logic_vector(6 downto 0) := "0000000";


begin



 process(move)
 variable hBounceWall,vBounceWall, sideBoucePaddle, hBoucePaddle: boolean := false; --Collision indicating variables
 variable brick0hBounce, brick1hBounce, brick2hBounce, brick3hBounce, brick4hBounce: boolean := false;
 variable brick0vBounce, brick1vBounce, brick2vBounce, brick3vBounce, brick4vBounce: boolean := false;
 
 variable brick5hBounce, brick6hBounce, brick7hBounce, brick8hBounce, brick9hBounce: boolean := false;
 variable brick5vBounce, brick6vBounce, brick7vBounce, brick8vBounce, brick9vBounce: boolean := false;
 
 variable brick10hBounce, brick11hBounce, brick12hBounce, brick13hBounce, brick14hBounce: boolean := false;
 variable brick10vBounce, brick11vBounce, brick12vBounce, brick13vBounce, brick14vBounce: boolean := false;

 variable brick15hBounce, brick16hBounce, brick17hBounce, brick18hBounce, brick19hBounce: boolean := false;
 variable brick15vBounce, brick16vBounce, brick17vBounce, brick18vBounce, brick19vBounce: boolean := false;
 
 variable brick20hBounce, brick21hBounce, brick22hBounce, brick23hBounce, brick24hBounce: boolean := false;
 variable brick20vBounce, brick21vBounce, brick22vBounce, brick23vBounce, brick24vBounce: boolean := false;

 variable hVel: integer:= -1; 
 variable vVel: integer:= -1;  






    begin
        if move'event and move = '1' then




            
            
            if Ycur >= TOT_V  then
                LoosingCurrent <= '1';
            elsif start = '1' then
                LoosingCurrent <= '0';
            end if;

            
                
            --Reset Logic
            if LoosingCurrent = '1' then
                brickVI <= "1111111111111111111111111";
                Xcur <= BALL_INITIAL_X;
                Ycur <= BALL_INITIAL_Y;
                CurrPlay <= '0';
                score <= "0000000";
            elsif start = '1' then
                CurrPlay <= '1';
                end if;
                
                

                


            



 
            hBounceWall := Xcur <= FP_H + SP_H + BP_H + 1 or Xcur >= TOT_H - BALL_SIDE;


            vBounceWall := Ycur <= FP_V + SP_V + BP_V + 1;
             
 
            hBoucePaddle := Ycur >= TOT_V - PADDLE_HEIGHT - BALL_SIDE and 
                                   Xcur >= PosPaddle and 
                                   Xcur <= PosPaddle + WidthPaddle - BALL_SIDE;
 
 
            sideBoucePaddle := ((Xcur = PosPaddle - 9 or Xcur = PosPaddle - 8 or Xcur = PosPaddle + WidthPaddle or Xcur = PosPaddle + WidthPaddle - 1)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 10)) or
                                ((Xcur = PosPaddle - 8 or Xcur = PosPaddle - 7 or Xcur = PosPaddle + WidthPaddle - 1 or Xcur = PosPaddle + WidthPaddle - 2)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 9)) or
                                ((Xcur = PosPaddle - 7 or Xcur = PosPaddle - 6 or Xcur = PosPaddle + WidthPaddle - 2 or Xcur = PosPaddle + WidthPaddle - 3)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 8)) or
                                ((Xcur = PosPaddle - 6 or Xcur = PosPaddle - 5 or Xcur = PosPaddle + WidthPaddle - 3 or Xcur = PosPaddle + WidthPaddle - 4)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 7)) or
                                ((Xcur = PosPaddle - 5 or Xcur = PosPaddle - 4 or Xcur = PosPaddle + WidthPaddle - 4 or Xcur = PosPaddle + WidthPaddle - 5)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 6)) or
                                ((Xcur = PosPaddle - 4 or Xcur = PosPaddle - 3 or Xcur = PosPaddle + WidthPaddle - 5 or Xcur = PosPaddle + WidthPaddle - 6)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 5)) or
                                ((Xcur = PosPaddle - 3 or Xcur = PosPaddle - 2 or Xcur = PosPaddle + WidthPaddle - 6 or Xcur = PosPaddle + WidthPaddle - 7)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 4)) or
                                ((Xcur = PosPaddle - 2 or Xcur = PosPaddle - 1 or Xcur = PosPaddle + WidthPaddle - 7 or Xcur = PosPaddle + WidthPaddle - 8)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 3)) or
                                ((Xcur = PosPaddle - 1 or Xcur = PosPaddle or Xcur = PosPaddle + WidthPaddle - 8 or Xcur = PosPaddle + WidthPaddle - 9)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 2)) or
                                ((Xcur = PosPaddle or Xcur = PosPaddle + 1 or Xcur = PosPaddle + WidthPaddle - 9 or Xcur = PosPaddle + WidthPaddle - 10)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE + 1)) or
                                ((Xcur = PosPaddle + 1 or Xcur = PosPaddle + 2 or Xcur = PosPaddle + WidthPaddle - 10 or Xcur = PosPaddle + WidthPaddle - 11)
                                and (Ycur = TOT_V - PADDLE_HEIGHT - BALL_SIDE));

            
            
           brick0vBounce := brickVI(0) = '1' and Xcur > FP_H + SP_H + BP_H and Xcur <= FP_H + SP_H + BP_H  + brickLength and Ycur = BP_V + SP_V + FP_V + 21;
           
           brick1vBounce := brickVI(1) = '1' and Xcur >= FP_H + SP_H + BP_H  + brickLength + 1 and Xcur <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and Ycur = BP_V + SP_V + FP_V + 21;
           
           brick2vBounce := brickVI(2) = '1' and Xcur >= FP_H + SP_H + BP_H  + 2*brickLength + 2 and Xcur <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and Ycur = BP_V + SP_V + FP_V + 21;
           
           brick3vBounce := brickVI(3) = '1' and Xcur >= FP_H + SP_H + BP_H  + 3*brickLength + 3 and Xcur <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and Ycur = BP_V + SP_V + FP_V + 21;
           
           brick4vBounce := brickVI(4) = '1' and Xcur >= FP_H + SP_H + BP_H  + 4*brickLength + 4 and Xcur <= TOT_H and Ycur = BP_V + SP_V + FP_V + 21;
           
           
           brick0hBounce := brickVI(0) = '1' and Xcur = FP_H + SP_H + BP_H + brickLength + 1 and Ycur > FP_V + SP_V + BP_V and Ycur <= FP_V + SP_V + BP_V + 20;
 
           brick1hBounce := brickVI(1) = '1' and Ycur > FP_V + SP_V + BP_V and Ycur <= FP_V + SP_V + BP_V + 20 and (Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 or Xcur = FP_H + SP_H + BP_H + brickLength + 1 - BALL_SIDE);
           
           brick2hBounce := brickVI(2) = '1' and Ycur > FP_V + SP_V + BP_V and Ycur <= FP_V + SP_V + BP_V + 20 and (Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 or Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 - BALL_SIDE);
           
           brick3hBounce := brickVI(3) = '1' and Ycur > FP_V + SP_V + BP_V and Ycur <= FP_V + SP_V + BP_V + 20 and (Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 or Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 - BALL_SIDE);
           
           brick4hBounce := brickVI(4) = '1' and Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 - BALL_SIDE and Ycur > FP_V + SP_V + BP_V and Ycur <= FP_V + SP_V + BP_V + 20;
           
           
           brick5vBounce := brickVI(5) = '1' and (Xcur > FP_H + SP_H + BP_H and Xcur <= FP_H + SP_H + BP_H  + brickLength) and  (Ycur = BP_V + SP_V + FP_V + 21 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 43) ;
                      
           brick6vBounce := brickVI(6) = '1' and (Xcur >= FP_H + SP_H + BP_H  + brickLength + 1 and Xcur <= FP_H + SP_H + BP_H  + 2*brickLength + 1) and (Ycur = BP_V + SP_V + FP_V + 21 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 43);
                      
           brick7vBounce := brickVI(7) = '1' and (Xcur >= FP_H + SP_H + BP_H  + 2*brickLength + 2 and Xcur <= FP_H + SP_H + BP_H  + 3*brickLength + 2) and (Ycur = BP_V + SP_V + FP_V + 21 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 43);
                      
           brick8vBounce := brickVI(8) = '1' and (Xcur >= FP_H + SP_H + BP_H  + 3*brickLength + 3 and Xcur <= FP_H + SP_H + BP_H  + 4*brickLength + 3) and (Ycur = BP_V + SP_V + FP_V + 21 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 43) ;
                      
           brick9vBounce := brickVI(9) = '1' and (Xcur >= FP_H + SP_H + BP_H  + 4*brickLength + 4 and Xcur <= TOT_H - BALL_SIDE) and (Ycur = BP_V + SP_V + FP_V + 21 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 43) ;
                      
                      
           brick5hBounce := brickVI(5) = '1' and Xcur = FP_H + SP_H + BP_H + brickLength + 1 and Ycur > FP_V + SP_V + BP_V + 21 and Ycur <= FP_V + SP_V + BP_V + 41;
            
           brick6hBounce := brickVI(6) = '1' and Ycur > FP_V + SP_V + BP_V + 21 and Ycur <= FP_V + SP_V + BP_V + 41  and (Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 or Xcur = FP_H + SP_H + BP_H + brickLength + 1 - BALL_SIDE);
                      
           brick7hBounce := brickVI(7) = '1' and Ycur > FP_V + SP_V + BP_V + 21 and Ycur <= FP_V + SP_V + BP_V + 41  and (Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 or Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 - BALL_SIDE);
                      
           brick8hBounce := brickVI(8) = '1' and Ycur > FP_V + SP_V + BP_V + 21 and Ycur <= FP_V + SP_V + BP_V + 41  and (Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 or Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 - BALL_SIDE);
                      
           brick9hBounce := brickVI(9) = '1' and Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 - BALL_SIDE and Ycur > FP_V + SP_V + BP_V + 21 and Ycur <= FP_V + SP_V + BP_V + 41;           




           brick10vBounce := brickVI(10) = '1' and Xcur > FP_H + SP_H + BP_H and Xcur <= FP_H + SP_H + BP_H  + brickLength and (Ycur = BP_V + SP_V + FP_V + 42 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 65);
           
           brick11vBounce := brickVI(11) = '1' and Xcur >= FP_H + SP_H + BP_H  + brickLength + 1 and Xcur <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and (Ycur = BP_V + SP_V + FP_V + 42 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 65);
           
           brick12vBounce := brickVI(12) = '1' and Xcur >= FP_H + SP_H + BP_H  + 2*brickLength + 2 and Xcur <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and (Ycur = BP_V + SP_V + FP_V + 42 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 65);
           
           brick13vBounce := brickVI(13) = '1' and Xcur >= FP_H + SP_H + BP_H  + 3*brickLength + 3 and Xcur <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and (Ycur = BP_V + SP_V + FP_V + 42 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 65);
           
           brick14vBounce := brickVI(14) = '1' and Xcur >= FP_H + SP_H + BP_H  + 4*brickLength + 4 and Xcur <= TOT_H- BALL_SIDE and (Ycur = BP_V + SP_V + FP_V + 42 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 65);
           
           
           brick10hBounce := brickVI(10) = '1' and Xcur = FP_H + SP_H + BP_H + brickLength + 1 and Ycur > FP_V + SP_V + BP_V +42 and Ycur <= FP_V + SP_V + BP_V + 62;
 
           brick11hBounce := brickVI(11) = '1' and Ycur > FP_V + SP_V + BP_V +42 and Ycur <= FP_V + SP_V + BP_V + 62 and (Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 or Xcur = FP_H + SP_H + BP_H + brickLength + 1 - BALL_SIDE);
           
           brick12hBounce := brickVI(12) = '1' and Ycur > FP_V + SP_V + BP_V +42 and Ycur <= FP_V + SP_V + BP_V + 62 and (Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 or Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 - BALL_SIDE);
           
           brick13hBounce := brickVI(13) = '1' and Ycur > FP_V + SP_V + BP_V +42 and Ycur <= FP_V + SP_V + BP_V + 62 and (Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 or Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 - BALL_SIDE);
           
           brick14hBounce := brickVI(14) = '1' and Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 - BALL_SIDE and Ycur > FP_V + SP_V + BP_V +42 and Ycur <= FP_V + SP_V + BP_V + 62;
           
           
           brick15vBounce := brickVI(15) = '1' and (Xcur > FP_H + SP_H + BP_H and Xcur <= FP_H + SP_H + BP_H  + brickLength) and  (Ycur = BP_V + SP_V + FP_V + 63 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 87);
                      
           brick16vBounce := brickVI(16) = '1' and (Xcur >= FP_H + SP_H + BP_H  + brickLength + 1 and Xcur <= FP_H + SP_H + BP_H  + 2*brickLength + 1) and (Ycur = BP_V + SP_V + FP_V + 63 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 87);
                      
           brick17vBounce := brickVI(17) = '1' and (Xcur >= FP_H + SP_H + BP_H  + 2*brickLength + 2 and Xcur <= FP_H + SP_H + BP_H  + 3*brickLength + 2) and (Ycur = BP_V + SP_V + FP_V + 63 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 87);
                      
           brick18vBounce := brickVI(18) = '1' and (Xcur >= FP_H + SP_H + BP_H  + 3*brickLength + 3 and Xcur <= FP_H + SP_H + BP_H  + 4*brickLength + 3) and (Ycur = BP_V + SP_V + FP_V + 63 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 87);
                      
           brick19vBounce := brickVI(19) = '1' and (Xcur >= FP_H + SP_H + BP_H  + 4*brickLength + 4 and Xcur <= TOT_H - BALL_SIDE) and (Ycur = BP_V + SP_V + FP_V + 63 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 87);
                      
                      
           brick15hBounce := brickVI(15) = '1' and Xcur = FP_H + SP_H + BP_H + brickLength + 1 and Ycur > FP_V + SP_V + BP_V + 63 and Ycur <= FP_V + SP_V + BP_V + 83;
            
           brick16hBounce := brickVI(16) = '1' and Ycur > FP_V + SP_V + BP_V + 63 and Ycur <= FP_V + SP_V + BP_V + 83  and (Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 or Xcur = FP_H + SP_H + BP_H + brickLength + 1 - BALL_SIDE);
                      
           brick17hBounce := brickVI(17) = '1' and Ycur > FP_V + SP_V + BP_V + 63 and Ycur <= FP_V + SP_V + BP_V + 83  and (Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 or Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 - BALL_SIDE);
                      
           brick18hBounce := brickVI(18) = '1' and Ycur > FP_V + SP_V + BP_V + 63 and Ycur <= FP_V + SP_V + BP_V + 83  and (Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 or Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 - BALL_SIDE);
                      
           brick19hBounce := brickVI(19) = '1' and Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 - BALL_SIDE and Ycur > FP_V + SP_V + BP_V + 63 and Ycur <= FP_V + SP_V + BP_V + 83;           




           brick20vBounce := brickVI(20) = '1' and Xcur > FP_H + SP_H + BP_H and Xcur <= FP_H + SP_H + BP_H  + brickLength and (Ycur = BP_V + SP_V + FP_V + 86 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 109);
           
           brick21vBounce := brickVI(21) = '1' and Xcur >= FP_H + SP_H + BP_H  + brickLength + 1 and Xcur <= FP_H + SP_H + BP_H  + 2*brickLength + 1 and (Ycur = BP_V + SP_V + FP_V + 86 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 109);
           
           brick22vBounce := brickVI(22) = '1' and Xcur >= FP_H + SP_H + BP_H  + 2*brickLength + 2 and Xcur <= FP_H + SP_H + BP_H  + 3*brickLength + 2 and (Ycur = BP_V + SP_V + FP_V + 86 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 109);
           
           brick23vBounce := brickVI(23) = '1' and Xcur >= FP_H + SP_H + BP_H  + 3*brickLength + 3 and Xcur <= FP_H + SP_H + BP_H  + 4*brickLength + 3 and (Ycur = BP_V + SP_V + FP_V + 86 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 109);
           
           brick24vBounce := brickVI(24) = '1' and Xcur >= FP_H + SP_H + BP_H  + 4*brickLength + 4 and Xcur <= TOT_H- BALL_SIDE and (Ycur = BP_V + SP_V + FP_V + 86 - BALL_SIDE or Ycur = BP_V + SP_V + FP_V + 109);
           
           
           brick20hBounce := brickVI(20) = '1' and Xcur = FP_H + SP_H + BP_H + brickLength + 1 and Ycur > FP_V + SP_V + BP_V + 84 and Ycur <= FP_V + SP_V + BP_V + 104;
 
           brick21hBounce := brickVI(21) = '1' and Ycur > FP_V + SP_V + BP_V + 84 and Ycur <= FP_V + SP_V + BP_V + 104 and (Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 or Xcur = FP_H + SP_H + BP_H + brickLength + 1 - BALL_SIDE);
           
           brick22hBounce := brickVI(22) = '1' and Ycur > FP_V + SP_V + BP_V + 84 and Ycur <= FP_V + SP_V + BP_V + 104 and (Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 or Xcur = FP_H + SP_H + BP_H + 2*brickLength + 2 - BALL_SIDE);
           
           brick23hBounce := brickVI(23) = '1' and Ycur > FP_V + SP_V + BP_V + 84 and Ycur <= FP_V + SP_V + BP_V + 104 and (Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 or Xcur = FP_H + SP_H + BP_H + 3*brickLength + 3 - BALL_SIDE);
           
           brick24hBounce := brickVI(24) = '1' and Xcur = FP_H + SP_H + BP_H + 4*brickLength + 4 - BALL_SIDE and Ycur > FP_V + SP_V + BP_V + 84 and Ycur <= FP_V + SP_V + BP_V + 104;


           
           
           
           
           
            --Next state logics for the position and velocity of the ball                      
            if hBounceWall or sideBoucePaddle or brick0hBounce  or brick1hBounce or brick2hBounce or brick3hBounce or brick4hBounce or brick5hBounce  or brick6hBounce or brick7hBounce  or brick8hBounce or brick9hBounce or brick10hBounce  or brick11hBounce or brick12hBounce or brick13hBounce or brick14hBounce or brick15hBounce or brick16hBounce or brick17hBounce  or brick18hBounce or brick19hBounce or brick20hBounce or brick21hBounce or brick22hBounce or brick23hBounce or brick24hBounce then
               hVel := - hVel;
            elsif CurrPlay = '0' then
               hVel := -1; 
            end if;
            
            if hBoucePaddle or sideBoucePaddle or vBounceWall or brick0vBounce  or brick1vBounce or brick2vBounce or brick3vBounce or brick4vBounce or brick5vBounce  or brick6vBounce or brick7vBounce  or brick8vBounce or brick9vBounce or brick10vBounce  or brick11vBounce or brick12vBounce or brick13vBounce or brick14vBounce or brick15vBounce or brick16vBounce or brick17vBounce  or brick18vBounce or brick19vBounce or brick20vBounce or brick21vBounce or brick22vBounce or brick23vBounce or brick24vBounce then
                vVel :=  - vVel;
            elsif CurrPlay = '0' then
                vVel := -1;
            end if;
            
            if brick0vBounce or  brick0hBounce then
            brickVI(0) <= '0';
            score <= score + 5;
            
            end if;
            
            if brick1vBounce or brick1hBounce then
            brickVI(1) <= '0';
            score <= score + 5;
            end if;
            
            if brick2vBounce or brick2hBounce then
            brickVI(2) <= '0';
            score <= score + 5;
            end if;
            
            if brick3vBounce or brick3hBounce then
            brickVI(3) <= '0';
            score <= score + 5;
            end if;
            
            
            if brick4vBounce or brick4hBounce then
            brickVI(4) <= '0';
            score <= score + 5;
            end if;


            if brick5vBounce or brick5hBounce then
            brickVI(5) <= '0';
            score <= score + 4;
            end if;
            
            if brick6vBounce or brick6hBounce then
            brickVI(6) <= '0';
            score <= score + 4;
            end if;
            
            if brick7vBounce or brick7hBounce then
            brickVI(7) <= '0';
            score <= score + 4;
            end if;


            if brick8vBounce or brick8hBounce then
            brickVI(8) <= '0';
            score <= score + 4;
            end if;

            if brick9vBounce or brick9hBounce then
            brickVI(9) <= '0';
            score <= score + 4;
            end if;

           if brick10vBounce or  brick10hBounce then
            brickVI(10) <= '0';
            score <= score + 3;
            end if;
            
            if brick11vBounce or brick11hBounce then
            brickVI(11) <= '0';
            score <= score + 3;
            end if;
            
            if brick12vBounce or brick12hBounce then
            brickVI(12) <= '0';
            score <= score + 3;
            end if;
            
            if brick13vBounce or brick13hBounce then
            brickVI(13) <= '0';
            score <= score + 3;
            end if;
            
            
            if brick14vBounce or brick14hBounce then
            brickVI(14) <= '0';
            score <= score + 3;
            end if;


            if brick15vBounce or brick15hBounce then
            brickVI(15) <= '0';
            score <= score + 2;
            end if;
            
            if brick16vBounce or brick16hBounce then
            brickVI(16) <= '0';
            score <= score + 2;
            end if;
            
            if brick17vBounce or brick17hBounce then
            brickVI(17) <= '0';
            score <= score + 2;
            end if;


            if brick18vBounce or brick18hBounce then
            brickVI(18) <= '0';
            score <= score + 2;
            end if;

            if brick19vBounce or brick19hBounce then
            brickVI(19) <= '0';
            score <= score + 2;
            end if;

           if brick20vBounce or  brick20hBounce then
            brickVI(20) <= '0';
            score <= score + 1;
            end if;
            
            if brick21vBounce or brick21hBounce then
            brickVI(21) <= '0';
            score <= score + 1;
            end if;
            
            if brick22vBounce or brick22hBounce then
            brickVI(22) <= '0';
            score <= score + 1;
            end if;
            
            if brick23vBounce or brick23hBounce then
            brickVI(23) <= '0';
            score <= score + 1;
            end if;
            
            
            if brick24vBounce or brick24hBounce then
            brickVI(24) <= '0';
            score <= score + 1;
            end if;


            
            if CurrPlay = '1' then
                Xcur <= Xcur + hVel;
                Ycur <= Ycur + vVel;
            end if;
        end if;
    end process;
    





    --Register to update the main signals
    PositionX <= Xcur;
    PositionY <= Ycur;
    brickVis <= brickVI;
    play <= CurrPlay;
    points <= score;
    LostGame <= LoosingCurrent;
end Behavioral;