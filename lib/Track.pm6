unit class Track;

my $id = 0;

has 	$.id = $id++;
has Bag	$.percents is required;

method hash-code(Any $data) is pure {
	use nqp;
	:16(nqp::sha1($data.perl ~ " - $!id"))
}

method segment(Any \id --> Str) is pure {
	my Int $index = $.hash-code(id) % 100;
	for $!percents.kv -> $k, $v {
		$index -= $v;
		return $k if $index < 0
	}
	Str
}
