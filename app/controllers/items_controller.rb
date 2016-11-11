class ItemsController < ApplicationController
	def create
		item = Item.create(item_params)
		redirect_to :back
	end

	def bring
		item = Item.update(params[:id], bring_params)
		if item.errors.any?
			flash[:errors] = item.errors.full_messages
			redirect_to "/show/#{item.event.id}"
		else
			redirect_to "/show/#{item.event.id}"
		end
	end

	private
		def item_params
			params.require(:item).permit(:item, :status, :user_id, :event_id)
		end

		def bring_params
			params.require(:item).permit(:status, :user_id, :event_id)
		end
end
