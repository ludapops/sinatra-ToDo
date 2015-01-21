require 'sinatra'
require 'pry'
require 'awesome_print'
require 'sinatra/reloader' if development?
require 'yaml/store'

def current_user
	'mike'
end

get '/' do 
	erb :index
end 

post '/added' do 
	# binding.pry
	data = YAML::Store.new("data.yml")
	data.transaction do 
		data[:todos] = {current_user.to_sym => params[:todos]}
	end
	
	redirect to('/todo')
end 

get '/todo' do
	readData = IO.read('data.yml')
	@data = readData.split()

	 erb :todo
end 
