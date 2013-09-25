require 'sinatra/base'
require 'data_mapper'
require 'database_cleaner'



env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmarky_#{env}")
require_relative 'link'
require_relative 'tag'
require_relative 'user'
DataMapper.finalize
DataMapper.auto_upgrade!


class Bookmarky < Sinatra::Base
set :views, File.join(File.dirname(__FILE__), '..', 'views')

get '/' do
  @links = Link.all
  erb :index
end

get '/tags/:text' do
  tag = Tag.first(:text => params[:text])
  @links = tag ? tag.links : []
  erb :index
end

get '/users/new' do
  # note the view is in views/users/new.erb
  # we need the quotes because otherwise
  # ruby would divide the symbol :users by the
  # variable new (which makes no sense)
  erb :"users/new"
end

post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map do |tag|
  # this will either find this tag or create
  # it if it doesn't exist already
  Tag.first_or_create(:text => tag)
end
Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end

post '/users' do
  User.create(:email => params[:email], 
              :password => params[:password])
  redirect to('/')
end

run! if app_file == $0

end
