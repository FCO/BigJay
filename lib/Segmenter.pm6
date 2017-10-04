unit class Segmenter;
use Digest::MurmurHash3;
use TrackingGroup;
use Tag;

has UInt			$.dp = 100000;
has TrackingGroup:U	$.tracks = TrackingGroup;

method pick(Str() \id, Set() :$tracks = $!tracks.tracks.keys.Set, Set() :$tags = Empty --> Set()) {
	my @tracks;
	if $tags {
		@tracks = $tags.keys.flatmap: -> Str $tag-name {.tracks.keys with Tag.tags{$tag-name}}
	} else {
		@tracks = |$!tracks.tracks{|$tracks.keys};
	}
	do for @tracks -> TrackingGroup $track {
		my $number = murmurhash3_32(id, $track.id) % $!dp / $!dp;
		my @options := $track.Array;
		do while $number > 0 {
			last unless @options;
			my ($exp, $num) = @options.shift.kv;
			$number -= $num;
			$exp unless $number > 0
		}
	}
}

