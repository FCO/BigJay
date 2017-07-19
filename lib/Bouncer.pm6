unit class Bouncer;

has %.rules;

method get-conf(\id) {
	{
		app-user => id %% 2 ?? "true" !! "false"
	}
}

method should-participate(\id) {
	my %conf = $.get-conf(id);
	%!rules.kv.reduce: -> Str $name, %values {
		my $resp;
		if $name ~~ /^ \s* $<not>="!" \s* $<word>=[\w+] \s* $/ {
			$resp = %values.one ~~ %conf{$<word>};
			$resp = !$resp if $<not> eq "!"
		} else {
			$resp = %values.keys.any ~~ %conf{$name}
		}
		$resp
	}
}
