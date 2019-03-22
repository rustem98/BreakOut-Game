##The constraints file that does the proper input-output mapping

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
	set_property IOSTANDARD LVCMOS33 [get_ports clock]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]
 
##Buttons
set_property PACKAGE_PIN U18 [get_ports centerButton]
	set_property IOSTANDARD LVCMOS33 [get_ports centerButton]
set_property PACKAGE_PIN T18 [get_ports upButton]
	set_property IOSTANDARD LVCMOS33 [get_ports upButton]
set_property PACKAGE_PIN W19 [get_ports leftButton]
	set_property IOSTANDARD LVCMOS33 [get_ports leftButton]
set_property PACKAGE_PIN T17 [get_ports rightButton]
	set_property IOSTANDARD LVCMOS33 [get_ports rightButton]
set_property PACKAGE_PIN U17 [get_ports downButton]
	set_property IOSTANDARD LVCMOS33 [get_ports downButton]

##Switches
set_property PACKAGE_PIN T1 [get_ports {difficultyControl[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {difficultyControl[0]}]
set_property PACKAGE_PIN R2 [get_ports {difficultyControl[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {difficultyControl[1]}]
	
##VGA Connector
set_property PACKAGE_PIN G19 [get_ports {VGARed[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGARed[0]}]
set_property PACKAGE_PIN H19 [get_ports {VGARed[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGARed[1]}]
set_property PACKAGE_PIN J19 [get_ports {VGARed[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGARed[2]}]
set_property PACKAGE_PIN N19 [get_ports {VGARed[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGARed[3]}]
set_property PACKAGE_PIN N18 [get_ports {VGABlue[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGABlue[0]}]
set_property PACKAGE_PIN L18 [get_ports {VGABlue[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGABlue[1]}]
set_property PACKAGE_PIN K18 [get_ports {VGABlue[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGABlue[2]}]
set_property PACKAGE_PIN J18 [get_ports {VGABlue[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGABlue[3]}]
set_property PACKAGE_PIN J17 [get_ports {VGAGreen[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGAGreen[0]}]
set_property PACKAGE_PIN H17 [get_ports {VGAGreen[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGAGreen[1]}]
set_property PACKAGE_PIN G17 [get_ports {VGAGreen[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGAGreen[2]}]
set_property PACKAGE_PIN D17 [get_ports {VGAGreen[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VGAGreen[3]}]
set_property PACKAGE_PIN P19 [get_ports hSync]
	set_property IOSTANDARD LVCMOS33 [get_ports hSync]
set_property PACKAGE_PIN R19 [get_ports vSync]
	set_property IOSTANDARD LVCMOS33 [get_ports vSync]
	
#7 segment display
    set_property PACKAGE_PIN W7 [get_ports {a_to_g[0]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[0]}]
    set_property PACKAGE_PIN W6 [get_ports {a_to_g[1]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[1]}]
    set_property PACKAGE_PIN U8 [get_ports {a_to_g[2]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[2]}]
    set_property PACKAGE_PIN V8 [get_ports {a_to_g[3]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[3]}]
    set_property PACKAGE_PIN U5 [get_ports {a_to_g[4]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[4]}]
    set_property PACKAGE_PIN V5 [get_ports {a_to_g[5]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[5]}]
    set_property PACKAGE_PIN U7 [get_ports {a_to_g[6]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[6]}]
    
        
    set_property PACKAGE_PIN U2 [get_ports {an[0]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
    set_property PACKAGE_PIN U4 [get_ports {an[1]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
    set_property PACKAGE_PIN V4 [get_ports {an[2]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
    set_property PACKAGE_PIN W4 [get_ports {an[3]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]