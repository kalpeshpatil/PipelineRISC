library verilog;
use verilog.vl_types.all;
entity ALU1 is
    generic(
        nop             : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        add             : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        comp            : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        nan             : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        In_ALU_opcode   : in     vl_logic_vector(5 downto 0);
        In_ALUA_data    : in     vl_logic_vector(15 downto 0);
        In_ALUB_data    : in     vl_logic_vector(15 downto 0);
        Out_ALU_CFlag   : out    vl_logic;
        Out_ALU_ZFlag   : out    vl_logic;
        Out_ALU_result  : out    vl_logic_vector(15 downto 0);
        In_reset        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of nop : constant is 1;
    attribute mti_svvh_generic_type of add : constant is 1;
    attribute mti_svvh_generic_type of comp : constant is 1;
    attribute mti_svvh_generic_type of nan : constant is 1;
end ALU1;
