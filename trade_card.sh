# usage: trade_card.sh $PLAYER $CARD
#
# give another player a card from your hand

mv players/$USER/hand/$2 players/$1/hand && echo "$USER traded $2 to $1" >> messages.txt
