(
OSCdef(\x, {|msg| ~warp1.set(\pos,d[\l].(msg[1],0,1))}, \x);
OSCdef(\y, {|msg| ~warp1.set(\rate,d[\l].(msg[1],0.5,1.5))}, \y);
OSCdef(\z, {|msg| ~f.set(\v,d[\l].(msg[1],0,1000))}, \z);
)

~sines.stop

(
OSCdef(\x1, {|msg| ~repeat.set(\rel,d[\l].(msg[1],0.01,2))}, \z);
OSCdef(\y1, {|msg| ~warp2.set(\rate,d[\l].(msg[1],0.5,1.5))}, \y1);
OSCdef(\z1, {|msg| ~sinefb.set(\fb,d[\l].(msg[1],0,2))}, \z1);
)

~warp1 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,rate,0.2,-1,8,0,4,0.7))}
~warp2 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,rate,0.2,-1,8,0,4,0.7))}
//Start with Warp instruments

//Build some BPFsaw things in the background

//add very low sine wave

//then add variable feedback sine wave, to which control is added

//build swells around it

//build beats

//start building rhythmic elements around a fundamental frequency and then assignn that fundamental to Charlie, then have him go to town on it

//keeping the sine wave underneath everything means the chaos is *kinda* stabilised.

~bpfsaw = Pbind(\instrument,\bpfsaw,\dur,Pwhite(1,8)/2,\atk,2,\sus,2,\rel,2,\amp,Pwhite(0.1,2),\freq,Pwhite(1,4)*Pkr(~f),\detune,Pexprand(0.0001,1),\lsf,600,\ldb,16)

~sines = {SinOsc.ar([~f,~f+LFNoise1.kr(0.1),~f*2,~f*4],0,0.8)}

~sinefb = {arg f = 2, f2 = 2, fb = 0; SinOscFB.ar([~f*f,~f*f2],fb,0.3)}

OSCdef(\x, {|msg| ~washes.set(\lpf,d[\l].(msg[1],50,10000))}, \x1);
OSCdef(\y, {|msg| ~bass.set(\fb,d[\l].(msg[1],0,2.5));~bass2.set(\fb,d[\l].(msg[1],0,3.5));~bass3.set(\fb,d[\l].(msg[1],0,3.5));~bass4.set(\fb,d[\l].(msg[1],0,3.5));~washes.set(\fb,d[\l].(msg[1],0,4.5));}, \z1);

~k.stop
~woo.stop

~bass4.play

~t2.stop

~wash = {SinOsc.kr(0.9).range(1,1000)}
~washes.set(\lpf,~wash)

~bass4.clear
~washes.play

~sinefb.stop


~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/8,\amp,5,\rate,Pseq([1,2,1,1.5],inf))

~bass4.play


~sn = Pbind(\instrument,\bplay,\buf,d["sn"][0],\dur,0.75,\amp,3)

~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Prand([0.125,0.25],inf).stutter(8),\amp,Pexprand(0.1,1.2))

~t = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pbjorklund2(Pwhite(1,7).asStream,8)/8,\amp,Pexprand(0.7,1.2))

~t2 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pbjorklund2(Pwhite(1,7).asStream,8)/8,\amp,Pexprand(0.7,1.2))

~cp.play

~woo = Pbind(\instrument,\bplay,\buf,d["shout"][1],\dur,4,\amp,1)


~woo.play
~sn.stop

~cp = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Prand([0.75,1],inf),\amp,5,\rate,3)

~cp2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Prand([0.75,1],inf),\amp,5,\rate,2)
~cp2.play

~sinfb.stop(30)

~sines.play

~bpfsaw.stop(5)


~f = {arg v = 50; SinOsc.kr(0,1,v)}



p.clock.tempo = 1.27

~washes = Pbind(\instrument,\sinfb,\dur,Pwhite(4,8),\atk,4,\rel,6,\freq,Prand([[1,4,8],[10,11,12],[3,5,6],[1,1,2]],inf)*Pkr(~f))

~washes.play

~bass = Pbind(\instrument,\sinfb,\dur,Pbjorklund2(3,8)/4,\freq,Pseq([1,1,4,4,2,2,8,8,8,10,10,10,16],inf)*Pkr(~f),\amp,0.6,\fb,1,\rel,2)

~bass3 = Pbind(\instrument,\sinfb,\dur,Pbjorklund2(3,8)/8,\freq,Pseq([10,10,20,20],inf)*Pkr(~f),\amp,1,\fb,1,\rel,2)

~repeat = Pbind(\instrument,\sinfb,\dur,0.125,\fb,Pwhite(0,1.5),\rel,0.8,\freq,Pkr(~f)*16,\amp,Pwhite(0.1,2))

~repeat.play

~bass4.play

~bass2 = Pbind(\instrument,\sinfb,\dur,Pbjorklund2(3,8)/8,\freq,Prand([1,1,4,4,2,2,8,8,10,10],inf)*Pkr(~f),\amp,0.6,\fb,1,\rel,0.1)

~bass4 = Pbind(\instrument,\sinfb,\dur,Pbjorklund2(5,8)/8,\freq,Prand([1,1,4,4,2,2,8,8,10,10],inf)*Pkr(~f),\amp,0.6,\fb,1,\rel,0.1)


~bass4.play

~bass2.play


~warp2.clear

~cp.play


~h.play

~sn.play

~k.play

~sinefb.play

~sines.play

p.fadeTime=3

~f.fadeTime =
~bpfsaw.play

	~f = {50}

~warp2.play


~warp1.stop(20)

~warp2.stop(30)

~warp1.play

~somes = {SinOsc.ar}

~somes.clear

//kill
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
\gsr

/*

TODO:

- Sort out light transfer functions (the minimum doesn't appear to work properly, values aren't retained)

*/


OSCFunc.trace
