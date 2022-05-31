----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 15:34:19
-- Design Name: 
-- Module Name: UALTest - Behavioral
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

entity UALTest is
--  Port ( );
end UALTest;

architecture Behavioral of UALTest is

component UAL is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           C : out STD_LOGIC;
           Z : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal testA: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testB: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testCtrl_Alu: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
signal testN: STD_LOGIC;
signal testO: STD_LOGIC;
signal testC: STD_LOGIC;
signal testZ: STD_LOGIC;
signal testS: STD_LOGIC_VECTOR (7 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Label_IM: UAL PORT MAP(
    A => testA,
    B => testB,
    Ctrl_Alu => testCtrl_Alu,
    N => testN,
    O => testO,
    C => testC,
    Z => testZ,
    S => testS 
);

Clock_process : process
begin
    wait for Clock_period/2;
end process;

testCtrl_Alu <= "000" after 100ns, "001" after 200ns, "010" after 300ns;
testA <= X"23";
testB <= X"43";

end Behavioral;
