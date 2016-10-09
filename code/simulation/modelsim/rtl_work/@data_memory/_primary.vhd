library verilog;
use verilog.vl_types.all;
entity Data_memory is
    port(
        T3_out          : in     vl_logic_vector(15 downto 0);
        edb_in          : in     vl_logic_vector(15 downto 0);
        mem_en          : in     vl_logic;
        mem_wr_en       : in     vl_logic;
        edb_out         : out    vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end Data_memory;
