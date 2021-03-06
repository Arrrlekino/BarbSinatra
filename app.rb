#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

#class Client < ActiveRecord::Base 
#end 
#Added validation for c.save
class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true	
end
class Barber < ActiveRecord::Base
end	

before do
	@barbers = Barber.all
end

get '/' do
#	@barbers = Barber.all
#return order => @barbers = Barber.order "created_at_DESC"	
	erb :index			
end

get '/visit' do
	@c = Client.new
	erb :visit
end
post '/visit' do
	@c = Client.new params[:client]
	if @c.save
erb "<h2>Thanks!</h2>"
else
# First variant	
#erb "<h2>Sorry! There mistake ;-(</h2>"
# Second variant:
	@error = @c.errors.full_messages.first
	erb :visit
	end	
end
get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/bookings' do
#вывод в прямом порядке @clients = Client.all
	@clients = Client.order('created_at DESC') #вывод в обратном порядке, 
	erb :bookings
end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
end