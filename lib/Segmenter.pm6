unit class Segmenter;
use Digest::MurmurHash3;
use TrackingGroup;

has UInt			$.dp = 100000;
has TrackingGroup	@.tracks;

method pick(Str() \id --> Set()) {
	do for @!tracks -> TrackingGroup $track {
		my $number = murmurhash3_32(id, $track.id) % $!dp / $!dp;
		my @options := $track.Array;
		do while $number > 0 {
			last unless @options;
			my ($exp, $num) = @options.shift.kv;
			$number -= $num;
			$exp if $number <= 0
		}
	}
}

