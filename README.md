blackjack_game
==============

a blackjack game written in Ruby 

Introduction to files:
cards.rb - as a controller which contain all logistics 
1. Player decides to play this game or not. If yes, go ahead. If no, exit the program
2. Game continues (condition, current chips> 0, user wants to play another game)
3. At round 1, draw 2 cards for dealer (only shows dealer's upcard for now). Draw 2 cards for player. 
Then player decide whether to hit/stand
4. Check if either player/ dealer has 'natural' hand. If it does, check if player gets it. If yes, player is 
the winner, annouce current chip s/he has.
If dealer gets natural, annouce winner is dealer and player loses chips.
5. If player decides to hit, it keeps drawing card for the player till s/he enter 'stands'
6. When player 'stands', it activates dealer's draw card function. Dealer stops drawing when its hand value >=17
7. When this is done, compare both hands. Announce the winner.
8. Report if player loses/ wins and how much current chip s/he has right now.
9. Ask if player wants to continue to play, game wouldl restart again. If not, program exits.

Other files - contains helper functions
chips.rb - to set up initial chips as 100 and display/ update chips along the way
others.rb - to calculate hand value, get status on either natural/ busted hand, to update result to win/ lose/ draw
draw.rb - to draw first 2 cards, keeps drawing cards for dealer according to the rule (<17)


Bugs that I know of but no time to fix:
1.Player enter 'yes' for new game after finish first game, supposed to bring him/her back to the game again. It exits instead.
Improvement : I consider using while current_chips > 0 , the game continues itself. But when I run it, current_chips cannot be defined even I have define it along the codes.



