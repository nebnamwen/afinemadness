# usage: sh start_turn.sh

touch players/$USER/my_turn.flag
touch players/$USER/draw_phase.flag
touch players/$USER/free_discard.flag
rm players/$USER/scored_goal.flag 2>/dev/null
