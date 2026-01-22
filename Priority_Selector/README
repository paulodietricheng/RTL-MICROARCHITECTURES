# Priority Selector
A priority selector is a hardware module that chooses one input from a set of multiple inputs based on a fixed priority. Each input has two signals: Data and Valid.
Data is the actual payload of an input, and valid is a flag that indicates whether that payoad is meaningful or not. 

It works by analysing all `N` inputs simultaneously, and amongst the inputs with `valid = 1`, it selects the one with the highest priority (lowest index). It outputs 
the data of the selected input, the index of that input and the valid flag. 

Key characteristics of this module is: 
  - Parametrizable, scaling to any number of inputs `N` and data width `DATA_W`
  - Deterministic, always producing the same output to the same set of inputs.
  - Scalable, implemented as a logarithmic-depth reduction tree, so the number of comparison stages grows as O(log2 N).

Use cases:
  - Arbitration between multiple streams in FPGA trading pipelines
  - Selecting the first ready input in multi-source processing
  - Any system that needs low-latency decision making based on input validity

## Architecture

The design is based on a reduction tree, grouping the inputs in pairs and then assigning a winner. This module is called STAGE. Then, it propagates its `index`, 
`data` and `valid` to the next stage, to realize the comparision again.

It was designed in two versions, one fully pipelined, with registers at input, output and between each stage, and one mostly combnational, with registers only at input and output.

### Comparision (`N = 8`, `DATA_W = 16`)
Pipelined Version: 
  - f_max: 392MHz
  - Throughput: 392 MRPS
  - Latency: 3 cycles at 392MHz

Combinational Version:
  - f_max: 315MHz
  - Throughput: 315 MRPS
  - Latency: 1 cycle at 315MHz

It is possible to observe that the combinational version runs on a slower maximum frequency by 19.64% and it has a throughput 19.64% smaller, but the latency has improved 
in over 58%. 


  
