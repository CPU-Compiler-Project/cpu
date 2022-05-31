----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 15:34:19
-- Design Name: 
-- Module Name: InstuctionMemoryTest - Behavioral
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

entity InstructionMemoryTest is
--  Port ( );
end InstructionMemoryTest;

architecture Behavioral of InstructionMemoryTest is

component InstructionMemory is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal testADDR: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testCLK: STD_LOGIC := '0';
signal testOUTPUT: STD_LOGIC_VECTOR (31 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Label_IM: InstructionMemory PORT MAP(
    ADDR => testADDR,
    CLK => testCLK,
    OUTPUT => testOUTPUT 
);

Clock_process : process
begin
    testCLK <= not(testCLK);
    wait for Clock_period/2;
end process;

testADDR <= "00000000" after 20 ns, "00111111" after 400 ns; -- test the value at @0
-- then test the value at @63

end Behavioral;
