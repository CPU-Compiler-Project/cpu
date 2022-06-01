----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 13:59:26
-- Design Name: 
-- Module Name: RegisterBus - Behavioral
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

entity RegisterBus is
    Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end RegisterBus;

architecture Behavioral of RegisterBus is 

type tabType is array(15 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
signal tab: tabType := (others=>(others=>'0')) ;

begin
    process(CLK) is
    begin
        if rising_edge(CLK) then
            if RST = '0' then
                tab <= (others=>(others=>'0'));
            elsif W = '1' then
                tab(to_integer(unsigned(aW))) <= DATA;
            end if;
        end if;
    end process;
    
    QA <= tab(to_integer(unsigned(aA))) when W = '0' or aA /= aW else DATA;
    QB <= tab(to_integer(unsigned(aB))) when W = '0' or aB /= aW else DATA;
end Behavioral;
