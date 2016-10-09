library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    port(
        A1              : in     vl_logic_vector(2 downto 0);
        A2              : in     vl_logic_vector(2 downto 0);
        A3              : in     vl_logic_vector(2 downto 0);
        RF1             : out    vl_logic_vector(15 downto 0);
        RF2             : out    vl_logic_vector(15 downto 0);
        RF3             : in     vl_logic_vector(15 downto 0);
        RF4             : in     vl_logic_vector(15 downto 0);
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        rf3_wr_en       : in     vl_logic;
        rf4_wr_en       : in     vl_logic;
        R0              : out    vl_logic_vector(15 downto 0);
        R1              : out    vl_logic_vector(15 downto 0);
        R2              : out    vl_logic_vector(15 downto 0);
        R3              : out    vl_logic_vector(15 downto 0);
        R4              : out    vl_logic_vector(15 downto 0);
        R5              : out    vl_logic_vector(15 downto 0);
        R6              : out    vl_logic_vector(15 downto 0);
        R7              : out    vl_logic_vector(15 downto 0)
    );
end RegisterFile;
