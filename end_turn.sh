# usage: sh end_turn.sh

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

if [ "$(ls players/$USER/hand | wc -l)" -eq 0 ] && [ ! -e players/$USER/scored_goal.flag ]
then
    WILL=$(expr $(cat players/$USER/willpower) + 2)
    echo $WILL > players/$USER/willpower
    echo "You rested and gained 2 willpower for a total of $(cat players/$USER/willpower)."
    echo "$USER rested and gained 2 willpower for a total of $(cat players/$USER/willpower)." >> messages.txt
fi

rm players/$USER/draw_phase.flag 2>/dev/null
rm players/$USER/free_discard.flag 2>/dev/null
rm players/$USER/scored_goal.flag 2>/dev/null
rm players/$USER/my_turn.flag 2>/dev/null

NEXTPLAYER=$((ls players; ls players) | grep -A1 $USER | grep -xv $USER | head -n 1)
if [ -n "$(ls players/*/provoked_goal 2>/dev/null)" ]
then
    PROVOKED="$(ls players/*/provoked_goal | sed -e 's#players/##' -e 's#/provoked_goal##')"
    echo "You provoked $PROVOKED and they must respond, then it's $NEXTPLAYER's turn."
    echo "$USER ended their turn, $PROVOKED is provoked, then it's $NEXTPLAYER's turn." >> messages.txt
else
    echo "It's $NEXTPLAYER's turn next."
    echo "$USER ended their turn, it's $NEXTPLAYER's turn next." >> messages.txt
fi
