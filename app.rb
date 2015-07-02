require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
require './models'
require 'pry'

configure(:development) { set :database, "sqlite3:microblog.sqlite3" }

enable :sessions

use Rack::Flash, sweep: true


## SIGN UP SECTION

get '/sign-up' do
   erb :sign_up
end

post '/sign-up' do 

   username = params[:username]
   email = params[:email]
   birthday = params[:birthday]
   password = params[:password]
   confirmation = params[:confirm_password]

   if confirmation == params[:user][:password]
      @user = User.create(params[:user])
      "SIGNED UP! #{@user.username}"
   else
      "Your passwords do not match, please try again"
   end
end


# get '/signed-up' do
#    @username = params[:username]
# end

# SIGN IN SECTION

get "/" do
   if current_user
      @username = params[:username]
      erb :index
   else
      redirect '/sign-up'
   end
end


get '/sign-in' do
   erb :sign_in
end   

post '/sign-in' do
   username = params[:username]
   password = params[:password]

   @user = User.where(username: username).first

   if @user.password == password
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}!"
      redirect '/'
   else
      flash[:notice] = "Wrong login info, please try again"
      redirect '/sign-up'
   end
end

def current_user
   if session[:user_id]
      User.find session[:user_id]
   end
end



get '/profile-form' do
   erb :profile_form   
end

post '/profile-form' do
   #binding.pry
   @bio = params[:bio]
   @religion = params[:religion]
   @current_profile = Profile.create(bio: @bio, religion: params[:religion], user_id: current_user.id)
  
   redirect '/profile'
end

get '/profile' do
   #binding.pry
   @user = current_user
   #@bio = params[:bio]
   erb :profile
end

get '/signout' do
   session[:user_id] = nil
   "succesfully signed out"
end

