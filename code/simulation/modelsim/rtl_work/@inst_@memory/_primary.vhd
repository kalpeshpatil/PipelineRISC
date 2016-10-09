library verilog;
use verilog.vl_types.all;
entity Inst_Memory is
    port(
        PC_Out          : in     vl_logic_vector(15 downto 0);
        IR_FD_in        : out    vl_logic_vector(15 downto 0)
    );
end Inst_Memory;
