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
   bio = params[:bio]
   religion = params[:religion]
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
   @user = current_user
   if current_user
      @username = params[:username]
      erb :index
   else
      redirect '/sign-in'
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
      User.find(session[:user_id])
   end
end



get '/profile-form' do
   @user = User.find(session[:user_id])

   erb :profile_form   
end

post '/profile-form' do
   @user = current_user.update(params[:user])
   redirect '/profile'
end

get '/profile-form2' do
   erb :profile_form2
end

post '/profile-form2' do
   @user = User.destroy(session[:user_id])
   redirect '/sign-in'
end


get '/profile' do
   #binding.pry
   @user = current_user
   #@bio = params[:bio]
   erb :profile
end

# get '/post' do
#    erb :post
# end

post '/profile' do
   #binding.pry
   @posttext = params[:posttext]
   @username = params[:user_id]
   @current_post = Post.create(posttext: @posttext, user_id: current_user.id)
   @user = current_user

   erb :profile
end


get '/signout' do
   session[:user_id] = nil
   "Succesfully Signed Out"
end

get '/feed' do
   @posts = Post.all
   erb :feed
end

# post '/suspended' do
#    @user = User.destroy(session[:user_id])
#    erb :suspended
# end   








