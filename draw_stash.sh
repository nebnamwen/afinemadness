# usage: sh draw_stash.sh N
#
# draw N cards from your personal stash
#
# your draw limit is one less than your hand size,
# but always at least 2.

sh __draw.sh $1 players/$USER/stash
