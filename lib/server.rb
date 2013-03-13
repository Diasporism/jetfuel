require 'jet_fuel'

ENV['DATABASE_URL'] ||= "sqlite3:///db/database.sqlite"

module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :database, ENV['DATABASE_URL']

    get '/' do
      haml :index
    end

    post '/url' do
      @url = Url.find_by_long_url(params[:url])
      if @url.nil?
        short_url = SecureRandom.urlsafe_base64(6)
        while !Url.find_by_short_url(short_url).nil?
          short_url = SecureRandom.urlsafe_base64(6)
        end
        @url = Url.create(long_url: params[:url], short_url: short_url)
      end
      haml :url
    end

  end
end

