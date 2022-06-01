----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 13:08:51
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           C : out STD_LOGIC;
           Z : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is
signal result : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

begin
    process(A, B, Ctrl_Alu)
        begin
            if Ctrl_Alu = "000" then  -- Addition
                result(8 downto 0) <= '0' & A + B ;
                S <= result(7 downto 0);
                C <= result(8);
            elsif Ctrl_Alu = "001" then -- Multiplication
                result <= A * B;
                S <= result(7 downto 0);
                if result > X"00FF" then 
                    O <= '1';
                end if;
            elsif Ctrl_Alu = "010" then -- Soustraction
                S <= A - B ;
                if B > A then
                    N <= '1';
                end if;
            elsif Ctrl_Alu = "011" then -- Division
            end if;
            if result = X"0000" then
                Z <= '1';
            end if;        
        end process;

end Behavioral;
