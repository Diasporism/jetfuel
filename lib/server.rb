ENV['DATABASE_URL'] ||= "sqlite3:///db/database.sqlite"

module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :database, ENV['DATABASE_URL']
    set :sessions, true
    set :session_secret, 'secret'

    get '/' do
      @popular = Request.most_popular
      @recent = Request.most_recent
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
      Request.create(url: params[:url])
      @popular = Request.most_popular
      @recent = Request.most_recent
      haml :url
    end

    post '/user/url' do
      @url = PrivateUrl.find_by_long_url_and_vanity_url(params[:url], params[:vanity_url])
      if @url.nil?
        short_url = "#{params[:vanity_url]}#{SecureRandom.urlsafe_base64(6)}"
        while !PrivateUrl.find_by_short_url(short_url).nil?
          short_url = "#{params[:vanity_url]}#{SecureRandom.urlsafe_base64(6)}"
        end
        @url = PrivateUrl.create(long_url: params[:url], short_url: short_url, vanity_url: params[:vanity_url])
      end
      @popular = Request.most_popular
      @recent = Request.most_recent
      haml :user_url
    end

    get '/redirect/:short_url' do
      url = Url.find_by_short_url(params[:short_url])
      redirect "http://#{url.long_url}"
    end

    get '/register' do
      haml :register
    end

    post '/register' do
      if params[:password] != params[:confirm_password]
        redirect '/register'
      elsif User.exists?(params[:username])
        redirect '/register'
      else
        password = params[:password]
        username = params[:username]
        User.create(username: username, password: password)
        @user = User.find_by_username_and_password(username, password)
        @vanities = PrivateUrl.vanities_for_user(@user[:id])
        haml :user
      end
    end

    get '/login' do
      @user = User.find_by_username_and_password(params[:username], params[:password])
      if @user.nil?
        haml :invalid_login
      else
        @vanities = PrivateUrl.vanities_for_user(@user[:id])
        haml :user
      end
    end


    def current_user

    end

  end
end

