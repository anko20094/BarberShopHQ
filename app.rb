require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}	

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index 
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username=params[:name]
	@phone=params[:phone]
	@datetime=params[:date]
	@barber=params[:barber]
	@color=params[:color]

	hh = { 
		:name => 'Введіть ім\'я',
		:phone => 'Введіть телефон',
		:date => 'Введіть дату та час'
		}
		
		# для уожної пари ключ-знгачення
		# hh.each do |key, value|
		#   if params[key] == ''
		#     @error = hh[key]
		#   return erb :visit
		# end
		# end
	  
		@error = hh.select {|key,_| params[key] == ""}.values.join(", ")
		if @error != ''
		  return erb :visit
		end
	  
		@message = "Вітаю, Ви, #{params[:name]}, записалися! Дата візиту - #{params[:date]}"
		file = File.open './public/visit.txt', "a+"
		file.puts("Ім'я клієнта: #{@username}, номер телефону: #{@phone}, Ваш перукар #{@barber}, колір волосся #{@color}, дата візиту: #{@datetime}!")
		file.close
	  
		save_form_data_to_database
		erb "<h2><%=@message%></h2>"
end