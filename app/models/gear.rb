class Gear < ActiveRecord::Base
	belongs_to :usinfo
	has_many :makes
end
