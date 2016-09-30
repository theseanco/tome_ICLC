from time import sleep
from random import randint
import OSC

c = OSC.OSCClient()
c.connect(('127.0.0.1', 57120))

num = 0
skew = 0
i = 0
skewset = 20

while True:
    num = num + (randint(0,200))-(skew)
    num = num%32627
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/x")
    oscmsg.append(num)
    c.send(oscmsg)
    i = i + 1
    if i == skewset:
        i = 0
        skew = skew + 1
        skew = skew % 20
        skewset = randint(20,300)
        print skew
    sleep(0.01)
