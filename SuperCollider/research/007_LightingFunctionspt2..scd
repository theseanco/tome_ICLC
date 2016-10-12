//get a function for knobs, which grabs the knob values as local ones and sets them to an OSCdrf
(


//RED - on-the-fly assignment of responders is not working correctly - d[\redindex] will not follow the assigned dictionary variable until it is executed again (shift+entered). Not sure why this is the case.
(
c.knobs[..1].do {|knob, i, index|
    knob.onChanged = {|val|
		if ( i == 0, {
			"redmin = ".post;
			d[\redmin] = val.linlin(0,127,0,255).asInt.postln;
		},{
			"redmax = ".post;
			d[\redmax] = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	index = d[\redindex];
	OSCdef(\red,{|msg| b.sendMsg("/r/",d[\l].(msg[1],d[\redmin],d[\redmax]).asInt)},\x);
};
);


//green - working
(
c.knobs[2..3].do {|knob, i|
    knob.onChanged = {|val|
		if ( i == 0 ,{
			"greenmin = ".post;
			d[\greenmin] = val.linlin(0,127,0,255).asInt.postln;
		},{
			"greenmax = ".post;
			d[\greenmax] = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\green,{|msg| b.sendMsg("/g/",d[\l].(msg[1],d[\greenmin],d[\greenmax]).asInt)},\y);
};
);

//blue - working
(
c.knobs[4..5].do {|knob, i|
    knob.onChanged = {|val|
		if ( i == 0 ,{
			"bluemin = ".post;
			d[\bluemin] = val.linlin(0,127,0,255).asInt.postln;
		},{
			"bluemax = ".post;
			d[\bluemax] = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\blue,{|msg| b.sendMsg("/b/",d[\l].(msg[1],d[\bluemin],d[\bluemax]).asInt)},\x1);
};
);

//master - working
(c.knobs[6..7].do {|knob, i|
    knob.onChanged = {|val|
		if ( i == 0 ,{
			"mastermin = ".post;
			d[\mastermin] = val.linlin(0,127,0,255).asInt.postln;
		},{
			"mastermax = ".post;
			d[\mastermax] = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\master,{|msg| b.sendMsg("/m/",d[\l].(msg[1],d[\mastermin],d[\mastermax]).asInt)},\x);
};
)

)