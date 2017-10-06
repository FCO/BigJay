unit class BigJay::TrackingGroup;
use BigJay::Experiment;

my BigJay::TrackingGroup %cache;

has Str					$.name is required;
has uint32				$.id = ++$;
has BigJay::Experiment	@.experiments handles (add-experiment => "push");

method Positional(::?CLASS:D:)			{flat @!experiments>>.Array}
method Array(::?CLASS:D: --> Array())	{$.Positional}
method Mix(::?CLASS:D: --> Mix())		{$.Positional}

method new(|) {
	my $new = callsame;
	%cache{$new.name} = $new;
	$new
}

method tracks(::?CLASS:U:) {%cache}
