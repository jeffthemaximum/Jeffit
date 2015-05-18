class Link < ActiveRecord::Base
    acts_as_votable
    belongs_to :user
    has_many :comments

    def url_with_protocol(url)
      /^http/i.match(url) ? url : "http://#{url}"
    end
end
