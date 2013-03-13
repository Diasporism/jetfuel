module JetFuel
  class Url < ActiveRecord::Base
    validates :long_url, :short_url, :uniqueness => true, :presence => true

    def exists?
      Url.where(:long_url => long_url).count > 0
    end

  end
end