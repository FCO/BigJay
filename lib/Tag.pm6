unit class Tag;
use TrackingGroup;

my Tag %cache;
has     $.name is required;
has     $.tracks = Empty;

method add-track(TrackingGroup $track) {
    $!tracks = set |$!tracks.keys, $track;
}

method new($name) {
	my $new = self.bless: :$name;
	%cache{$new.name} = $new;
	$new
}

method tags(::?CLASS:U:) {%cache}
