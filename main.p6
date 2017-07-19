use lib "lib";

#use Track;
#
#my Track $t .= new: :percents(("A" => 10, "B" => 10).Bag);
#
#for ^10000 -> $id {
#	say $t.segment: $id
#}

use ExperimentGroup;
use Experiment;

my Experiment $e .= new:
	"bla",
	{app-user => set <true false>},
	"A" => {
		percent		=> 50,
		variables	=> {
			var1	=> 42
		}},
	"B" => {
		percent		=> 50,
		variables	=> {
			var1	=> 13
		}
	}
;

my ExperimentGroup $g .= new;

$g.add-experiment: set(<expiratedAd iOS>), $e;

for ^10_000 -> $id {
	say $g.find-and-run-tests: "iOS", $id
}
