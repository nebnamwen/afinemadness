touch players/$USER/my_turn.flag
touch players/$USER/draw_phase.flag
touch players/$USER/free_discard.flag
rm players/$USER/scored_goal.flag 2>/dev/null

echo "Goals on table:"
for GOAL in $(ls table_goals)
do
    echo unscored: $GOAL
done
for PLAYER in $(ls players | grep -xv $USER; echo $USER)
do
    for GOAL in $(ls players/$PLAYER/scored_goals)
    do
	echo $PLAYER: $GOAL = $(cat players/$PLAYER/scored_goals/$GOAL)
    done
done
echo "my hidden goal:" $(ls players/$USER/hidden_goal)
echo

echo "Cards in hand:"
ls players/$USER/hand
echo

echo "Willpower: $(cat players/$USER/willpower)"
echo
