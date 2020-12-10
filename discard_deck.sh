# usage: sh discard_deck.sh $CARD1 $CARD2 ...
#
# discard the named cards to the central deck
#
# the first discard in a turn is free,
# as are all discards if you just scored a goal
#
# all other discards cost 1 willpower per card

sh __discard.sh card_deck "$@" && echo "$USER discarded $# cards to the deck" >> messages.txt
