unit class Experiment;
use Track;
use Bouncer;
has Str		$.name is required;
has Track	$.track;
has Bouncer	$.bouncer;
has 		%.variables;

method new($name, %rules, *@vars) {
	my $track 		= Track.new:	:percents(@vars.map(-> (:$key, :$value) {$key => $value<percent>.Int}).Bag);
	my $bouncer		= Bouncer.new:	:%rules;
	my %variables 	= @vars.map: -> (:$key, :$value) {$key => $value<variables>}

	::?CLASS.bless: :$name, :$bouncer, :$track, :%variables;
}

method get-vars(\id) {
	do if $!bouncer.should-participate: id {
		with $!track.segment(id) -> $group {
			return % = "test.$!name" => $group, |%!variables{$group}
		}
	}
	{}
}
