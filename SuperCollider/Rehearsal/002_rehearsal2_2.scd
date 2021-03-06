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
OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\linear].(msg[1],100,155).asInt)}, \y1);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",20)}, \y1);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",10)}, \z1);
)


~warp1 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],LFNoise1.kr(0.1),rate,0.2,-1,8,0,4,0.5))}
~warp3 = {arg pos = 0, rate = 1; Pan2.ar(Warp1.ar(1,d["gaps"][1],LFNoise1.kr(0.1),rate,0.2,-1,8,0,4,0.5))}


~warp1.play
~warp3.play
OSCdef(\y2, {|msg| ~fbsines.set(\f,d[\linear].(msg[1],1,5).asInt)}, \y);
OSCdef(\z2, {|msg| ~fbsines.set(\f2,d[\linear].(msg[1],1,5).asInt)}, \z);

OSCdef(\y12, {|msg| ~fbsines.set(\fb,d[\linear].(msg[1],0,1.4))}, \y1);
	OSCdef(\z1, {|msg| ~warp1.set(\rate,d[\linear].(msg[1],0.5,1.5))}, \z1);

OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\linear].(msg[1],100,155).asInt)}, \x);
		OSCdef(\yL, {|msg| b.sendMsg("/g/",d[\linear].(msg[1],10,250).asInt)}, \y);
		OSCdef(\z1L, {|msg| b.sendMsg("/b/",d[\linear].(msg[1],10,50).asInt)}, \z);

		OSCdef(\z1L, {|msg| b.sendMsg("/m/",d[\linear].(msg[1],100,255).asInt)}, \z1);

~f = {50}


~sines = {SinOsc.ar([~f/4,~f/2],0,9)}

~sines.play

~saw = Pbind(\instrument,\bpfsaw,\freq,Pexprand(1,16).round(1)*((Pkr(~f))/2),\ldb,15,\lsf,600,\amp,Pwhite(0.7,2),\rel,4,\sus,2,\atk,3,\detune,Pexprand(0.0001,2))

~fbsines = {arg f = 2, f2 = 2, fb = 0; SinOscFB.ar([LFNoise1.kr(2.8).range(1,15).round(1)*~f,LFNoise1.kr(0.8).range(1,15).round(1)*~f],SinOsc.kr(0.1).range(0.1,1.5),0.7)}

~fbsines.stop(40)
OSCFunc.trace

~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/8,\amp,2.6,\rate,Pseq([1,1.5,1,2,1,3],inf))

~k.play

~k2 = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,0.5,\amp,20)

~k2.play

~sn = Pbind(\instrument,\bplay,\buf,d["sn"][0],\dur,2,\amp,1)

~h = Pbind(\instrument,\bplay,\buf,d["h"][0],\amp,Pwhite(0.5,1),\dur,0.125/Pseq([1,1,1,2],inf).stutter(8))

~h = Pbind(\instrument,\bplay,\buf,d["h"][0],\amp,Pwhite(0.5,1),\dur,0.125/Pseq([1,1,1,2],inf).stutter(8))

~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,2)
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Prand([0.75,1],inf),\amp,2)

~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\rate,2,\dur,Pbjorklund2(Pwhite(1,7).asStream,8,inf)/4,\amp,4)
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\rate,4,\dur,Pbjorklund2(Pwhite(1,7).asStream,8,inf)/4,\amp,4)
~sn.play

~sn.play

~saw.stop(40)

~t.play

~c.play

~k.stop

p.clock.tempo=1.28

~fbbass.stop

~fbbass2 = Pbind(\instrument,\sinfb,\dur,Pwhite(0.25,1.5).round(0.25)/2,\rel,Pwhite(0.1,0.5),\freq,Pwhite(1,8)*Pkr(~f)*[1,2,4],\amp,Pwhite(0.1,0.5),\fb,Pwhite(0.6,1.7))

~fbbass = Pbind(\instrument,\sinfb,\dur,Pbjorklund2(3,8)/8,\rel,Pwhite(0.01,0.1),\freq,Pwhite(1,4)*Pkr(~f),\amp,2.5,\fb,Pwhite(0.6,2.7))

~fbbass3 = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*[1,3,2],\rel,0.6,\dur,Pbjorklund2(3,8)/8,\fb,Pwhite(0.1,1.6),\amp,2)

~fbbass3.stop(40)

~t2.stop

~fbbass5 = Pbind(\instrument,\sinfb,\freq,Pkr(~f)*[20,20.1,20.2,40,45,80,160,320,1,2,3,4,5,6],\rel,30,\dur,Pbjorklund2(3,8)/8,\fb,Pwhite(0.1,1.6),\amp,2)

~fbbass5.clear

~fbbass.stop

~fbbass2.play

~f = {SinOsc.kr(0.1).range(40,51)}

~f = {arg val = 20; SinOsc.kr(0,1,val)}

~f = {10}

~q = {SinOsc.ar(0,SinOsc.kr(1).range(0,1),1)}

~q.play

~f = {arg f = 20; f}

OSCdef(\z,{|msg| ~f.set(\val,d[\linear].(msg[1],50,52))},\z)


OSCdef(\z1,{|msg| ~fbbass3.set(\fb,d[\linear].(msg[1],0.5,2);~fbbass5.set(\fb,d[\linear].(msg[1],0.5,2.6)))},\z1)


OSCdef(\xL, {|msg|  }, \x);
OSCdef(\yL, {|msg| }, \y);
OSCdef(\zL, {|msg| }, \z);

OSCdef(\z, {|msg| ~f= d[\linear].(msg[1],100,201)}, \z);

OSCFunc.trace

~f.fadeTime=0

~fbbass2.play
~h.play

~sn.play

~k.play

~warp1.stop(10)

~warp3.stop(20)

~fbsines.play

~saw.play

~sines.play

p.fadeTime=4

~f.fadeTime=0

		~f = {50}