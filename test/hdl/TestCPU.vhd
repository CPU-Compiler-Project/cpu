----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.05.2022 11:44:44
-- Design Name: 
-- Module Name: TestCPU - Behavioral
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

entity TestCPU is
--  Port ( );
end TestCPU;

architecture Behavioral of TestCPU is

component Processor is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           OUTPUT : out STD_LOGIC);
end component;

signal testCLK: STD_LOGIC := '0';
signal testRST: STD_LOGIC := '1';
signal testOUTPUT: STD_LOGIC;
-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin
Label_uut: Processor PORT MAP(
    CLK => testCLK,
    RST => testRST,
    OUTPUT => testOUTPUT 
);

Clock_process : process
begin
    testCLK <= not(testCLK);
    wait for Clock_period/2;
end process;

testRST <= '0' after 20 ns;

end Behavioral;

