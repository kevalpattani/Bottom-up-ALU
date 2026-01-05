# Bottom-up-ALU

This 32-bit Bottom Up ALU features Carry Look Ahead Adder, Booth Alogorithm based multiplier, Non-Restoring Algorithm based Divisor, Funnel Shifter and Rotate Shifter 

## Specifications
- **Carry for sum and sub** : Carry is provided for addition and subtraction as the 32nd bit in the output and also as external carry signal. 
- **Carry for division** : Division carry defines the arithmetic sign (negative or positive) of the resulting output.
- **Signed vs Unsigned** : Addition and Subtractions are _Unsigned_ but Division and Multiplication are _Signed_.

But if signed operations are to be performed for please note this,

|Condition |Opcodes |Sequence| 
|----------|--------|--------|
|Both inputs are signed and positive | 1 x `000` | ADD | 
|Both inputs are signed where one is negative and other is positive | 1 x `001` | positive should be connected to input a and negative should be input b |
|Both inputs are signed and negative | 2 x `001` --> 1 x `000` | `input a` of the both the `SUB (001)` should be 0 and B should be the negative inputs and then the result of those SUB operations should inputs of ADD |

## Notes 

- **ADD** : Adder is developed with Carry Lookahead adder design where the design works on a hierarchical level of CLA_C_Process and CLA_block_4bit, 8 blocks of CLA_block_4bit works instantly to generate sum. To calculate carry hierarchical design of CLA_C_Process helps in calculation of carry for all the bits and it is mainly used to reduce the amount of expressions to write for the lasts bits.
  
- **MUL** : Booth Algorithm is used for multiplication, at first all the input are checked to find `M`, `Q`, `Q(-1)`. where `M` is a negative signed input, for this algorithm both signed input can be negative or both can be positive, after that 32 block of booth_checker is generated using generate block. Intitally `Q(-1)` and `A` will be zero, if the last bit (LSB) of the `Q` and `Q(-1)` opposite in value then an operatioon will be performed where if `Q[0] == 0` and `Q(-1) == 1` then `A + M = A` and if `Q[0] == 1` and `Q(-1) == 0` then `A - M = A`, all of this arithmetic operations are performed using **ADD**, after operation on `A` is performed on `A` then `A` is _shifted to right_ by one bit using `arithmetic shift on signed number` and the overflowed bit is replaced with `Q`'s first bit so `Q` is shifted and the overflowed bit is the new `Q(-1)`. This process is repeated 32 times and then the final output is `output == A_Q`.

- **DIV** : For division Non-restroing algorithm is used, intially all the inputs are converted into positive unsigned numbers using if else statements. Input _A is Dividend_ and Input _B is Divisor_. Divisor module has a separate module called non_restoring_block for the calculations where there are three inputs `M` `Q`, `M` is _input B_, initially `A` and `Q(-1)` are zero, `A` is shifted to to right side and if the shifted `A`'s first bit is `0` then `A - M = A` and if its `1` then `A + M = A` and the vacated bit is filled with the first bit of `Q` which results in the right shift of `Q` and then the vacated bit of `Q` is filled with either `0` or `1` depending on shifted `A` if the `new A's` first bit `1` then vacated `Q`'s last bit is filled with `0` and if `A`'s first bit `0` then `Q`'s last bit is filled with `1`. This process is repeated 32 times using generate block, and last `Q`'s value is remainder, if the final `A`'s first bit s value is `1` then _input a_ is added to `A` and if `A`'s first bit s value is `0` then no change in `A`. so `A` will be the remainder and `Q` will be quotient.

- **Funnel Shift** : The bits of the side of the shift are shifted and the same amount of bits from the other side is droped and filled with zeros.

- **Rotate Shift** : The input is rotated according to the signal given using shift.

## Opcodes

|Operation |Opcode |Description |
|----|----|-----|
|ADD(+) |000 |a + b |
|SUB(-) |001 |a - b |
|MUL(x) |002 |a x b |
|DIV(/) |003 |a / b |
|FLS(F<)|004 |{a,b} shifted to _left_ using signal called shift and vacated bits filled with zeros|
|FLS(F>)|005 |{a,b} shifted to _right_ using signal called shift and vacated bits filled with zeros|
|RLS(R<)|006 |{a,b} rotated to _left_ using signal called shift|
|RRS(R>)|007 |{a,b} rotated to _right_ using signal called shift|




