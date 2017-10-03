unit class TrackingGroup;
use Experiment;

has uint32		$.id = ++$;
has Experiment	@.experiments handles (add-experiment => "push");

method Positional(::?CLASS:D:)			{flat @!experiments>>.Array}
method Array(::?CLASS:D: --> Array())	{$.Positional}
method Mix(::?CLASS:D: --> Mix())		{$.Positional}
