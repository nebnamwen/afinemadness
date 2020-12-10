# usage: used internally by discard_deck.sh and discard_stash.sh

COST=0

for CARD in "$@"
do
    if [ -e players/$USER/hand/$CARD ]
    then
	COST=$(expr $COST + 1)
    else
	if [ $CARD != $1 ]
	    then
	    echo "$CARD is not in your hand."
	    exit 1
        fi
    fi
done

if [ "$COST" -eq 0 ]
then
    echo "You didn't name any cards to discard."
    exit 1
fi

if [ -e players/$USER/free_discard.flag ]
then
    COST=$(expr $COST - 1)
fi

if [ ! -e players/$USER/scored_goal.flag ]
then
    if [ $COST -gt $(cat players/$USER/willpower) ]
    then
	echo "You don't have enough willpower to discard that many cards."
	exit 1
    fi
    WILL=$(expr $(cat players/$USER/willpower) - $COST)
    echo $WILL > players/$USER/willpower
fi    

for CARD in "$@"
do
    if [ -e players/$USER/hand/$CARD ]
    then
	mv players/$USER/hand/$CARD $1
    fi
done

if [ -e players/$USER/provoked_goal ] && [ "$(ls players/$USER/hand | wc -l)" -le "$(cat $(cat players/$USER/provoked_goal))" ]
then
    echo "You've calmed down enough to avoid responding to provocation."
    rm players/$USER/provoked_goal
fi

if [ ! -e players/$USER/scored_goal.flag ]
then
    if [ "$(cat players/$USER/willpower)" -eq 0 ]
    then
	echo "Your willpower is exhausted."
    else
	echo "You have $(cat players/$USER/willpower) willpower left."
    fi
fi
