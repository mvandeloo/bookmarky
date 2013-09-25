require 'sinatra/base'

class BookmarkFuntime < Sinatra::Base
  get '/' do
    'Bookmark is fun'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
