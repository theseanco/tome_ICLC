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

OSCdef(\key1,{|msg| t.(msg[1],1,2).postln},'/x')