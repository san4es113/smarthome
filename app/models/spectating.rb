class Spectating < ActiveRecord::Base
	belongs_to :usinfo
	geocoded_by :address
	after_validation :geocode
end
