class Usinfo < ActiveRecord::Base
	belongs_to :user
	has_many :gears
	has_many :spectatings
	has_many :states
end
