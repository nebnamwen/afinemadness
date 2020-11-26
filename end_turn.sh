if [ "$(cat players/$USER/willpower)" -eq 0 ] && [ ! -e players/$USER/scored_goal.flag ] && [ "$(ls players/$USER/hand | wc -l)" -gt 0 ]
then
    echo "You are out of willpower and must score a goal before ending your turn."
    exit 1
fi

if [ -e players/$USER/scored_goal.flag ] && [ "$(ls players/$USER/hand | wc -l)" -gt 0 ]
then
    echo "You scored a goal and must discard your entire hand before ending your turn."
    exit 1
fi

rm players/$USER/draw_phase.flag 2>/dev/null
rm players/$USER/free_discard.flag 2>/dev/null
rm players/$USER/scored_goal.flag 2>/dev/null
rm players/$USER/my_turn.flag 2>/dev/null

if [ "$(ls players/$USER/hand | wc -l)" -eq 0 ]
then
    WILL=$(expr $(cat players/$USER/willpower) + 2)
    echo $WILL > players/$USER/willpower
    echo "You rested and gained 2 willpower for a total of $(cat players/$USER/willpower)."
fi
