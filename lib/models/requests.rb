module JetFuel
  class Request < ActiveRecord::Base

    def self.most_popular
      group('url').count.sort_by { |k,v| -v }
    end

    def self.most_recent
      order('created_at DESC').first(5)
    end

  end
end