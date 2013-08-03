class Users::IndexPresenter
	extend ActiveSupport::Memoizable

	def initialize(user)
		@user = user
	end

end