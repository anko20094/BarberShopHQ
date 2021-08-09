require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}	

class Client < ActiveRecord::Base
	validates :name, {presence: true}
	validates :phone, {presence: true}
	validates :datestamp, {presence: true}
	validates :color, {presence: true}
	# validates :name, {presence: true}
end

class Barber < ActiveRecord::Base
end


class Contact < ActiveRecord::Base
end

# Задвання №1 29 урок тут
def save_form_data_to_database (name, phone, date, barber, color)
	Client.create :name => name, :phone => phone, :datestamp => date, :barber => barber, :color => color
end
# Задвання №2 29 урок тут
def save_form_data_to_database_contacts (name, phone, question)
	Contact.create :name => name, :phone => phone, :question => question
end


before do
	@barbers = Barber.all
end
# ---

get '/' do
	erb :index 
end

get '/visit' do
	erb :visit
end

post '/visit' do
	c = Client.new params[:client]
	c.save

	
	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")
	if @error != ''
		return erb :visit
	end
	
	@message = "Вітаю, Ви, #{params[:name]}, записалися! Дата візиту - #{params[:date]}"

	# Задвання №1 29 урок тут
	save_form_data_to_database(@username, @phone, @datetime, @barber, @color)
	# ---
	erb "<h2><%=@message%></h2>"
end

# Задвання №2 29 урок тут
get '/contacts' do
	erb :contacts
end

post '/contacts' do
	c = Contact.new params[:contact]
	c.save

	save_form_data_to_database_contacts(name, phone, question)
	erb :contacts
end
# ---