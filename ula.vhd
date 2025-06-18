library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port (
        a      : in  std_logic_vector(3 downto 0);
        b      : in  std_logic_vector(3 downto 0);
        ss     : in  std_logic_vector(1 downto 0);
        f      : out std_logic_vector(3 downto 0);
        over   : out std_logic;
        c_out  : out std_logic
    );
end ula;

architecture behavioral of ula is
    signal a_signed, b_signed : signed(3 downto 0);
    signal result             : signed(4 downto 0);
    signal f_temp             : std_logic_vector(3 downto 0);
    signal over_temp          : std_logic;
    signal c_out_temp         : std_logic;
begin
    a_signed <= signed(a);
    b_signed <= signed(b);
    
    process (a_signed, b_signed, ss)
    begin
        case ss is
            when "00" =>  -- add
                result <= ('0' & a_signed) + ('0' & b_signed);
                f_temp <= std_logic_vector(result(3 downto 0));
                if (a_signed(3) = b_signed(3)) and (a_signed(3) /= result(3)) then
                    over_temp <= '1';
                else
                    over_temp <= '0';
                end if;
                c_out_temp <= result(4);
                
            when "01" =>  -- sub
                result <= ('0' & a_signed) - ('0' & b_signed);
                f_temp <= std_logic_vector(result(3 downto 0));
                if (a_signed(3) /= b_signed(3)) and (a_signed(3) /= result(3)) then
                    over_temp <= '1';
                else
                    over_temp <= '0';
                end if;
                c_out_temp <= result(4);
                
            when "10" =>  -- e
                f_temp <= a and b;
                over_temp <= 'X';
                c_out_temp <= 'X';
                
            when "11" =>  -- ou
                f_temp <= a or b;
                over_temp <= 'X';
                c_out_temp <= 'X';
                
            when others =>
                f_temp <= (others => '0');
                over_temp <= '0';
                c_out_temp <= '0';
        end case;
    end process;
    
    f     <= not f_temp;
    over  <= not over_temp;
    c_out <= not c_out_temp;
    
end behavioral;