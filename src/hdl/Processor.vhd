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
    Port ( IP_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

signal out_im : STD_LOGIC_VECTOR (31 downto 0);
signal out_rbA : STD_LOGIC_VECTOR (7 downto 0);
signal out_rbB : STD_LOGIC_VECTOR (7 downto 0);
signal out_ualS : STD_LOGIC_VECTOR (7 downto 0);
signal out_msOUT : STD_LOGIC_VECTOR (7 downto 0);

signal out_LC_1 : STD_LOGIC;
signal out_LC_2 : STD_LOGIC;
signal out_LC_3 : STD_LOGIC_VECTOR (2 downto 0);
signal out_MUX_1 : STD_LOGIC_VECTOR (7 downto 0);
signal out_MUX_2 : STD_LOGIC_VECTOR (7 downto 0);
signal out_MUX_3 : STD_LOGIC_VECTOR (7 downto 0);
signal out_MUX_4 : STD_LOGIC_VECTOR (7 downto 0);

component InstructionMemory is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;


component RegisterBus
    port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component UAL
    port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           C : out STD_LOGIC;
           Z : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MemorySlot
    port (  ADDR : in STD_LOGIC_VECTOR (7 downto 0);    
            INPUT : in STD_LOGIC_VECTOR (7 downto 0);   
            RW : in STD_LOGIC;                          
            RST : in STD_LOGIC;                         
            CLK : in STD_LOGIC;                         
            OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal LI_C : STD_LOGIC_VECTOR (7 downto 0);
signal LI_B : STD_LOGIC_VECTOR (7 downto 0);
signal LI_A : STD_LOGIC_VECTOR (7 downto 0);
signal LI_OP : STD_LOGIC_VECTOR (7 downto 0);

signal DI_C : STD_LOGIC_VECTOR (7 downto 0);
signal DI_B : STD_LOGIC_VECTOR (7 downto 0);
signal DI_A : STD_LOGIC_VECTOR (7 downto 0);
signal DI_OP : STD_LOGIC_VECTOR (7 downto 0);

signal EX_B : STD_LOGIC_VECTOR (7 downto 0);
signal EX_A : STD_LOGIC_VECTOR (7 downto 0);
signal EX_OP : STD_LOGIC_VECTOR (7 downto 0);

signal MEM_B : STD_LOGIC_VECTOR (7 downto 0);
signal MEM_A : STD_LOGIC_VECTOR (7 downto 0);
signal MEM_OP : STD_LOGIC_VECTOR (7 downto 0);

begin

    PIPELINE_1 : InstructionMemory
        port map ( ADDR => IP_ADDR,
                   CLK => CLK,
                   OUTPUT => out_im); 
                   
    PIPELINE_2 : RegisterBus
        port map ( aA => LI_B(3 downto 0),
                   aB => LI_C(3 downto 0),
                   aW => MEM_A(3 downto 0),
                   W => out_LC_1,
                   DATA => MEM_B,
                   RST => RST,
                   CLK => CLK,
                   QA => out_rbA,
                   QB => out_rbB);
                   
    PIPELINE_3: UAL
        port map ( A => DI_B,
                   B => DI_C,
                   Ctrl_Alu => out_LC_3,
                   S => out_ualS);
                   
    PIPELINE_4: MemorySlot
        port map ( ADDR => out_MUX_2,
                   INPUT => EX_B,
                   RST => RST,
                   CLK => CLK,
                   RW => out_LC_2,
                   OUTPUT => out_msOUT);

     process(CLK) is
     begin
        if rising_edge(CLK) then
            MEM_A <= EX_A; -- undefined at the beginning
            MEM_B <= out_MUX_1; -- undefined at the beginning
            MEM_OP <= EX_OP; -- undefined at the beginning
            
            EX_A <= DI_A;
            EX_B <= out_MUX_3;
            EX_OP <= DI_OP;
            
            DI_A <= LI_A;
            DI_B <= out_MUX_4;
            DI_C <= out_rbB;
            DI_OP <= LI_OP;
        
            LI_C <= out_im(7 downto 0);
            LI_B <= out_im(15 downto 8);
            LI_A <= out_im(23 downto 16);
            LI_OP <= out_im(31 downto 24);
        end if;
     end process;
     
    out_LC_1 <= '0' when MEM_OP = X"08" -- STORE
           else '1';
    out_MUX_1 <= out_msOUT when EX_OP = X"07" -- LOAD
           else EX_B;
    out_LC_2 <= '1' when EX_OP = X"07" -- LOAD
           else '0' when EX_OP = X"08" -- STORE
           else '1';
    out_MUX_2 <= EX_B when EX_OP = X"07" -- LOAD
           else EX_A when EX_OP = X"08" -- STORE
           else X"00";
    out_MUX_3 <= DI_B when DI_OP = X"06" -- AFC
           or DI_OP = X"05" -- COP
           else out_ualS;
    out_LC_3 <= "000" when DI_OP = X"01" -- ADD
           else "001" when DI_OP = X"02" -- MUL
           else "010" when DI_OP = X"03" -- SOU
           else "011" when DI_OP = X"04"; -- DIV
   out_MUX_4 <= LI_B when LI_OP = X"06" -- AFC
          else out_rbA;
    
    
end Behavioral;