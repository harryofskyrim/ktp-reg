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
	end
	
	def create
		@team = Team.new(team_params)
		@team.users << current_user
		
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
		else
			@team.users.delete(@user)
		end
		
#		if @team.update(team_params)
			redirect_to @team
#		else
#			render 'edit'
#		end
	end
	
	def destroy
		@team = Team.find(params[:id])
		@team.destroy
		
		redirect_to teams_path
	end
	
	private
	def team_params
		params.require(:team).permit(:teamTitle)
	end
end
