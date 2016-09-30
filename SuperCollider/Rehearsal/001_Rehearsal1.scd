/*

Transfer Functions:

Linear (in, min, max)
Exponential (in, min, max)
ushape (in, min, max)
wrapped( in, number)
wrappedScale ( in, min, max, number)

Light control:

/r/ - all reds
/r1/ - reds on light 1

Samples:




*/

//starting light
(
b.sendMsg("/r/",109);
b.sendMsg("/g/",10);
b.sendMsg("/b/",30);
b.sendMsg("/m/",255);
)

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

///LIGHT
OSCdef(\xL, {|msg| }, \x);
OSCdef(\yL, {|msg| }, \y);
OSCdef(\zL, {|msg| }, \z);

(
OSCdef(\x1L, {|msg| b.sendMsg("/r/",189)}, \x1);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",97)}, \y1);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",99)}, \z1);
)

//ideas

/*

Variable low sine waves

Warped field recordings

Warped drum samples

*/

OSCdef(\x,{|msg| ~warp1.set(\pos,d[\linear].(msg[1],0.1,0.9))},\x)
OSCdef(\y,{|msg| ~warp2.set(\pos,d[\linear].(msg[1],0.1,0.9))},\y)
OSCdef(\z,{|msg| ~warp3.set(\pos,d[\linear].(msg[1],0.1,0.9))},\z)

~warp1 = {arg pos = 0, pan = 0; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,1,0.1,interp:4,mul:0.7),pan)}
~warp2 = {arg pos = 0, pan = 0; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,1,0.1,interp:4,mul:0.7),pan)}
~warp3 = {arg pos = 0, pan = 0; Pan2.ar(Warp1.ar(1,d["gaps"][3],pos,1,0.1,interp:4,mul:0.7),pan)}

(
OSCdef(\x,{|msg| ~warp1.set(\pos,d[\linear].(msg[1],0.0,0.9))},\x);
OSCdef(\y,{|msg| ~warp1.set(\pitch,d[\linear].(msg[1],0.1,1.1))},\y);
OSCdef(\z,{|msg| ~warp3.set(\pos,d[\linear].(msg[1],0,0.9))},\z);
)

(
~warp1 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["field"][0],pos,pitch,0.1,interp:4,mul:0.8),pan)};
)
~warp1.stop(30)

~f = 50

~sines = {SinOsc.ar([~f,~f+LFNoise1.kr(0.1)],0,0.6)}

~sines2 = {arg f = 2, f2 = 2, fb = 0, dt = 0; SinOscFB.ar([~f*f,~f*f2+dt],fb,0.1)}

~sines2.play

OSCdef(\x,{|msg| ~sines2.set(\f,d[\linear].(msg[1],2,8).asInt)},\x);
OSCdef(\y,{|msg| ~sines2.set(\f2,d[\linear].(msg[1],2,8).asInt)},\z);
OSCdef(\z,{|msg| ~sines2.set(\dt,d[\linear].(msg[1],0,1))},\y);
OSCdef(\z1,{|msg| ~sines2.set(\fb,d[\linear].(msg[1],0,2))},\z1);

~warp1 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,pitch,0.2,interp:4,mul:1),pan)};
~warp2 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,pitch,0.2,interp:4,mul:1),pan)};
~warp3 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][2],pos,pitch,0.2,interp:4,mul:1),pan)};
~warp4 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][3],pos,pitch,0.2,interp:4,mul:1),pan)};
OSCdef(\x,{|msg| ~warp1.set(\pos,d[\linear].(msg[1],0.0,0.9))},\y);
OSCdef(\x1,{|msg| ~warp1.set(\pitch,d[\linear].(msg[1],0.5,1.5))},\x);
OSCdef(\z,{|msg| ~warp3.set(\pos,d[\linear].(msg[1],0.0,0.9))},\z1);
OSCdef(\z1,{|msg| ~warp3.set(\pitch,d[\linear].(msg[1],0.5,1.5))},\y1);

~warp1.stop(10)
~warp3.stop(10)

~warp2.stop(5)

~warp4.stop




~sines.play
~warp1.play

~sines2.stop(20)

~sines2.play

~sines.play


~kick = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,4,\amp,1)

~snare = Pbind(\instrument,\bplay,\buf,d["sn"][1],\dur,Pwhite(8,32),\amp,1)

~hats2 = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Pwhite(1,10)/2,\amp,1)

~hats = Pbind(\instrument,\bplay,\buf,d["h"][0],\dur,Pwhite(1,10),\amp,1)

~saws = Pbind(\instrument,\bpfsaw,\freq,Pexprand(1,10).round(1)*Pkr(~f),\amp,Pwhite(0.1,1),\lsf,200,\ldb,14,\detune,Pexprand(0.0001,0.5))

~sinbass = Pbind(\instrument,\sinfb,\freq,Prand([1,2,4],inf)*Pkr(~f/2),\amp,Pwhite(0.3,0.7),\fb,Pwhite(0.4,0.7),\rel,0.1,\rate,Pwhite(1,4)/2)

~sinbass.play

~sines.stop(10)

~saws.play

~kick.play

~snare.play


~kick.play



p.fadeTime=4
~warp1.play




(
OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\ushape].(msg[1],0,201).asInt)}, \y);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",d[\ushape].(msg[1],0,200).asInt)}, \y1);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",d[\linear].(msg[1],0,255).asInt)}, \z1);
)


~kick = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,1,\amp,1)

~snare = Pbind(\instrument,\bplay,\buf,d["sn"][1],\dur,Pbjorklund2(3,8)/4,\amp,1)


~kick.play

~hats2 = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Pwhite(1,10)/2,\amp,1)

~hats = Pbind(\instrument,\bplay,\buf,d["h"][0],\dur,Pbjorklund2(Pkr(~x),8)/2,\amp,1)

~hats.play
~hats.clear
p.clock.tempo=158/60

~hats2.play

~hats.play

~x = 0

OSCdef(\x,{|msg| ~x = d[\linear].(msg[1],1,7).asInt.postln;},\z);
OSCdef(\x2,{|msg| ~hats.set(\rate,d[\linear].(msg[1],2,2.1))},\z1);

~hats.play

~kick.play

~hats2.play