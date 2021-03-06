# usage: sh score_goal.sh $GOAL $CARD1 $CARD2 ...
#
# score a goal using cards from your hand
#
# you should list the cards that were successfully used,
# and omit the cards that were dropped.

unset GOAL
unset RIVAL
if [ -e table_goals/$1 ]
then
    GOAL=table_goals/$1
    PREV=0
else
    if [ -e players/$USER/hidden_goal/$1 ]
    then
	GOAL=players/$USER/hidden_goal/$1
	PREV=0
    else
	for PLAYER in $(ls players)
	do
	    if [ -e players/$PLAYER/scored_goals/$1 ]
	    then
		GOAL=players/$PLAYER/scored_goals/$1
		PREV=$(cat $GOAL)
		if [ $PLAYER != $USER ]
		then 
		    RIVAL=$PLAYER
		fi
	    fi
	done
    fi
fi

if [ -z "$GOAL" ]
then
    echo "There is no goal named $1 on the table."
    exit 1
fi

if [ ! -e players/$USER/my_turn.flag ] && [ $GOAL != "$(cat players/$USER/provoked_goal 2>/dev/null)" ]
then
    echo "You can only score a goal out of turn when you are provoked."
    exit 1
fi

echo "$USER is scoring $@" >> messages.txt

SCORED=0
DROPPED=0
for CARD in $(ls players/$USER/hand)
do
    if [ -n "$(echo "$@" | grep -w $CARD)" ]
    then
	SCORED=$(expr $SCORED + 1)
    else
	DROPPED=$(expr $DROPPED + 1)
    fi
done
SCORE=$(expr $SCORED - $DROPPED \* 2)
echo "Scored $SCORED cards, dropped $DROPPED, for a total score of $SCORE"

if [ $SCORE -gt $PREV ]
then
    echo "You scored the goal $1 for $SCORE points"
    echo "$USER scored the goal $1 for $SCORE points." >> messages.txt
    echo $SCORE > $GOAL
    mv $GOAL players/$USER/scored_goals

    if [ -n "$RIVAL" ] && [ "$(ls player/$RIVAL/hand | wc -l)" -gt $SCORE ]
    then
	echo "Player $RIVAL is provoked and must respond once you finish your turn!"
	echo "$RIVAL is provoked!" >> messages.txt
	echo players/$USER/scored_goals/$1 > players/$RIVAL/provoked_goal
    fi

    if [ -n "$(echo $GOAL | grep players/$USER/hidden_goal)" ] 
    then
	if [ "$(ls goal_deck | wc -l)" -gt 0 ]
	then
	    for GOAL in $(ls goal_deck | sort -R | head -n 3)
	    do
		mv goal_deck/$GOAL players/$USER/hidden_goal
	    done

	    echo "You scored your hidden goal and drew to replace it:"
	    ls -m players/$USER/hidden_goal
	    KEEPER=__not_a_real_goal
	    while [ ! -e players/$USER/hidden_goal/$KEEPER ]
	    do
		read -p "Which goal would you like to keep?: " KEEPER
	    done

	    for GOAL in $(ls players/$USER/hidden_goal | grep -xv $KEEPER)
	    do
		mv players/$USER/hidden_goal/$GOAL goal_deck
	    done
	else
	    echo "There are no goals left in the deck to replace your hidden goal."
	fi
    fi

    if [ -n "$(echo $GOAL | grep table_goals)" ]
    then
	if [ "$(ls goal_deck | wc -l)" -gt 0 ]
	then
	    NEWGOAL="$(ls goal_deck | sort -R | head -n 1)"
	    mv goal_deck/$NEWGOAL table_goals
	    echo "You scored a table goal and drew $NEWGOAL to replace it."
	else
	    echo "There are no goals left to replace a table goal."
	fi
    fi	

else
    echo "You didn't beat the previous score of $PREV"
    echo "$USER tried to score $1 but their score of $SCORE didn't beat the previous score of $PREV." >> messages.txt
fi

echo "You'll need to discard your hand to continue."
rm players/$USER/provoked_goal 2>/dev/null
touch players/$USER/scored_goal.flag
