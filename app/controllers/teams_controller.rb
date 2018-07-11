class TeamsController < ApplicationController
	
	def index
		@teams = Team.all
	end
	
	def show
		@team = Team.find(params[:id])
	end
	
	def new
		@team = Team.new
	end
	
	def edit
		@team = Team.find(params[:id])
		@users = User.all;
=begin
		@filterrific = initialize_filterrific(
			User,
			params[:filterrific],
			persistence_id: 'shared_key',
			default_filter_params: {},
			) or return
		@users = @filterrific.find.page(params[:page]).per_page(10)
		respond_to do |format|
			format.html
			format.js
		end
		rescue ActiveRecord::RecordNotFound => e
			puts "Had to reset filterrific params: #{ e.message }"
			redirect_to(reset_filterrific_url(format: :html)) and return
=end
	end
	
	def create
		@team = Team.new(team_params)
		@team.users << current_user
		@team.schoolType = current_user.occupation
		
		if @team.save
			flash[:success] = "Команда успешно создана!"
			redirect_to teams_path
		else
			render 'new'
		end
	end
	
	def update
		@user = User.find(params[:user_id])
		@team = Team.find(params[:id])
		if !@team.users.include? @user
			@team.users << @user
			if @team.schoolType == nil
				@team.schoolType = @user.occupation
			else
				if @team.schoolType != @user.occupation
					@team.schoolType = 'mixed'
				end
			end
		else
			@team.events.each do |event|
				event.users.delete(@user)
			end
			@team.users.delete(@user)
			@user.teams.delete(@team)
			if @team.users.length < 1
				@team.destroy
			else
				@team.schoolType = nil
				@team.users.each do |usr|
					if @team.schoolType == nil
						@team.schoolType = usr.occupation
					else
						if @team.schoolType != usr.occupation
							@team.schoolType = 'mixed'
						end
					end
				end
			end
		end
		if @team.update(team_params)
			redirect_to @team
		else
			render 'edit'
		end
	end
	
	def destroy
		@team = Team.find(params[:id])
		@team.destroy
		
		redirect_to teams_path
	end
	
	private
	def team_params
		params.fetch(:team, Hash.new).permit(:teamTitle, :schoolType)
	end
end
