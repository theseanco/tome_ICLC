//Tome ICLC research

//Will be using ypr values
//can't implement this yet.
//also gesture detection?
//this looks complicated at this stage.

//format
(
var prev = 0;
q = { |in|
    var result = in - prev;
    prev = in;
    result;
	result = if ( result < 300, {0},{result});
};
)

(
t = { |in, max = 1, min = 10|
	var result = in.linlin(0,32627,max, min);
	result;
};
)

OSCFunc.trace

OSCdef(\key1,{|msg| d[\wrappedScale].(msg[1]).postln},'/x')

/*

A key feature of this piece could be a set of twelve transfer functions, which are the only things running for the suit, and i change them depending on what is going on. for example:

Start the piece with small light control on the blue spectrum, which is handled by six OSCDefs, and one warp for a sound file, which is control by up to six OSCDefs

Ultimately what is needed here are a 'sound set' and a 'light set' of OSCdefs, which can be re-defined on demand.

I could also have a bunch of different functions which would effect different changes - for example something that would scale the values directly in a linear way, exponential ways, some with modulo calculations which create multiple waves out of a single linear value

This could look something like this

*/

// Left hand light
OSCdef(\x1_Light,{|msg| /* function goes here */ },'/x1');
OSCdef(\y1_Light,{|msg| /* function goes here */ },'/y1');
OSCdef(\z1_Light,{|msg| /* function goes here */ },'/z1');

// Right hand light
OSCdef(\x2_Light,{|msg| /* function goes here */ },'/x2');
OSCdef(\y2_Light,{|msg| /* function goes here */ },'/y2');
OSCdef(\z2_Light,{|msg| /* function goes here */ },'/z2');

// Left hand sound
OSCdef(\x1_Sound,{|msg| /* function goes here */ },'/x1');
OSCdef(\y1_Sound,{|msg| /* function goes here */ },'/y1');
OSCdef(\z1_Sound,{|msg| /* function goes here */ },'/z1');

// Right hand sound
OSCdef(\x2_Sound,{|msg| /* function goes here */ },'/x2');
OSCdef(\y2_Sound,{|msg| /* function goes here */ },'/y2');
OSCdef(\z2_Sound,{|msg| /* function goes here */ },'/z2');

/*

I can keep transfer functions in a dictionary, and i'll need a key at the top of my code file to keep track of them.

can have:

- Linear
- Exponential
- Wrapped
- Wrapped inverse
- Something along the lines of absolute value? - Creating a U-shaped transfer function which can then be linear or exponential?, maybe AbsLinear/AbsExponential?


*/


(
d = Dictionary.new;

//linear transfer function
d[\linear] = { |in, min = 1, max = 10|
	var result = in.linlin(0,32627,min,max);
	result;
};

//exponential transfer function
d[\exponential] = { |in, min = 1, max = 10|
	var result = (in+1).explin(1,32628,min,max);
	result;
};

//what this could do with is a 'number' and a 'scale' version, so that max/min values can be set alongside a number of times over the course of the whole value set
//this can be done by doing a modulo over the entire value
d[\wrapped] = { |in, wrap = 10000, divisor = 10|
	var result = in%wrap;
	result;
};

//wrap contains the number of times the modulo will wrap, min, max dictates scaling of each wrapping
d[\wrappedScale] = { |in, min = 0.0, max = 40.0, wrap = 20|
	var result = in%(32627/wrap);
	result = result.linlin(0,32627/wrap,min,max);
	result;
};

//A u-shape with a variable scale
d[\ushape] = { |in, min = 0, max = 10|
	var result = (in-16313.5).abs;
	result = result.linlin(0,16314,min,max);
}
)

//Next job is to think about what things these transfer functions will need to act upon, and the best type of values for them. Also, having these transfer functions means they can be used for both sound and light.


//MAKE A SELF-REFERENTIAL TRANSFER FUNCTION THAT CAN CHANGE BOTH SOUND AND LIGHT ACCORDING TO VALUE CHANGE
// So that they use exactly the same transfer function but scaled differently automatically, this seems like it's a very good idea.


//d = {|in, scale, min, max| in.linlin(x,x,min,max)}

//d2 = {|in| in

OSCdef(\key1,{|msg| d[\ushape].(msg[1]).postln},'/z')




OSCFunc.trace




d = 0


(
d = d + 1;
e = d % 10;
)


