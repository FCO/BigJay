unit class Tag;
use Experiment;

my Tag %cache;
has     $.name is required;
has     $.experiment = Empty;

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

multi method tags(::?CLASS:U: Whatever) {
    %cache{*}
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

method experiments(::CLASS:U: Set() $tags = Empty --> Set()) {
	set |self.tags($tags.keys).grep(*.defined).map: {.experiment.keys};
}

method hypotheses(::CLASS:U: Set() $tags = Empty --> Set()) {
    set |self.experiments($tags).keys.map: {.hypothesis.keys}
}
