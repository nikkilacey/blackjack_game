require './chips.rb'
require './draw.rb'
require './others.rb'

RANKS = (2..10).to_a.push(:ace, :J, :Q, :K) 
SUITS = ["c", "h", "d", "s"]

answer = nil 
play_now = true

# for first time player and returning player
if !(answer) || (play_now)
	if !(answer)
		puts "Welcome to Casino! Would you like to play blackjack?"
		answer = gets.chomp.downcase
		until (answer == 'yes') || (answer == 'no')
			puts "I don't understand what you mean, please tell me yes/ no"
			puts "Welcome to Casino! Would you like to play blackjack?"
			answer = gets.chomp.downcase
		end

		if answer == 'yes' 
			player_chips = Chips.new() 
		# elsif play_now 
		# 	player_chips = current_chips
		else 
			puts "No problem. Next time!"
			exit
		end

		puts "How much would you like to bet?"
		bet_request = gets.chomp.to_i
		# ensure player has enough chips to player the game
		until bet_request.between?(1, player_chips.current_chips) do
			puts "Sorry, you either don't have enough chips to play OR you have to bet at least 1 chip"
			bet_request = gets.chomp.to_i
		end
		player_chips.current_chips(bet_request)
	end # end of !(answer)
end
	puts "*********** Dealer's hand **************"
	dealer_hand = Draw.new
	dealer_new_hand = dealer_hand.draw_card
	dealer_hand_value = calculate(dealer_new_hand)
	puts "Dealer's upcard(s) is/are #{dealer_new_hand.first[1]}~#{dealer_new_hand.last[1]} and hand_value is #{dealer_hand_value}"
	puts "*********** Player's hand **************"
	testing = Draw.new
	new_hand = testing.draw_card
	for i in 0...new_hand.first.length  
		puts "Your hand is #{new_hand.first[i]}~#{new_hand.last[i]}"
	end
	player_hand_value = calculate(new_hand)
	puts "Player's hand value is #{player_hand_value}"
	puts "new hand is now -- #{new_hand}"

	# check if player got natural after bother dealer and player have 2 cards 
	result = update_result(new_hand, dealer_new_hand)
	status = status(new_hand)
	if status == 'natural'
		puts "Congratulations! You just won the game! You got a natural!"
		player_chips.update_chips(result)
		player_chips.display	
		puts "Would you like to play another game?"
		play_again = gets.chomp.downcase
		until (play_again == 'yes') || (play_again == 'no')
			puts "I don't understand what you mean, please tell me yes/ no"
			play_again = gets.chomp.downcase
		end	
		if play_again == 'no'
			puts "It's ok, next time!"
			exit
		else
			puts "Let's play another game!"
		end
	else
		# if player does not have natural, ask player to hit/ stand
		puts "*********** It's player's turn now ************"
		puts "Hi, Player! Would you like to stand or hit?"
		player_decision = gets.chomp.downcase

		# if not hit/ stand, keep asking.
		until (player_decision == 'hit') || (player_decision == 'stand')
			puts "Please only choose 'hit' OR 'stand'"
			player_decision = gets.chomp.downcase
		end
		# when user enter 'hit', keep drawing.
		while player_decision == 'hit' 
			if player_decision == 'hit' 
				player_hand = testing.draw_card(new_hand)  
				puts "new player hand is #{player_hand}"
				player_hand_value = calculate(player_hand)
				puts "Player's new hand value is #{player_hand_value}"	
				if status(player_hand) == 'busted'
					puts "Not good.. It's busted!!!!"
					result = update_result(player_hand, dealer_new_hand)
					player_chips.update_chips(result)
					player_chips.display
					puts "Would you like to play another game?"
					play_again = gets.chomp.downcase
					until (play_again == 'yes') || (play_again == 'no')
						puts "I don't understand what you mean, please tell me yes/ no"
						play_again = gets.chomp.downcase
					end	
					player_decision = 'quit'	
				else
					puts "Hi, Player! Would you like to stand or hit?"
					player_decision = gets.chomp.downcase
					until (player_decision == 'hit') || (player_decision == 'stand')
						puts "Please only choose 'hit' OR 'stand'"
						player_decision = gets.chomp.downcase
					end			
				end		

				if play_again == 'yes' 
					current_chips = player_chips.current_chips(bet_request)
					puts "player wants to play again"
					play_now = true
					# play_now
					#  do it all over again?
				elsif play_again == 'no' 
					puts "See you next time!"
					exit
				end
				
			end
		end  # end of while player_decision == 'hit' 
		# when player decide to stop, dealer's turn starts
		if player_decision == 'stand'
			puts "*********** It's dealer's turn now ************"
			dealer_new_hand = dealer_hand.dealer_decide(dealer_new_hand)
			# puts dealer_new_hand
			puts "Dealer's just drew one more card, current upcards are "
			for i in 1...dealer_new_hand.first.length 
				puts "#{dealer_new_hand.first[i]}~#{dealer_new_hand.last[i]}"
			end

			dealer_hand_value = calculate(dealer_new_hand)
			puts "Dealer's hand is #{dealer_new_hand}"
			puts "Dealer's hand value is #{dealer_hand_value}"
			# compare dealer and player's hand - deliver who is the winner
			result = update_result(new_hand, dealer_new_hand)
			player_chips.update_chips(result)
			puts "You just #{result} !!"
			player_chips.display
			puts "Would you like to play another game?"
			play_again = gets.chomp.downcase
			until (play_again == 'yes') || (play_again == 'no')
				puts "I don't understand what you mean, please tell me yes/ no"
				play_again = gets.chomp.downcase
			end	
		end		# end of player_decision == 'stand'
	end # end of if status == 'natural'



