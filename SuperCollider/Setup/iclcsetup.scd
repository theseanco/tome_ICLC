(
s.options.numBuffers = 1024 * 16;
s.options.memSize = 8192 * 16;
s.boot;
p=ProxySpace.push(s);
p.makeTempoClock;
c=NanoKontrol.new;
p.clock.tempo = 1;
s.scope;
b = NetAddr("127.0.0.1", 7700);
Task({
	3.wait;
	d = Dictionary.new;
	d.add(\foldernames -> PathName(thisProcess.nowExecutingPath.dirname +/+ "Samples").entries);
	for (0, d[\foldernames].size-1,
		{arg i; d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
			arg sf;
			Buffer.read(s,sf.fullPath);
		});
	)});
	("SynthDefs.scd").loadRelative;
	3.wait;
	StageLimiter.activate;
	1.wait;
	//linear transfer function
	d[\linear] = { |in, max = 1, min = 10|
		var result = in.linlin(0,32627,min,max);
		result;
	};

	//exponential transfer function
	d[\exponential] = { |in, max = 1, min = 10|
		var result = (in+1).explin(1,32628,min,max);
		result;
	};

	//what this could do with is a 'number' and a 'scale' version, so that max/min values can be set alongside a number of times over the course of the whole value set
	//this can be done by doing a modulo over the entire value
	d[\wrapped] = { |in, wrap = 10000, divisor = 10|
		var result = in%wrap;
		result;
	};

	//wrap contains the number of times the modulo will wrap, min, max dictates scaling of each wrapping
	d[\wrappedScale] = { |in, min = 0.0, max = 40.0, wrap = 20|
		var result = in%(32627/wrap);
		result = result.linlin(0,32627/wrap,min,max);
		result;
	};

	//A u-shape with a variable scale
	d[\ushape] = { |in, min = 0, max = 10|
		var result = (in-16313.5).abs;
		result = result.linlin(0,16314,min,max);
	};
	"Setup done!".postln;
}).start;
)