//addressing different functions using dictionaries

d = Dictionary.new

d[\func] = { |in, max = 1, min = 10|
	var result = in.linlin(0,1600,max, min);
	result;
}

(
d[\dfm1] = {|in| DFM1.ar(in,1000,0.5);
};
)

d[\dfm1].play({SinOsc.ar})