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
	var result = in.linlin(0,1600,max, min);
	result;
};
)

OSCFunc.trace

OSCdef(\key1,{|msg| t.(msg[1],-1,1).postln},'/x')

//Transcribing movements to wavetable

//way 1:

//load an empty buffer, probably only needs to be done once
~buf = Buffer.alloc(s,512,1)
//fill an array with values, this can maybe b done periodically by writing Charlie's movement values to a wavetable?
~array = Array.fill(512,{rrand(-0.1,0.1)});
//Load the entire buffer collection to an indexed buffer on the server
~buf = Buffer.loadCollection(s,~array);
//Play it
{LeakDC.ar(Osc.ar(~buf))}.play;


//make harmonies out of wavetable values which can be moduled through everyone's favourite DFM1 filter.












