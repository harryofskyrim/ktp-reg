class EventsController < ApplicationController
	def index
		@events = Event.all
	end
	
	def show
		@event = Event.find(params[:id])
	end
	
	def new
		@event = Event.new
	end
	
	def edit
		@event = Event.find(params[:id])
	end
	
	def create
		@event = Event.new(event_params)
		
		if @event.save
			redirect_to @event
		else
			render 'new'
		end
	end
	
	def update
		@event = Event.find(params[:id])
		
		if @event.update(event_params)
			redirect_to @event
		else
			render 'edit'
		end
	end
	
	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		
		redirect_to events_path
	end
	
	def addteam
		@event = Event.find(params[:event_id])
		@team = Team.find(params[:team_id])
		
		#		@team.users.each do |user|
		#			if @event.fathersNameReq and not user.fathersName.present? or
		#					@event.bornReq and not user.born.present? or
		#					@event.schoolReq and not user.school.present? or
		#					@event.groupReq and not user.group.present? or
		#					@event.teeSizeReq and not user.teeSize.present? or
		#					@event.phoneNumberReq and not user.phoneNumber.present?
		#				return
		#			end
		#		end
		
		@event.teams << @team
		
		@team.users.each do |user|
			@event.users << user
		end
		
		if @event.save
			redirect_to events_path
		else
			return
		end		
	end
		
	
	def register
		@event = Event.find(params[:format])
		@teams = Team.all
	end
	
	private
	def event_params
		params.require(:event).permit(:eventTitle, :eventType, :teamMinSize, :teamMaxSize, :dateStart, :dateEnd, :eventPlace, :eventDescription, :eventResults, :fathersNameReq, :bornReq, :schoolReq, :groupReq, :teeSizeReq, :phoneNumberReq, :schoolType)
	end
end
