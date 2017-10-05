# BigJay

```
perl6 -Ilib -MTag -MSegmenter -MTrackingGroup -MHypothesis -MExperiment -e '

my Experiment $a .= new: "qwer", \("A", :percent(.1)), \("B", :variables{bla => 42}, :percent(.1));


my TrackingGroup $t .= new: :name<bla>;
$t.add-experiment: $a;

my $tag = Tag.new: "tag1";
$tag.add-experiment: $a;

my Segmenter $s .= new;
say $s.pick($_, :tags<tag1 tag2>).keys.map: {.experiment.name => (name => .name, vars => .variables).Hash} for ^20;
'
```
