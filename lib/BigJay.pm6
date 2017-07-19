sub hash-code-of(Any $data, Any $salt) {
	use nqp;
	:16(nqp::sha1($data.perl ~ " - $salt"))
}

class NoGroup {
	method Str {""}
}

class BigJay {

	state $id = 0;

	has Bag $.track is required;
	has Int $!salt = $id++;

	method TWEAK {
		die "More than 100%" if $!track.total > 100;
		$!track = bag |$!track.kxxv, NoGroup xx 100 - $!track.total if not $!track{NoGroup}:exists;
	}

	method segment(\id) {
		my $index = hash-code-of(id, $!salt) % $!track.total;
		for $!track.kv -> $group, $number {
			$index -= $number;
			return $group if $index <= 0;
		}
		NoGroup
	}
}
