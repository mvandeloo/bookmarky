require 'sinatra/base'
require 'data_mapper'
require 'database_cleaner'



env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmarky#{env}")
require_relative 'link'
DataMapper.finalize
DataMapper.auto_upgrade!




class Bookmarky < Sinatra::Base
set :views, File.join(File.dirname(__FILE__), '..', 'views')

get '/' do
  @links = Link.all
  erb :index
end

  # start the server if ruby file executed directly
#   run! if app_file == $0
# end

post '/links' do
	url = params['url']
	title = params['title']
	Link.create(url: url, title: title)
	redirect to '/'
end

run! if app_file == $0

after do |scenario| 
 	DatabaseCleaner.clean
end

end
