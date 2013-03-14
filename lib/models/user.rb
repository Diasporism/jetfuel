module JetFuel
  class User < ActiveRecord::Base
    validates :username, :password, :presence => true
    validates :username, :uniqueness => true

    has_many :private_urls

    def self.exists?(username)
      User.where(:username => username).count > 0
    end

  end
end