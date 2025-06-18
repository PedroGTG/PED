library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ula is
end tb_ula;

architecture sim of tb_ula is
    component ula
    port (
        a      : in  std_logic_vector(3 downto 0);
        b      : in  std_logic_vector(3 downto 0);
        ss     : in  std_logic_vector(1 downto 0);
        f      : out std_logic_vector(3 downto 0);
        over   : out std_logic;
        c_out  : out std_logic
    );
    end component;

    signal a      : std_logic_vector(3 downto 0) := "0000";
    signal b      : std_logic_vector(3 downto 0) := "0000";
    signal ss     : std_logic_vector(1 downto 0) := "00";
    signal f      : std_logic_vector(3 downto 0);
    signal over   : std_logic;
    signal c_out  : std_logic;

    signal clk    : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

    uut: ula port map (
        a => a,
        b => b,
        ss => ss,
        f => f,
        over => over,
        c_out => c_out
    );

    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        wait for 100 ns;

        --(3 + 5)
        a <= "0011"; b <= "0101"; ss <= "00";
        wait for 20 ns;

        --(5 - 3)
        a <= "0101"; b <= "0011"; ss <= "01";
        wait for 20 ns;

        --and
        a <= "1100"; b <= "1010"; ss <= "10";
        wait for 20 ns;

        --or
        a <= "1100"; b <= "1010"; ss <= "11";
        wait for 20 ns;

        --overflow
        a <= "0111"; b <= "0100"; ss <= "00";
        wait for 20 ns;

        wait;
    end process;

end sim;
