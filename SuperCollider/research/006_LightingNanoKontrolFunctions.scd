//get a function for knobs, which grabs the knob values as local ones and sets them to an OSCdrf
(


//RED - WORKING
(
c.knobs[..1].do {|knob, i, val1 = 0, val2 = 255|
    knob.onChanged = {|val|
		if ( i == 0, {
			"redmin = ".post;
			val1 = val.linlin(0,127,0,255).asInt.postln;
		},{
			"redmax = ".post;
			val2 = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\red,{|msg| b.sendMsg("/r/",d[\l].(msg[1],val1,val2).asInt)},\x);
};
);

//green - working
(
c.knobs[2..3].do {|knob, i, val3 = 0, val4 = 255|
    knob.onChanged = {|val|
		if ( i == 0 ,{
			"greenmin = ".post;
			val3 = val.linlin(0,127,0,255).asInt.postln;
		},{
			"greenmax = ".post;
			val4 = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\green,{|msg| b.sendMsg("/g/",d[\l].(msg[1],val3,val4).asInt)},\y);
};
);

//blue - working
(
c.knobs[4..5].do {|knob, i, val5 = 0, val6 = 255|
    knob.onChanged = {|val|
		if ( i == 0 ,{
			"bluemin = ".post;
			val5 = val.linlin(0,127,0,255).asInt.postln;
		},{
			"bluemax = ".post;
			val6 = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\blue,{|msg| b.sendMsg("/b/",d[\l].(msg[1],val5,val6).asInt)},\x);
};
);

//master - working
(
c.knobs[6..7].do {|knob, i, val7 = 0, val8 = 255|
    knob.onChanged = {|val|
		if ( i == 0 ,{
			"mastermin = ".post;
			val7 = val.linlin(0,127,0,255).asInt.postln;
		},{
			"mastermax = ".post;
			val8 = val.linlin(0,127,0,255).asInt.postln;
		});
    };
	OSCdef(\master,{|msg| b.sendMsg("/m/",d[\l].(msg[1],val7,val8).asInt)},\z);
};
)

)