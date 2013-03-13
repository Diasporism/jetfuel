module JetFuel
  class Request < ActiveRecord::Base

    def self.count_all
      Request.group(:url).count.sort_by { |k, v| v}.reverse
    end

  end
end