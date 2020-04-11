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
#	@c = Client.new
	erb :visit
end
post '/visit' do
	c = Client.new params[:client]
	c.save

erb "<h2>Thanks!</h2>"	
end
get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/bookings' do
	@clients = Client.order('created_at DESC')
	erb :bookings
end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
end