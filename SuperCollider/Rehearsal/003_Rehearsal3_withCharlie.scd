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
OSCdef(\x1L, {|msg| b.sendMsg("/r/",0)}, \x1);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",0)}, \y1);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",0)}, \z1);
)


//Start with Warp instruments

//Build some BPFsaw things in the background

//add very low sine wave

//then add variable feedback sine wave, to which control is added

//build swells around it

//build beats

//start building rhythmic elements around a fundamental frequency and then assignn that fundamental to Charlie, then have him go to town on it

//keeping the sine wave underneath everything means the chaos is *kinda* stabilised.

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
OSCdef(\x1L, {|msg| b.sendMsg("/r/",0)}, \x1);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",0)}, \y1);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",0)}, \z1);
)

~warp1 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,rate,0.2,-1,8,0,4,1))}
~warp2 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,rate,0.2,-1,8,0,4,1))}

p.fadeTime=3

~warp1.play

~warp2.play

(
OSCdef(\x, {|msg| ~warp1.set(\pos,d[\l].(msg[1],0,1))}, \x);
OSCdef(\y, {|msg| ~sinefb.set(\f,d[\l].(msg[1],1,20).round(2).asInt)}, \y);
OSCdef(\z, {|msg| ~sinefb.set(\f2,d[\l].(msg[1],1,20).round(2).asInt)}, \z);

OSCdef(\z1, {|msg| ~sinefb.set(\fb,d[\l].(msg[1],0,4))}, \z1);

~warp2.stop(30)


OSCdef(\x1, {|msg| ~warp2.set(\pos,d[\l].(msg[1],0,1))}, \x1);
OSCdef(\y1, {|msg| ~warp2.set(\rate,d[\l].(msg[1],0.5,5.5))}, \y1);

OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\l].(msg[1],250,250).asInt)}, \x);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",d[\l].(msg[1],150,250).asInt)}, \y);

OSCdef(\x2L, {|msg| b.sendMsg("/m/",d[\l].(msg[1],150,250).asInt)}, \z);
OSCdef(\z2L, {|msg| b.sendMsg("/m/",d[\l].(msg[1],255,255).asInt)}, \z1);

~sinefb.stop(40)

~f = {arg val = 1000; SinOsc.ar(0,1,val)}


~f = {arg val = 50; SinOsc.kr(0,1,val)}


~bpfsaw = Pbind(\instrument,\bpfsaw,\atk,2,\sus,2,\rel,2,\dur,Pwhite(0.5,2),\freq,(Pwhite(1,8)*Pkr(~f))/2,\lsf,500,\ldb,16,\amp,Pwhite(0.3,1.2),\detune,Pexprand(0.01,1))

~sines = {SinOsc.ar([~f+LFNoise1.kr(0.1,0.3),~f+LFNoise1.kr(0.1,0.3),~f*2,~f*4],0,0.4)}

~sines.play

~sinefb = {arg f = 2, f2 = 2, fb = 0; SinOscFB.ar([~f*LFNoise1.kr(0.1).range(1,10).round(1),~f*LFNoise1.kr(0.1).range(1,10).round(1)],SinOsc.kr(0.1).range(0.1,1.3),0.5)}

~k.stop

~sinefb.play

~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,2,\dur,Pbjorklund2(3,8)/8,\amp,9,\rate,Pseq([1,2,1,1.5],inf))

~k.play

~sn = Pbind(\instrument,\bplay,\buf,d["sn"][0],\dur,1,\amp,2)

~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,2)

~c.play

~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\rate,1,\dur,Pbjorklund2(Pwhite(1,8).asStream,8),\amp,4)

~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\rate,2,\dur,Pbjorklund2(Pwhite(1,8).asStream,8),\amp,4)

~h.stop

~t2.play

~c.stop
~sn.stop


~h.play

~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Prand([0.125,0.5,0.25],inf).stutter(4),\amp,Pwhite(0.5,1.6),\rate,2)

~bpfbass = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*[2,4,6,10,14,20,40,50],\rel,0.1,\amp,2,\fb,1,\rel,49)

~bpfbass3 = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*[1,2,4,8,16,32,64],\rel,Pexprand(0.1,0.8),\amp,2,\rel,39,\fb,1,\dur,Pbjorklund2(Pwhite(1,7).asStream,8)/8)


~

~bpfbass3.play

~bpfsaw.stop

~bpfbass2 = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*Pwhite(1,90),\rel,40,\amp,2,\fb,1,\dur,Pwhite(0.25,2).round(0.25)/20)



~bpfbass2.play

p.clock.tempo=1.35

~bpfbass.play

~k.play

~f = {arg val = 20; SinOsc.kr(0,1,val)}


OSCdef(\z, {|msg| ~f= d[\linear].(msg[1],50,250)}, \z);
OSCdef(\x, {|msg| ~bpfbass3.set(\fb,d[\l].(msg[1],0.5,5.4));~bpfbass2.set(\fb,d[\l].(msg[1],0.5,6.4));~bpfbass.set(\fb,d[\l].(msg[1],0.5,7.4))}, \z1);

~sn.play


~sinefb.play

~bpfsaw.play


//church

