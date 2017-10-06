# BigJay

```
perl6 -Ilib -MBigJay::Tag -MBigJay::Segmenter -MBigJay::TrackingGroup -MBigJay::Hypothesis -MBigJay::Experiment -e '

my BigJay::Experiment $a .= new: "qwer", \("A", :percent(.45)), \("B", :variables{bla => 42}, :percent(.45));


my BigJay::TrackingGroup $t .= new: :name<bla>;
$t.add-experiment: $a;

my $tag = BigJay::Tag.new: "tag1";
$tag.add-experiment: $a;

my BigJay::Segmenter $s .= new;
say $s.pick($_).keys.map: {.experiment.name => (name => .name, vars => .variables).Hash} for ^200;
'
```
