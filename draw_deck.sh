# usage: sh draw_deck.sh N
#
# draw N cards from the central deck
#
# your draw limit is one less than your hand size,
# but always at least 2.

sh __draw.sh $1 card_deck && echo "$USER drew $1 cards from the deck" >> messages.txt
