unit class Hypothesis;

method WHICH(::?CLASS:D:) {"Hypothesis|$!name"}

has Str         $.name          is required;
has             $.variables     = {};
has             $.experiment    is required;

