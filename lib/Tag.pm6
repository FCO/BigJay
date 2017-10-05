unit class Tag;
use Experiment;

my Tag %cache;
has     $.name is required;
has     $.experiment = Empty;

# TODO: get experiments

multi method add-experiment(Str $experiment-name) {
    $!experiment = set |$!experiment.keys, Experiment.experiments{$experiment-name};
}

multi method add-experiment(Experiment $experiment) {
    $!experiment = set |$!experiment.keys, $experiment;
}

method new($name) {
	my $new = self.bless: :$name;
	%cache{$new.name} = $new;
	$new
}

multi method tags(::?CLASS:U: @tags) {
    %cache{@tags}
}

multi method tags(::?CLASS:U: []) {
    %cache.values
}

multi method tags(::?CLASS:U: --> Hash()) {
    %cache
}
