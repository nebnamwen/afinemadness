==== A Fine Madness for Science ====

by Benjamin Newman

==== game rules (draft) ====

shuffle goals
shuffle parts

deal 2 goals face up

deal 1 secret goal and 3 cards to each player
(maybe deal more and choose?)

each player gets N??? self-control tokens to start

on your turn:

* you may draw any number of cards (incl 0) up to max(hand size - 1, 2)
    * when you draw, you choose how many cards in advance and draw all
    * you can draw from the deck or from your stash
        ? you must draw all cards from the same source
        ? when you draw from your stash you always shuffle it
* you may discard one (two?) card(s) for free
* you may discard any number of additional cards for 1 self-control each
    * when you discard, each card can go to the discard or your stash
        * how to stop the entire deck from ending up in stashes? limit?
* you may trade cards in hand 1:1 with other players

??? is there a self-control cost to just having a large hand size ???

* at the end of your turn, you _may_ score a goal
    * if you have zero self-control, you _must_ score a goal
* when you score, you score your entire hand
* explain how you use the parts in your hand to accomplish a goal
* cards you include in your explanation count for 1 point
* cards you are not able to fit into your explanation count for -1 (-2?)
* keep the goal card face up in front of you with the VP tokens on it

* at the end of your turn, if your hand size = 0, gain 1 (2?) self-control

* you can steal a goal from another player by overscoring its VP value
* if you steal a goal from another player and their hand size is enough to steal it back immediately, they must attempt to do so, immediately
    * you should be able to spend self-control to counter this, how much?

* when one player reaches a VP threshold (N???), finish the round

==== turn order summary ====

- draw (up to max(H - 1, 3), from deck or stash)
- trade (optional)
- discard (to deck or stash, 1st is free, rest cost willpower)
- score (required if out of willpower)

==== client usage ====

All scripts require that the current working directory is the base project directory

Set up the game:
    sh setup.sh $player1 $player2 ...

Start your turn:
    sh start_turn.sh

Draw:
    sh draw_deck.sh $N
    sh draw_stash.sh $N

Trade:
    sh trade_card.sh $player $card
    # this gives a card to the other player, they can then give a card to you

Discard:
    sh discard_deck.sh $card1 $card2 ...
    sh discard_stash.sh $card1 $card2 ...

Score a goal:
    sh score_goal.sh $goal $card1 $card2 ...
    # the goal must come first, but the rest of the line can be freeform
    # so you can type out your whole spiel and the cards you mention will be scored

End your turn:
    sh end_turn.sh
