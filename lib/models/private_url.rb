module JetFuel

  class PrivateUrl < ActiveRecord::Base
    validates :long_url, :short_url, :presence => true
    validates :short_url, :uniqueness => true

    belongs_to :user

    def self.vanities_for_user(user_id)
      group('vanity_url').order('vanity_url')
    end

  end

end