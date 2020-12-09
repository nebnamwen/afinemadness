# usage: sh show_table.sh

for PLAYER in $(ls players)
do
    echo $'\e'\#3"$PLAYER"
    echo $'\e'\#4"$PLAYER"
    echo -n "Hand: $(ls players/$PLAYER/hand | wc -l | sed 's/ //g') cards; "
    echo -n "Stash: $(ls players/$PLAYER/hand | wc -l | sed 's/ //g') cards; "
    echo "Willpower: $(cat players/$PLAYER/willpower)"
    echo

    if [ $PLAYER = $USER ]
    then
	ls players/$PLAYER/hand
	echo
    fi

    if [ "$(ls players/$PLAYER/scored_goals | wc -l)" -gt 0 ]
    then
	echo "scored goals:"
	for GOAL in $(ls players/$PLAYER/scored_goals)
	do
	    echo "$GOAL = $(cat players/$PLAYER/scored_goals/$GOAL)"
	done

	echo "$PLAYER total score: $(cat players/$PLAYER/scored_goals/* | awk '{total += $1} END {print total}')"
	echo
    fi
done
echo

echo "Goals on table:" `ls table_goals`
echo "My hidden goal: $(ls players/$USER/hidden_goal)"
echo
