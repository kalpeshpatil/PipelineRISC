library verilog;
use verilog.vl_types.all;
entity se97_16 is
    port(
        \in\            : in     vl_logic_vector(8 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end se97_16;
