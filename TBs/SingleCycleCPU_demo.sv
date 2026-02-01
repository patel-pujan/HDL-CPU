// Test bench for Single Cycle CPU - PP version
`timescale 1ns / 10ps


module SingleCycleCPU_demo ();

  /* ---------- */
  /* Parameters */
  /* ---------- */
  parameter int ClockDelay = 1000;
  parameter int NUM_CYCLES = 1000;

  /* ------------- */
  /* Local Signals */
  /* ------------- */
  logic clk;
  logic rst;
  int   cycle_count = 0;

  /* ----------------- */
  /* Device Under Test */
  /* ----------------- */
  SingleCycleCPU cpu (
      .clk_i(clk),
      .rst_i(rst)
  );

  /* ----------- */
  /* Clock Setup */
  /* ----------- */
  initial begin
    clk <= 0;
    forever #(ClockDelay / 2) clk <= ~clk;
  end

  /* ----------- */
  /* TB Stimulus */
  /* ----------- */
  initial begin
    @(posedge clk) rst <= 1'b1;  // assert reset
    @(posedge clk) rst <= 1'b0;  // deassert reset

    while (cycle_count < NUM_CYCLES) begin
      @(posedge clk);
      cycle_count = cycle_count + 1;
    end

    $finish;
  end

endmodule
