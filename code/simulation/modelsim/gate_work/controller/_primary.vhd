library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        PC_mux_ctrl     : out    vl_logic_vector(2 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic
    );
end controller;
