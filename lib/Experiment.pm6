unit class Experiment;
use Hypothesis;

my Experiment %cache;
has Str $.name is required;
has Mix $.hypothesis;

proto method new(|) {
	my $new = {*};
	%cache{$new.name} = $new;
	$new
}

multi method new(Str $name, *@hipoteses) {
	self.new: $name, @hipoteses
}

multi method new(Str $name, @hipoteses = []) {
	my $new = self.bless: :$name;
	$new.add-hypothesis: |$_ for @hipoteses;
	$new
}

multi method add-hypothesis(::?CLASS:D: Str $name, :$variables = {}, Rat :$percent = 0.0) {
	self.add-hypothesis: Hypothesis.new(:$name, :$variables, :experiment(self)), :$percent;
}

multi method add-hypothesis(::?CLASS:D: Hypothesis $h, Rat :$percent = 0.0) {
	$!hypothesis = Mix.new-from-pairs: |$!hypothesis.pairs.grep(*.key !=== $h), $h => $percent
}

method Positional(::?CLASS:D:)		{$!hypothesis.pairs.sort: *.key.name}
method Array(::?CLASS:D:)			{$.Positional.Array}
method Mix(::?CLASS:D: --> Mix())	{$.Positional}

method experiments(::?CLASS:U: *@keys) {%cache{@keys || *}}
