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
	end
  
  def create
	  @team = Team.new(team_params)
	  @team.users << current_user
	  
	  if @team.save
		  flash[:success] = "Команда успешно создана!"
		  redirect_to root_path
	  else
		  render 'new'
	  end
	end
	
	def update
		@team = Team.find(params[:id])
		
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
		params.require(:team).permit(:teamTitle)
	end
end
