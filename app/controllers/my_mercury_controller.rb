class MyMercuryController < MercuryController
	before_filter :login_required

	def login_required
		true
	end
end