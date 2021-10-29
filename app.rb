require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {in: 3..20}
	validates :phone, {presence: true}
	validates :datestamp, {presence: true}
	validates :color, {presence: true}
end

class Barber < ActiveRecord::Base
end


class Contact < ActiveRecord::Base
	validates :name, {presence: true}
	validates :phone, {presence: true}
	validates :question, {presence: true}
end

# Задвання №1 29 урок тут
# def save_form_data_to_database (name, phone, date, barber, color)
# 	Client.create :name => name, :phone => phone, :datestamp => date, :barber => barber, :color => color
# end
# Задвання №2 29 урок тут
# def save_form_data_to_database_contacts (name, phone, question)
# 	Contact.create :name => name, :phone => phone, :question => question
# end


before do
	@barbers = Barber.all
end
# ---

get '/' do
	erb :index 
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do
	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Вітаю, Ви записалися!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end

	
	# Задвання №1 29 урок тут
	# save_form_data_to_database(@username, @phone, @datetime, @barber, @color)
	# ---
	
end

# Задвання №2 29 урок тут
get '/contacts' do
	@con = Contact.new
	erb :contacts
end

post '/contacts' do
	con = Contact.new params[:contact]
	if con.save
		erb "<h2>Ваше повідомлення доставлене!</h2>"
	else
		@error = con.errors.full_messages.first
		erb :contacts
	end
	# save_form_data_to_database_contacts(name, phone, question)
end
# ---


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