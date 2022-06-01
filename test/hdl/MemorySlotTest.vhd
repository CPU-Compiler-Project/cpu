----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 15:34:19
-- Design Name: 
-- Module Name: MemorySlotTest - Behavioral
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

entity MemorySlotTest is
--  Port ( );
end MemorySlotTest;

architecture Behavioral of MemorySlotTest is

component MemorySlot is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal testADDR: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testINPUT: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testRW: STD_LOGIC := '0';
signal testRST: STD_LOGIC := '1';
signal testCLK: STD_LOGIC := '0';
signal testOUTPUT: STD_LOGIC_VECTOR (7 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Label_MS: MemorySlot PORT MAP(
    ADDR => testADDR,
    INPUT => testINPUT,
    RW => testRW,
    RST => testRST,
    CLK => testCLK,
    OUTPUT => testOUTPUT 
);

Clock_process : process
begin
    testCLK <= not(testCLK);
    wait for Clock_period/2;
end process;

-- write 42 at @0x00
testADDR <= X"00" after 20 ns, X"00" after 500 ns;

-- read value at @0x00 (should be 42)
testRW <= '1' after 20 ns, '0' after 500 ns;
testINPUT <= X"2A" after 20 ns;


end Behavioral;
