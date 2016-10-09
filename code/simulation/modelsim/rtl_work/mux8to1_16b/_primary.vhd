library verilog;
use verilog.vl_types.all;
entity mux8to1_16b is
    port(
        ip0             : in     vl_logic_vector(15 downto 0);
        ip1             : in     vl_logic_vector(15 downto 0);
        ip2             : in     vl_logic_vector(15 downto 0);
        ip3             : in     vl_logic_vector(15 downto 0);
        ip4             : in     vl_logic_vector(15 downto 0);
        ip5             : in     vl_logic_vector(15 downto 0);
        ip6             : in     vl_logic_vector(15 downto 0);
        ip7             : in     vl_logic_vector(15 downto 0);
        ctrl_sig        : in     vl_logic_vector(2 downto 0);
        op              : out    vl_logic_vector(15 downto 0)
    );
end mux8to1_16b;
