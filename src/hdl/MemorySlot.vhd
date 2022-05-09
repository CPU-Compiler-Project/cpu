----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 14:41:26
-- Design Name: 
-- Module Name: MemorySlot - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemorySlot is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end MemorySlot;

architecture Behavioral of MemorySlot is

type tabType is array(15 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
signal dataMem: tabType := (others=>(others=>'0')) ;

begin
    process(CLK) is
    begin
        if rising_edge(CLK) then
            if RST = '0' then
               dataMem <= (others=>(others=>'0'));
            elsif RW = '0' then
               dataMem(to_integer(unsigned(ADDR))) <= INPUT;
            elsif RW = '1' then
                OUTPUT <= dataMem(to_integer(unsigned(ADDR)));
            end if;
        end if;
    end process;
end Behavioral;
