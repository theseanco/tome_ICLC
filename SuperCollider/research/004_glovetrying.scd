//Experimentation with Sine Waves being controlled

~sines = {arg f = 440, fb = 0, dt = 0; SinOscFB.ar([f-(dt),f+dt],fb,SinOsc.kr(0.1).range(0.05,0.2))}

~verb = {FreeVerb.ar(~sines,0.6,0.9)}

~sines.stop(40)
~verb.play

~sines2 = {SinOsc.ar([50,50.5,100,101],0,0.5)}

~sines2.play

OSCdef(\x,{|msg| ~sines.set(\f,d[\linear].(msg[1],50,350).round(50))},\z)


OSCdef(\y,{|msg| ~sines.set(\fb,d[\linear].(msg[1],0,1))},\y)


OSCdef(\z,{|msg| ~sines.set(\dt,d[\linear].(msg[1],0,1))},\x)

//try some pbinds to work alongside the movement
~kick = Pbind(\instrument,\bplay,\buf,d["k"][2],\amp,3,\dur,4)

~kick.play

//experimentation with samples with gaps either side of them
//added a folder 'gaps'
/*

0 - kick
1 - snare
2 - clap
3 - hat

*/

OSCFunc.trace
OSCdef(\x,{|msg| ~warp1.set(\pos,d[\linear].(msg[1],0.1,0.9))},\x)
OSCdef(\y,{|msg| ~warp2.set(\pos,d[\linear].(msg[1],0.1,0.9))},\y)
OSCdef(\z,{|msg| ~warp3.set(\pos,d[\linear].(msg[1],0.1,0.9))},\z)

OSCdef(\y,{|msg| ~warp1.set(\pan,d[\linear].(msg[1],-1,1))},\y)


d["gaps"][0].play

~warp1 = {arg pos = 0, pan = 0; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,1,0.1,interp:4,mul:0.7),pan)}
~warp2 = {arg pos = 0, pan = 0; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,1,0.1,interp:4,mul:0.7),pan)}
~warp3 = {arg pos = 0, pan = 0; Pan2.ar(Warp1.ar(1,d["gaps"][3],pos,1,0.1,interp:4,mul:0.7),pan)}

~warp1.clear;
~warp1.play;

// I also need field recordings from Hamilton