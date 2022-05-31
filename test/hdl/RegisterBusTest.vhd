----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 15:34:19
-- Design Name: 
-- Module Name: RegisterBusTest - Behavioral
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

entity RegisterBusTest is
--  Port ( );
end RegisterBusTest;

architecture Behavioral of RegisterBusTest is

component RegisterBus is
    Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal test_aA: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal test_aB: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal test_aW: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal test_W: STD_LOGIC := '0';
signal test_DATA: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal test_RST: STD_LOGIC := '1';
signal test_CLK: STD_LOGIC := '0';
signal test_QA: STD_LOGIC_VECTOR (7 downto 0);
signal test_QB: STD_LOGIC_VECTOR (7 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Label_RB: RegisterBus PORT MAP(
    aA => test_aA,
    aB => test_aB,
    aW => test_aW,
    W => test_W,
    DATA => test_DATA,
    RST => test_RST,
    CLK => test_CLK,
    QA => test_QA,
    QB => test_QB 
);

Clock_process : process
begin
    test_CLK <= not(test_CLK);
    wait for Clock_period/2;
end process;

test_RST <= '0' after 400 ns;
test_DATA <= X"2A" after 40 ns, X"11" after 200 ns, X"01" after 300 ns;
test_W <= '1' after 40 ns, '0' after 200 ns, '0' after 300 ns;

test_aB <= X"1" after 200 ns, X"1" after 300 ns;
test_aW <= X"1" after 200 ns, X"0" after 300 ns;

end Behavioral;
