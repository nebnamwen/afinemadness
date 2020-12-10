# usage: sh show_table.sh

for PLAYER in $(ls players)
do
    echo "==== $PLAYER ===="
    echo -n "Hand: $(ls players/$PLAYER/hand | wc -l | sed 's/ //g') cards; "
    echo -n "Stash: $(ls players/$PLAYER/stash | wc -l | sed 's/ //g') cards; "
    echo -n "Willpower: $(cat players/$PLAYER/willpower); "
    echo "Score: $(cat players/$PLAYER/scored_goals/* | awk '{total += $1} END {print total}')"

    if [ -e players/$PLAYER/provoked_goal ]
    then
	echo "$PLAYER is provoked to reclaim  <(cat players/$PLAYER/provoked_goal | sed 's#.*/##')"
    fi

    echo

    if [ $PLAYER = $USER ] || [ -e players/$PLAYER/reveal_hand.flag ]
    then
	ls -m players/$PLAYER/hand
	echo
    fi

    if [ $PLAYER = $USER ] && [ -e players/$PLAYER/reveal_hand.flag ]
    then
	echo "Your hand is revealed to the table."
	echo
    fi

    if [ "$(ls players/$PLAYER/scored_goals | wc -l)" -gt 0 ]
    then
	echo "scored goals:"
	for GOAL in $(ls players/$PLAYER/scored_goals)
	do
	    echo "$GOAL = $(cat players/$PLAYER/scored_goals/$GOAL)"
	done

	echo
    fi
done
echo

echo "Goals on table: $(ls -m table_goals)"
echo "My hidden goal: $(ls players/$USER/hidden_goal)"
echo

echo "-----------------------------"
tail -n 6 messages.txt
echo
