unit class Experiment;
use Hypothesis;

has Str $.name is required;
has Mix $.hypothesis;

method add-hypothesis(::?CLASS:D: Hypothesis $h, Rat :$percent = 0.0) {
	$!hypothesis = Mix.new-from-pairs: |$!hypothesis.pairs.grep(*.key !=== $h), $h => $percent
}

method Positional(::?CLASS:D:)		{$!hypothesis.pairs.sort: *.key.name}
method Array(::?CLASS:D:)			{$.Positional.Array}
method Mix(::?CLASS:D: --> Mix())	{$.Positional}
