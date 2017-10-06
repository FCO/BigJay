unit class Segmenter;
use Digest::MurmurHash3;
use TrackingGroup;
use Tag;

has UInt			$.dp = 100000;
has TrackingGroup:U	$.tracks = TrackingGroup;

method pick(Str() \id, Set() :$tracks = $!tracks.tracks.keys.Set, Set() :$tags = Empty --> Set()) {
	my @tracks = |$!tracks.tracks{|$tracks.keys};
	my $tag-exp = Tag.hypotheses: $tags;
	do for @tracks -> TrackingGroup $track {
		my $number = murmurhash3_32(id, $track.id) % $!dp / $!dp;
		my @options := $track.Array;
		do while $number > 0 {
			last unless @options;
			my ($hypothesis, $num) = @options.shift.kv;
			$number -= $num;
			$hypothesis if $hypothesis.defined and $tag-exp{$hypothesis} and $number <= 0;
		}
	}
}

