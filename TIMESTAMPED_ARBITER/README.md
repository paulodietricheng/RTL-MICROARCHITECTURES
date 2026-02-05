# Timestamped Arbiter

This module will accept parallel inputs and, between the valid inputs, it will select the oldest input (smaller timestamp). In the case of a tie between two inputs, it will arbitrarely select the input with the
highest index. 

## Key features

 - Totaly parametrizable for power-of-2 widths.
 - Implements a selection tree, scalling as O(log2N).

Two architectures were made. One purely combinational, and another fully pipelined. 

## Purely combinational (DATA_W = 16, N = 8, TIMESTAMP_W = 16)

The minimum latency in this design is one cycle at 117 MHz, generating a time latency of 8.5ns. However, it quickly broke when trying to scale the size of the comparator.

## Pipelined(DATA_W = 16, N = 8, TIMESTAMP_W = 16)

The minimum latency in this design is 3 cyles at 227 MHz, generating a time latency of 13ns. However, the throughput increased in over 5 times. 

