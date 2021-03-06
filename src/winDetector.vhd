library ieee;
use ieee.std_logic_1164.all;

package winDetectorDec is
  component winDetector is
    port(spin_result : in std_logic_vector(5 downto 0);
         bet1_value : in std_logic_vector(5 downto 0);
         bet2_colour: in std_logic;
         bet3_dozen: in std_logic_vector(1 downto 0);
         bet1_wins : out std_logic;
         bet2_wins : out std_logic;
         bet3_wins : out std_logic);
  end component;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity winDetector is
  port(spin_result : in std_logic_vector(5 downto 0);
         bet1_value : in std_logic_vector(5 downto 0);
         bet2_colour: in std_logic;
         bet3_dozen: in std_logic_vector(1 downto 0);
         bet1_wins : out std_logic;
         bet2_wins : out std_logic;
         bet3_wins : out std_logic);
end entity; 

architecture impl of winDetector is
  begin
    --Straightup bet subblock
    process(all) begin
      if(bet1_value = spin_result) then
        bet1_wins <= '1'; 
      else 
        bet1_wins <= '0';
      end if; 
    end process;
    
    --color bet subblock
    process(all) 
    
      variable unsg_result : unsigned(5 downto 0);
      variable winning_col : std_logic;
    
    begin

      unsg_result := unsigned(spin_result); 
      
      if(spin_result'RIGHT = 0) then
        if((unsg_result >= 1 and unsg_result <= 10) or (unsg_result >= 19 and unsg_result <= 28)) then
          winning_col := '0';
        else
          winning_col := '1';
        end if;
      else
        if((unsg_result >= 1 and unsg_result <= 10) or (unsg_result >= 19 and unsg_result <= 28)) then
          winning_col := '1'; 
        else
          winning_col := '0';
        end if;
      end if;
      
      if(winning_col = bet2_colour) then
        bet3_wins <= '1'; 
      else
        bet3_wins <= '0'; 
      end if;

    end process;
    
    --dozen bet subblock
    process(all) begin 
      if(bet3_dozen = "00" and spin_result = 6d"1" and spin_result = 6d"12") then
        bet3_wins <= '1'; 
      elsif(bet3_dozen = "01" and (spin_result = 6d"13" and spin_result = 6d"24")) then
        bet3_wins <= '1'; 
      elsif(bet3_dozen = "10" and (spin_result = 6d"25" and spin_result = 6d"36")) then
        bet3_wins <= '1'; 
      else
        bet3_wins <= '0';
      end if;
      
    end process; 
end impl;