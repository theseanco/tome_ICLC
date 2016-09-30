/*

Notes

Delegate Tasks to certain hands

*/

//the sine wave instrument

~sines.play

~sines2 = {arg f = 2, f2 = 2, fb = 0, dt = 0; SinOscFB.ar([~f*f,~f*f2+dt],fb,0.4)}
~sines2.play

OSCdef(\x,{|msg| ~sines2.set(\f,d[\linear].(msg[1],2,10).round(1))},\x);
OSCdef(\y,{|msg| ~sines2.set(\f2,d[\linear].(msg[1],2,10).round(1))},\z);
OSCdef(\z,{|msg| ~sines2.set(\dt,d[\linear].(msg[1],0,1))},\y1);
OSCdef(\z1,{|msg| ~sines2.set(\fb,d[\linear].(msg[1],0,2))},\z1);

(
OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\ushape].(msg[1],0,201).asInt)}, \y);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",d[\ushape].(msg[1],0,200).asInt)}, \y);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",d[\linear].(msg[1],0,255).asInt)}, \z);
OSCdef(\m1L, {|msg| b.sendMsg("/m/",d[\linear].(msg[1],30,255).asInt)}, \z1);
)



//the warping instrument

~warp1 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][0],pos,pitch,0.2,interp:4,mul:1),pan)};
~warp2 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][1],pos,pitch,0.2,interp:4,mul:1),pan)};
~warp3 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][2],pos,pitch,0.2,interp:4,mul:1),pan)};
~warp4 = {arg pos = 0, pan = 0, pitch = 1; Pan2.ar(Warp1.ar(1,d["gaps"][3],pos,pitch,0.2,interp:4,mul:1),pan)};
OSCdef(\x,{|msg| ~warp1.set(\pos,d[\linear].(msg[1],0.0,0.9))},\y);
OSCdef(\x1,{|msg| ~warp1.set(\pitch,d[\linear].(msg[1],0.5,1.5))},\x);
OSCdef(\z,{|msg| ~warp3.set(\pos,d[\linear].(msg[1],0.0,0.9))},\y1);
OSCdef(\z1,{|msg| ~warp3.set(\pitch,d[\linear].(msg[1],0.5,1.5))},\x1);


OSCdef(\x,{|msg| ~warp1.set(\pos,d[\linear].(msg[1],0.0,0.9))},\y);
OSCdef(\x1,{|msg| ~warp1.set(\pitch,d[\linear].(msg[1],0.5,5.5))},\x);
OSCdef(\z,{|msg| ~warp3.set(\pos,d[\linear].(msg[1],0.0,0.9))},\y1);
OSCdef(\z1,{|msg| ~warp3.set(\pitch,d[\linear].(msg[1],0.5,1.5))},\x1);


(
OSCdef(\x1L, {|msg| b.sendMsg("/r/",d[\ushape].(msg[1],0,201).asInt)}, \y);
OSCdef(\y1L, {|msg| b.sendMsg("/g/",d[\ushape].(msg[1],0,200).asInt)}, \y);
OSCdef(\z1L, {|msg| b.sendMsg("/b/",d[\linear].(msg[1],0,255).asInt)}, \x);
OSCdef(\m1L, {|msg| b.sendMsg("/m/",d[\linear].(msg[1],255,255).asInt)}, \x1);
)


//for the sound and the lights to be intrinsic to one another make a massive amount of sense - it's a really nice conversational echo of your sonic explorations
//The performance is not long enough to have a 'random' discovery by Charlie - the libraries developed need to be discussed with Charlie beforehand and improvised with in order to make sense as a performance.
//build moments during the use of the sine wave instrument - restart from 