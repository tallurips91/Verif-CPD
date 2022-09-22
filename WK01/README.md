# Gray to Binary Convertor

Design was given by the Lecturer, Testbench was too be designed.

Design Saved on EDA Playground
https://www.edaplayground.com/x/CbRG

```
design.sv    - Has the design module
testbench.sv - Has the TB module
```

- Stimulus is generated using a for loop
- Stimulus is driven on every negitive clock edge 
- Result checking is done on every positive clock by triggering an event (check_result_event)
- The event runs a task (check_result) 
- The task computes expected binary output using a function (binary_expected) 
- The comparission is made after 2ns after the positive clock, so that right value of output binary number from design (bin_out_tb) is read

The design has a bug in 
`bin_out[0] <= gray_in[3] ^ **gray_in[3]** ^ gray_in[1] ^ gray_in[0]; `
