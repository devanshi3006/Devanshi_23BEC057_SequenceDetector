# RTL TO GDSII: SEQUENCE DETECTOR 110
## INTRODUCTION:
A sequence detector in digital electronics is a circuit that generates an output signal when a specific sequence of input bits is detected.For combinational designs, the output value completely depends on the present value of the inputs and for sequential designs, output value not only depends on present input but also depends on its previously stored value i.e. past behavior of the design. These sequential designs are formally knowns as finite-state machines that have a fixed number of states.
                                                     ![image](https://github.com/user-attachments/assets/9ccd4b92-4cb2-42e7-9027-08aec69b2271)

Both Mealy and Moore machines can be used to design sequence detector logic. Further, these machines are classified as:
1. Overlapping sequence detector – Final bits of the sequence can be the start of another sequence. Thus, it allows overlap.
2. Non-overlapping sequence detector – Once sequence detection is completed, another sequence detection can be started without any overlap.
   ![image](https://github.com/user-attachments/assets/5109a3cd-937b-4a6d-b6a0-746fc4ff92c4)

## ENVIRONMENT 
**ROCKY LINUX**: The operating system environment in which Synopsys tools are employed
## TOOLS USED
**VERILOG HDL**: The RTL of the sequence detector was designed using the Hardware Description Language.

**Synopsys VCS**: Combines and models  RTL-level Verilog code

**Verdi**: Waveform viewer for debugging simulation results

****


