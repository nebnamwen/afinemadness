# usage: sh discard_stash.sh $CARD1 $CARD2 ...
#
# discard the named cards to your personal stash
#
# the first discard in a turn is free,
# as are all discards if you just scored a goal
#
# all other discards cost 1 willpower per card

sh __discard.sh players/$USER/stash "$@"
