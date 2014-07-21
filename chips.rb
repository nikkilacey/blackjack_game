class Chips
	attr_accessor :bet, :current_chips
	def initialize
		@current_chips = 100
		puts "You have #{@current_chips} chips to play!"
	end
	def display
		puts "You have #{@current_chips} chips left!"
	end
	def current_chips(bet=0)
		@bet = bet
 		@current_chips  # need to keep this , so i can compare 
	end

	def update_chips(result)
		case result
		when 'draw'  
			@current_chips += 0 
		when 'natural'  
			@current_chips += @bet*1.5
		when 'lose'  || 'busted'
			@current_chips -= @bet
		when 'win'  
			@current_chips += @bet
		end
		@current_chips
	end
end

