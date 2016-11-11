class UsersController < ApplicationController

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			flash[:messages] = ["You have successfully registered, please log in."]
			redirect_to "/loginreg"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/loginreg"
		end
	end

	def going
		going = Attendee.create(going_params)
		redirect_to "/events/#{current_user.id}"
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end

		def going_params
			params.require(:attendee).permit(:user_id, :event_id)
		end
		
end
