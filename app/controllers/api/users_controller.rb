module API
	class UsersController < APIController
		def index
			users = User.all
			respond_to do |format|
				format.json { render json: users, status: :ok } #200
			end
		end

		def show
			user = User.find(params[:id])
			respond_to do |format|
				format.json { render json: user, status: :ok } #200
			end
		end
	end
end