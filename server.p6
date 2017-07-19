use HTTP::Server::Async;
use HTTP::Server::Router;
use lib "lib";
use ExperimentGroup;
use Experiment;

my Experiment $e .= new:
	"bla",
	{app-user => set <true false>},
	"A" => {
		percent		=> 45,
		variables	=> {
			var1	=> 42
		}
	},
	"B" => {
		percent		=> 45,
		variables	=> {
			var1	=> 13
		}
	}
;

my ExperimentGroup $g .= new;
$g.add-experiment: set(<expiratedAd iOS>), $e;

my HTTP::Server::Async $server .= new: :port(5000);

serve $server;

route '/:tag/:id', -> $req, $res {
	start $res.close: to-json $g.find-and-run-tests: |$req.params<tag id>;
}

$server.listen: True
