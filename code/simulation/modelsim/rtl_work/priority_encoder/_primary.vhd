library verilog;
use verilog.vl_types.all;
entity priority_encoder is
    port(
        enable          : in     vl_logic;
        inData          : in     vl_logic_vector(8 downto 0);
        vbit            : out    vl_logic;
        outAddr         : out    vl_logic_vector(2 downto 0);
        temp            : out    vl_logic_vector(8 downto 0)
    );
end priority_encoder;
