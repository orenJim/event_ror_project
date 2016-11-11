class SessionsController < ApplicationController

	def index
	end

	def loginreg
	end

	def login
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/events/#{user.id}"
		else
			flash[:errors] = ["Invalid Combination"]
			redirect_to :back
		end
	end

	def logout
		reset_session
		redirect_to "/"
	end

	private
		def login_params
			params.require(:user).permit(:email, :password)
		end
		
end
