# usage: used internally by draw_deck.sh and draw_stash.sh

if [ ! -e players/$USER/draw_phase.flag ]
then
    echo Your draw phase is not active.
    exit 1
fi

if [ $1 -gt 3 ] && [ "$(expr $1 + 1)" -gt "$(ls players/$USER/hand | wc -l)" ]
then
    if [ "$(ls players/$USER/hand | wc -l)" -gt 3 ]
    then
	echo Your draw limit is "$(expr $(ls players/$USER/hand | wc -l | sed 's/ //g') - 1)", one less than your hand size.
    else
	echo Your draw limit is 3.
    fi
    exit 1
fi

if [ $1 -gt "$(ls $2 | wc -l)" ]
then
    echo "There are only $(ls $2 | wc -l | sed 's/ //g') cards in that stack."
    exit 1
fi

rm players/$USER/draw_phase.flag

for CARD in $(ls $2 | sort -R | head -n $1)
do
    echo $CARD
    mv $2/$CARD players/$USER/hand
done

echo
