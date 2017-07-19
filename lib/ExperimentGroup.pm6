unit class ExperimentGroup;
use Experiment;

has %.experiments;

method add-experiment(Set $name, Experiment $exp) {
	for $name.keys -> $key {
		%!experiments.push: $key => $exp
	}
}

method find-and-run-tests(Str $name, \id) {
	%!experiments{$name}
		.map(*.get-vars: id)
		.reduce: -> %init, %item {
			% = |%init, |%item
		}
}
