/*
The circuits so far have been simple enough that the outputs are simple functions of the inputs. As circuits become more complex, you will need wires to connect internal components together. 
When you need to use a wire, you should declare it in the body of the module, somewhere before it is first used. 
(In the future, you will encounter more types of signals and variables that are also declared the same way, but for now, we'll start with a signal of type wire).

Implement the following circuit. Create two intermediate wires (named anything you want) to connect the AND and OR gates together. Note that the wire that feeds the NOT gate is really wire out, so you do not necessarily need to declare a third wire here. Notice how wires are driven by exactly one source (output of a gate), but can feed multiple inputs.

If you're following the circuit structure in the diagram, you should end up with four assign statements, as there are four signals that need a value assigned.

(Yes, it is possible to create a circuit with the same functionality without the intermediate wires.)

Expected solution length: Around 5 lines.
*/
`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n  ); 
	
    wire w1, w2;
    and a1 (w1, a, b);
    and a2 (w2, c, d);
    or o1 (out, w1, w2);
    not n1 (out_n, out);
    
endmodule
