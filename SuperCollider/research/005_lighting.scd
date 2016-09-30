/*

TODO:

- Transfer functions for lights and using movement to articulate changes in lighting.
-- This can probably be accomplished using a bunch of old transfer functions from tome. which will be in the old files#

- Maybe different schemes and tuning the lighting to different gestures? That could be quite nice.

- Redo the lighting fixtures so that they have a general light control as well as a light control specific to multiple fixtures?
----- DONE. Addressed /r/ for overall /r1/ for light 1, for example



*/

//Starting setting is the same as in 'tome.'
(
b.sendMsg("/r/",189);
b.sendMsg("/g/",97);
b.sendMsg("/b/",99);
b.sendMsg("/m/",189);
)



//try sending this as an array with multiple lights?
OSCdef(\xLight, {|msg| b.sendMsg("/r/",189+(d[\ushape].(msg[1],-40,10).asInt).postln;)},\x);





OSCdef(\yLight, {|msg| b.sendMsg("/r/",d[\ushape].(msg[1],0,255).asInt)}, \z);
OSCdef(\zLight, {|msg| }, \z);

OSCdef(\x1Light, {|msg| }, \x1);
OSCdef(\y1Light, {|msg| }, \y1);
OSCdef(\z1Light, {|msg| }, \z1);







(
b.sendMsg("/r/",rrand(0,255));
b.sendMsg("/g/",rrand(0,255));
b.sendMsg("/b/",rrand(0,255));
b.sendMsg("/m/",rrand(0,255));
)










