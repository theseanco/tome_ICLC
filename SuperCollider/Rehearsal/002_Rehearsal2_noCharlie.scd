//Start with Warp instruments

//Build some BPFsaw things in the background

//add very low sine wave

//then add variable feedback sine wave, to which control is added

//build swells around it

//build beats

//start building rhythmic elements around a fundamental frequency and then assignn that fundamental to Charlie, then have him go to town on it

//keeping the sine wave underneath everything means the chaos is *kinda* stabilised.

///SOUND
(
OSCdef(\x, {|msg| }, \x);
OSCdef(\y, {|msg| }, \y);
OSCdef(\z, {|msg| }, \z);
)

(
OSCdef(\x1, {|msg| }, \x1);
OSCdef(\y1, {|msg| }, \y1);
OSCdef(\z1, {|msg| }, \z1);
)

(
///LIGHT
OSCdef(\xL, {|msg| }, \x);
OSCdef(\yL, {|msg| }, \y);
OSCdef(\zL, {|msg| }, \z);
)

(
OSCdef(\x1L, {|msg| b.sendMsg("/r/",190)}, \x1);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",20)}, \y1);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",10)}, \z1);
)

~warp1 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],LFNoise1.kr(0.6),rate,0.2,-1,8,0.01,4,0.5))}

~warp3 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],LFNoise1.kr(0.6),rate,0.2,-1,8,0.01,4,0.5))}


OSCdef(\x, {|msg| ~warp1.set(\pos,d[\linear].(msg[1],0,1)) }, \x);
OSCdef(\y, {|msg| ~warp1.set(\rate,d[\linear].(msg[1],0.5,1.5))}, \y);


OSCdef(\x1, {|msg| ~warp3.set(\pos,d[\linear].(msg[1],0,1)) }, \x1);
OSCdef(\y1, {|msg| ~warp3.set(\rate,d[\linear].(msg[1],0.5,1.5))}, \y1);


(
OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\linear].(msg[1],100,200).asInt)}, \x);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",d[\linear].(msg[1],20,250))}, \y);
OSCdef(\zL, {|msg| b.sendMsg("/b/",d[\linear].(msg[1],20,255))}, \z);
OSCdef(\z1L, {|msg| b.sendMsg("/m/",d[\linear].(msg[1],0,255))}, \z1);
)

~f = 50

~saw = Pbind(\instrument,\bpfsaw,\dur,Pwhite(0.25,2).round(0.25),\freq,(Pexprand(1,10).round(1)*Pkr(~f))/2,\amp,Pwhite(0.5,1),\lsf,400,\ldb,15,\detune,Pexprand(0.01,0.7),\atk,2,\sus,2,\rel,3)

~sines = {SinOsc.ar([~f+LFNoise1.kr(0.1,2),~f+LFNoise1.kr(0.1,2),~f*2,~f*4],0,0.5)}

~sines.play

~sinesfb = {arg f = 2, f2 = 2; SinOscFB.ar([LFNoise1.kr(1).range(1,20).round(2)*~f,LFNoise1.kr(1).range(1,10).round(1)*~f],SinOsc.kr(0.1).range(0.1,1),0.6)}

~f = {SinOsc.kr(LFNoise1.kr(0.1).range(0.1,79.5)).range(0.0000001,1502)}

~saw.stop

~sinesfb.play


~warp2.stop(40)

OSCdef(\x, {|msg| ~sinesfb.set(\f,d[\linear].(msg[1],1,5).asInt) }, \x);
OSCdef(\y, {|msg| ~sinesfb.set(\f2,d[\linear].(msg[1],1,5))}, \z);

OSCdef(\z1, {|msg| ~sinesfb.set(\fb,d[\linear].(msg[1],0,2))}, \z);

p.fadeTime=4

~sinesfb.stop(30)


~kick = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(3,8)/8,\amp,8,\rate,Pseq([1,1.5,1,2],inf))

~sn = Pbind(\instrument,\bplay,\buf,d["sn"][2],\dur,Pwhite(2,6).round(2),\amp,2)

~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,8)/Pwhite(4,8).round(4).stutter(5),\amp,9)

~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(3,8)/Pwhite(4,16).round(4).stutter(12),\amp,9,\rate,2)

~t3 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pwhite(0.25,1).round(0.25),\amp,9,\rate,4)

~t3.play

~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,0.125,\amp,2)

~clp = Pbind(\instrument,\bplay,\buf,d["c"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf)/2,\amp,5)
~clp2 = Pbind(\instrument,\bplay,\buf,d["c"][2],\dur,Pseq([1,0.75],inf),\amp,2)

~rd = Pbind(\instrument,\bplay,\buf,d["rd"][0],\dur,Pseq([0.5,Pseq([1],inf)],inf)/2,\amp,5)

~rd.play


~clp2.play

~fbbass = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*[4,8,16,32,2],\dur,Pbjorklund2(3,8)/8,\amp,2,\rel,Pwhite(0.05,0.5),\fb,Pwhite(0.1,8.4))


~fbbass2 = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*Pwhite(4,32).round(2).stutter(20),\dur,Pwhite(0.125,0.5).round(0.125),\amp,Pwhite(1,8.0),\rel,Pwhite(0.05,0.1),\fb,Pwhite(0.1,2.4))

~fbbass2.play

~fbbass.play

p.clock.tempo=1.39

~h.play

~sn.play

~kick.play

(
CmdPeriod.run;
~ork = Pbind(\instrument,\bplay,\buf,d["ork"][0],\dur,2,\amp,5,\rate,Pseq([1,1.2],inf));
~ork.play;
)

~ork.clear

~t.stop

~sines.stop



~ork.play

~saw.play


~warp1.stop(20)
~warp1.play



