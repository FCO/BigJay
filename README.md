# BigJay

```
perl6 -Ilib -MSegmenter -MTrackingGroup -MHypothesis -MExperiment -e '

my Experiment $a .= new: :name<wer>;

$a.add-hypothesis: Hypothesis.new(:name<A>, :experiment($a)), :percent(.25);
$a.add-hypothesis: Hypothesis.new(:name<B>, :experiment($a)), :percent(.25);

my TrackingGroup $t .= new: :4id;

$t.add-experiment: $a;

my Segmenter $s .= new: :tracks[$t];
say $s.pick($_).keys.map: {.experiment.name => .name} for ^10;
'
```
