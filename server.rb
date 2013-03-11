require 'lib/jet_fuel'

module JetFuel
  class Server < Sinatra::Base

    get '/' do
      'Hello, Dave.'
    end

  end
end

