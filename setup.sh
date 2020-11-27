# usage: sh setup.sh $PLAYER1 $PLAYER2 ...
#
# set up the initial game state from scratch

mkdir -p card_deck
rm card_deck/* 2>/dev/null
cat cards.init.txt | grep -v \# | xargs -I CARD touch card_deck/CARD

mkdir -p goal_deck
rm goal_deck/* 2>/dev/null
cat goals.init.txt | grep -v \# | xargs -I GOAL touch goal_deck/GOAL

mkdir -p table_goals
rm table_goals/* 2>/dev/null
ls goal_deck | sort -R | head -n 2 | xargs -I GOAL mv goal_deck/GOAL table_goals

mkdir -p players
rm -r players/* 2>/dev/null
for PLAYER in "$@"
do
    mkdir players/$PLAYER
    mkdir players/$PLAYER/hand
    mkdir players/$PLAYER/stash
    mkdir players/$PLAYER/scored_goals
    mkdir players/$PLAYER/hidden_goal
    echo 6 > players/$PLAYER/willpower

    ls card_deck | sort -R | head -n 3 | xargs -I CARD mv card_deck/CARD players/$PLAYER/hand
    ls goal_deck | sort -R | head -n 1 | xargs -I GOAL mv goal_deck/GOAL players/$PLAYER/hidden_goal

done

chmod -R +rwX card_deck goal_deck table_goals players
