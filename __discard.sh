for CARD in "$@"
do
    if [ -e players/$USER/hand/$CARD ]
    then
	if [ ! -e players/$USER/scored_goal.flag ]
	then
	    if [ -e players/$USER/free_discard.flag ]
	    then
		rm players/$USER/free_discard.flag
	    else
		if [ "$(cat players/$USER/willpower)" -gt 0 ]
		then
		    WILL=$(expr $(cat players/$USER/willpower) - 1)
		    echo $WILL > players/$USER/willpower
		else
		    echo "Your willpower is exhausted."
		    exit 1
		fi
	    fi
	fi

	mv players/$USER/hand/$CARD $1
    else
	if [ $CARD != $1 ]
	then
	    echo "$CARD is not in your hand."
	fi
    fi
done

if [ -e players/$USER/provoked_goal ] && [ "$(ls players/$USER/hand | wc -l)" -le "$(cat $(cat players/$USER/provoked_goal))" ]
then
    echo "You've calmed down enough to avoid responding to provocation."
    rm players/$USER/provoked_goal
fi

if [ "$(cat players/$USER/willpower)" -eq 0 ]
then
    echo "Your willpower is exhausted."
else
    echo "You have $(cat players/$USER/willpower) willpower left."
fi
