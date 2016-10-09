library verilog;
use verilog.vl_types.all;
entity forwarding_unit is
    port(
        reg_efct_RE     : in     vl_logic_vector(2 downto 0);
        reg_efct_EM     : in     vl_logic_vector(2 downto 0);
        reg_efct_MW     : in     vl_logic_vector(2 downto 0);
        flush_RE        : in     vl_logic;
        flush_EM        : in     vl_logic;
        flush_MW        : in     vl_logic;
        load_EM         : in     vl_logic;
        load_MW         : in     vl_logic;
        store_RE        : in     vl_logic;
        Rs1_RE          : in     vl_logic_vector(2 downto 0);
        Rs2_RE          : in     vl_logic_vector(2 downto 0);
        Rd_EM           : in     vl_logic_vector(2 downto 0);
        Rd_MW           : in     vl_logic_vector(2 downto 0);
        forward_muxA_ctrl: out    vl_logic_vector(1 downto 0);
        forward_muxB_ctrl: out    vl_logic_vector(1 downto 0);
        T2_dash_ctrl    : out    vl_logic
    );
end forwarding_unit;
