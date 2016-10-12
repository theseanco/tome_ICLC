//ICLC Rehearsal 6thOct16

//warp
//saw
//losin
//harmonics
//swells
//beats
//rhythmic sines
//build

//movement functions
(
OSCdef(\x, {|msg| }, \x);
OSCdef(\y, {|msg| }, \y);
OSCdef(\z, {|msg| }, \z);
)

// LIGHT FUNCTIONS
//r
OSCdef(\red,{|msg| b.sendMsg("/r/",d[\l].(msg[1],d[\redmin],d[\redmax]).asInt)},\x1);
//g
OSCdef(\green,{|msg| b.sendMsg("/g/",d[\l].(msg[1],d[\greenmin],d[\greenmax]).asInt)},\y1);
//b
OSCdef(\blue,{|msg| b.sendMsg("/b/",d[\l].(msg[1],d[\bluemin],d[\bluemax]).asInt)},\z1);
//m
OSCdef(\master,{|msg| b.sendMsg("/m/",d[\l].(msg[1],d[\mastermin],d[\mastermax]).asInt)},\z);


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

OSCdef(\x, {|msg|~harm.set(\f,d[\l].(msg[1],1,40).round(4))}, \x);
OSCdef(\y, {|msg|~harm.set(\f2,d[\l].(msg[1],1,40).round(4))}, \y);

OSCdef(\v, {|msg|~f.set(\v,d[\l].(msg[1],50,2000))}, \z);

~warp1 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,rate,0.2,-1,8,0,4,1))}
~warp2 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,rate,0.2,-1,8,0,4,1))}

OSCdef(\x1, {|msg| ~warp2.set(\pos,d[\l].(msg[1],0,1))}, \x1);
OSCdef(\y1, {|msg| ~warp2.set(\rate,d[\l].(msg[1],0.5,5.5))}, \y1);

OSCdef(\z1, {|msg| ~bass.set(\fb,d[\l].(msg[1],0,8.7));~bass2.set(\fb,d[\l].(msg[1],0,8.8));~bass3.set(\fb,d[\l].(msg[1],0,8.8))}, \z1);

~warp2.stop(50)

~warp2.stop

~warp1.stop

p.fadeTime=3

~f = {50}

~f.fadeTime= 0

~bpf = Pbind(\instrument,\bpfsaw,\dur,Pwhite(1,4),\atk,3,\sus,3,\rel,3,\freq,Pwhite(1,6)/2*Pkr(~f),\lsf,600,\ldb,16,\amp,Pwhite(0.3,0.8))


~sines = {SinOsc.ar([~f,~f+LFNoise1.kr(0.1),~f*2,~f*4],0,0.5)}

~harm = {arg f = 2, f2 = 2, fb = 0; SinOscFB.ar([~f*f,~f*f2],fb,0.5)}

~harm.play

p.fadeTime=3

~sines.play

p.clock.tempo = 1.17

~kick = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/8,\amp,5,\rate,Pseq([1,2,1,1.5],inf))

p.clock.tempo=1.6

~kick.clear
~sn.stop
~c.stop

~sn = Pbind(\instrument,\bplay,\buf,d["sn"][0],\dur,0.5,\amp,4)

~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,3)
~c.play

~kick.play
~h.play

~h.play

~h = Pbind(\instrument,\bplay,\buf,d["h"][0],\dur,0.125,\amp,Pwhite(0.1,2),\rate,Pwhite(0.9,1.5))

~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Prand([0.25,0.125],inf).stutter(8),\amp,Pwhite(0.1,3),\rate,Pwhite(1,4.0))

~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Prand([0.25,0.125],inf).stutter(8),\amp,Pwhite(0.1,5),\rate,Pwhite(1,4.0))


~t2.play

~f = {arg v = 50; SinOsc.kr(0,1,v)}

~f.fadeTime= 10

~harm.stop(20)

~bpf.stop(5)

~bass3 = Pbind(\instrument,\sinfb,\freq,Prand([[1,2,4],[2,4,8],[8,5,4]],inf)*Pkr(~f),\dur,Pwhite(1,4),\fb,0.1,\rel,2,\atk,2,\amp,1)

~bass3.play

~bass = Pbind(\instrument,\sinfb,\freq,Pwhite(1,8)*Pkr(~f),\dur,Pwhite(0.25,1).round(0.25),\fb,0.1,\rel,0.4,\amp,1)

~bass2 = Pbind(\instrument,\sinfb,\freq,Pwhite(1,8)*Pkr(~f),\dur,Pwhite(0.25,1).round(0.25),\fb,0.1,\rel,0.4,\amp,1)

~bass2.play

~bass.play

~h.play

~sn.play

~kick.play



	~bpf.play







///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
(
OSCFunc({|msg| if (msg[1] == 1023, {OSCdef(\red,{b.sendMsg("/r/",0)},\x);
OSCdef(\green,{b.sendMsg("/g/",0)},\x);
OSCdef(\blue,{b.sendMsg("/b/",0)},\x);
OSCdef(\master,{b.sendMsg("/m/",0)},\x);
Server.freeAll;
b.sendMsg("/r/",0);
b.sendMsg("/g/",0);
b.sendMsg("/b/",0);
b.sendMsg("/b/",0);})},\gsr)
)
