# usage: sh start_turn.sh

touch players/$USER/my_turn.flag
touch players/$USER/draw_phase.flag
touch players/$USER/free_discard.flag
rm players/$USER/scored_goal.flag 2>/dev/null

if [ "$(cat players/$USER/willpower)" -gt 0 ] && [ "$(ls players/$USER/hand | wc -l)" -gt 7 ]
then
    echo "You burned one willpower because your hand size is 8 or more."
    WILL=$(expr $(cat players/$USER/willpower) - 1)
    echo $WILL > players/$USER/willpower
fi
