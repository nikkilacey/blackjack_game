def calculate(hand) 
	ace_count = 0
	hand_value = 0
	hand.first.inject(0) do |sum, rank| 
		if (rank == :J) || (rank == :Q) || (rank == :K)
			sum += 10
		elsif (rank == :ace)
			ace_count += 1 
			sum += 11
		else 
			sum += rank
		end	
		hand_value = sum
	end
	while hand_value > 21 && ace_count > 0
		hand_value -= 10
		ace_count -= 1 
	end
	hand_value
end

def status(hand)  
	if calculate(hand) == 21 && hand.length == 2  
		status = "natural"
	elsif calculate(hand) > 21 
		status = "busted"
	else
		status = calculate(hand)
	end
	status 
end

def update_result(player_hand, dealer_hand) 
	if status(player_hand) == "natural" && status(dealer_hand) == "natural"
		 result = 'draw'
	elsif status(player_hand) == "natural" && status(dealer_hand) != "natural"
		result = 'win'
	elsif status(player_hand) != "natural" && status(dealer_hand) == "natural"
		result = 'lose'

	# this will only work on hand.size > 2 
	elsif status(player_hand) == "busted" 
		result = 'lose'
	elsif status(dealer_hand) == "busted" 
		result = 'lose'
	elsif status(player_hand) == status(dealer_hand) 
		result = 'draw'	
	elsif status(player_hand) > status(dealer_hand)
		result = 'win'
	elsif status(player_hand) < status(dealer_hand)
		 result = 'lose'
	end
	result
end