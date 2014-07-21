class Draw
	attr_accessor :hand
	def initialize
		@hand = Array.new(2) {Array.new}
	end
	def draw_card(hand=[[],[]])
		@hand = hand
		hand_size = @hand.first.size
		hand_size == 0 ? time = 2 : time = 1
		# puts " original hand was #{@hand}"
		for i in 0...time 
			@hand.first << RANKS[rand(RANKS.length)]
			@hand.last << SUITS[rand(SUITS.length)]
		end
		# puts " NEW hand is now #{@hand}"
		@hand
	end	
	def dealer_decide(hand)
		# dealer keep drawing card till hitting 17
		while calculate(hand) < 17
			hand.first << RANKS[rand(RANKS.length)]
			hand.last << SUITS[rand(SUITS.length)]
			calculate(hand)
		end
		hand
	end
end


