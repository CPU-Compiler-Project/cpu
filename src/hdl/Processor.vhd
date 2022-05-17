----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2022 14:50:53
-- Design Name: 
-- Module Name: Processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           OUTPUT : out STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

signal out_im : STD_LOGIC_VECTOR (31 downto 0);
signal out_rbA : STD_LOGIC_VECTOR (7 downto 0);
signal out_rbB : STD_LOGIC_VECTOR (7 downto 0);
signal out_ualS : STD_LOGIC_VECTOR (7 downto 0);
signal out_msOUT : STD_LOGIC_VECTOR (7 downto 0);

component InstructionMemory
    generic ( IM_ADDR : STD_LOGIC_VECTOR := X"01");
    port ( IM_CLK : in STD_LOGIC;
           IM_OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegisterBus
    port ( RB_aA : in STD_LOGIC_VECTOR (3 downto 0);
           RB_aB : in STD_LOGIC_VECTOR (3 downto 0);
           RB_aW : in STD_LOGIC_VECTOR (3 downto 0);
           RB_W : in STD_LOGIC;
           RB_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RB_RST : in STD_LOGIC;
           RB_CLK : in STD_LOGIC;
           RB_QA : out STD_LOGIC_VECTOR (7 downto 0);
           RB_QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component UAL
    port ( UAL_A : in STD_LOGIC_VECTOR (7 downto 0);
           UAL_B : in STD_LOGIC_VECTOR (7 downto 0);
           UAL_Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           UAL_N : out STD_LOGIC;
           UAL_O : out STD_LOGIC;
           UAL_C : out STD_LOGIC;
           UAL_Z : out STD_LOGIC;
           UAL_S : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MemorySlot
    port (  MS_ADDR : in STD_LOGIC_VECTOR (7 downto 0);    
            MS_INPUT : in STD_LOGIC_VECTOR (7 downto 0);   
            MS_RW : in STD_LOGIC;                          
            MS_RST : in STD_LOGIC;                         
            MS_CLK : in STD_LOGIC;                         
            MS_OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal LI_C : STD_LOGIC_VECTOR (3 downto 0);
signal LI_B : STD_LOGIC_VECTOR (3 downto 0);
signal LI_A : STD_LOGIC_VECTOR (7 downto 0);
signal LI_OP : STD_LOGIC_VECTOR (15 downto 0);

signal DI_C : STD_LOGIC_VECTOR (3 downto 0);
signal DI_B : STD_LOGIC_VECTOR (3 downto 0);
signal DI_A : STD_LOGIC_VECTOR (7 downto 0);
signal DI_OP : STD_LOGIC_VECTOR (15 downto 0);

signal EX_B : STD_LOGIC_VECTOR (3 downto 0);
signal EX_A : STD_LOGIC_VECTOR (7 downto 0);
signal EX_OP : STD_LOGIC_VECTOR (15 downto 0);

signal MEM_B : STD_LOGIC_VECTOR (3 downto 0);
signal MEM_A : STD_LOGIC_VECTOR (7 downto 0);
signal MEM_OP : STD_LOGIC_VECTOR (15 downto 0);

begin

    PIPELINE_1 : InstructionMemory
        port map ( IM_CLK => CLK,
                   IM_OUTPUT => out_im); 
                   
    PIPELINE_2 : RegisterBus
        port map ( RB_aA => LI_A,
                   RB_aB => LI_B,
                   RB_aW => MEM_A,
                   RB_W => MEM_OP, -- manque LC !!!!!!!!!!!!!
                   RB_DATA => MEM_B,
                   RB_RST => RST,
                   RB_CLK => CLK,
                   RB_QA => out_rbA,
                   RB_QB => out_rbB);
                   
    PIPELINE_3: UAL
        port map ( UAL_A => DI_B,
                   UAL_B => DI_C,
                   UAL_Ctrl_Alu => DI_OP, -- manque LC !!!!!!!!!!!!!
                   UAL_S => out_ualS);
                   
    PIPELINE_4: MemorySlot
        port map ( MS_ADDR => EX_B, -- manque le MUX !!!!!
                   MS_INPUT => EX_B,
                   MS_RST => RST,
                   MS_CLK => CLK,
                   MS_RW => EX_OP, -- manque LC !!!!!!!!!!!!!
                   MS_OUTPUT => out_msOUT);

     process(CLK) is
     begin
        if rising_edge(CLK) then
            MEM_A <= EX_A; -- undefined at the beginning
            MEM_B <= out_msOUT; -- manque le MUX !!!!! && undefined at the beginning
            MEM_OP <= EX_OP; -- undefined at the beginning
            
            EX_A <= DI_A;
            EX_B <= out_ualS; -- manque le MUX !!!!!
            EX_OP <= DI_OP;
            
            DI_A <= LI_A;
            DI_B <= out_rbA; -- manque le MUX !!!!!
            DI_C <= out_rbB;
            DI_OP <= LI_OP;
        
            LI_C <= out_im(3 downto 0);
            LI_B <= out_im(7 downto 4);
            LI_A <= out_im(15 downto 8);
            LI_OP <= out_im(31 downto 16);
        end if;
     end process;
  
end Behavioral;
