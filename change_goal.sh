if [ $1 -gt "$(cat players/$USER/willpower)" ]
then
    echo "You don't have enough willpower."
    exit 1
fi

if [ $1 -gt "$(ls goal_deck | wc -l)" ]
then
    echo "There are only $(ls goal_deck | wc -l | sed 's/ //g') goals left in the stack."
    exit 1
fi

WILL=$(expr $(cat players/$USER/willpower) - $1)
echo $WILL > players/$USER/willpower

for GOAL in $(ls goal_deck | sort -R | head -n $1)
do
    mv goal_deck/$GOAL players/$USER/hidden_goal
done

ls players/$USER/hidden_goal
KEEPER=__not_a_real_goal
while [ ! -e players/$USER/hidden_goal/$KEEPER ]
do
    read -p "Which goal would you like to keep?:" KEEPER
done

for GOAL in $(ls players/$USER/hidden_goal | grep -xv $KEEPER)
do
    mv players/$USER/hidden_goal/$GOAL goal_deck
done

if [ "$(cat players/$USER/willpower)" -eq 0 ]
then
    echo "Your willpower is exhausted."
else
    echo "You have $(cat players/$USER/willpower) willpower left."
fi
