class EventsController < ApplicationController

	def main
		@user = current_user
		@event = Event.where.not(user_id: current_user.id)
		# @events = Event.joins(:user).where("user_id != #{current_user.id}").select("users.first_name as first_name, events.name as name, events.description as description, events.when as when, events.where as where")
		@hosting = Event.where(user_id: current_user.id)
		@hash = Gmaps4rails.build_markers(@event) do |place, marker|
  			marker.lat place.latitude
  			marker.lng place.longitude
  		end
	end

	def new
	end

	def new2
		@item = Item.where(event_id: Event.last.id)
		@itemevent = Event.last.id
	end

	def show
		@event = Event.find(params[:id])
		@item = Item.where(event_id: params[:id])
		@attendees = Attendee.joins(:user).where(event_id: params[:id]).select("users.first_name as first_name, users.last_name as last_name, users.email as email")
	end

	def create
		Event.create(event_params)
		redirect_to "/events/#{current_user.id}/new2"
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(event_params)
			redirect_to "/events/#{current_user.id}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to :back
		end
	end

	def delete
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to "/events/#{current_user.id}"
	end

	private
		def event_params
			params.require(:event).permit(:name, :description, :when, :where, :user_id)
		end
		
end
