class Usinfo < ActiveRecord::Base
	belongs_to :user
	has_many :gears
end
