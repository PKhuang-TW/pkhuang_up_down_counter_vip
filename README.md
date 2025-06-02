This is an UVM vip of up-down counter with reverse bit.

- Functionality:
  - The counter counts up from 0 to 7, then down from 7 to 0, and repeats this pattern.

  - When the `reverse` signal is asserted (set to 1) for 1 clock cycle, the counting direction will toggle (i.e., if currently counting up, it will start counting down, and vice versa).

  - The `reverse` input is active for only ==1 clock cycle== at a time.

- Input:
```typescript=
    logic       clk;
    logic       rst;
    logic       reverse;
```

- Output:
```typescript=
    reg[3:0]    counter;
```


