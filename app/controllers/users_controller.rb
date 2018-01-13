class UsersController < ApplicationController
	
	def index
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
	
	def show
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.new
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def create
		@user = User.new(user_params)
		
	if @user.save
			log_in @user
		flash[:success] = "Вы успешно зарегистрированы!"
			redirect_to root_path
		else
			render 'new'
		end
	end
	
	def update
	if params[:password].blank?
		params.delete(:password)
	end
		@user = User.find(params[:id])
		
		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		
		redirect_to users_path
	end
	
	private
	def user_params
		params.require(:user).permit(:lastName, :firstName, :fathersName, :email, :phone, :born, :school, :group, :teeSize, :password, :occupation, :password_confirmation)
	end
end
