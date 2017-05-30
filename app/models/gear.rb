class Gear < ActiveRecord::Base
	belongs_to :usinfo
	has_many :makes

	geocoded_by :address
	after_validation :geocode
end
