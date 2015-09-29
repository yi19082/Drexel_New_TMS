class Subject < ActiveRecord::Base
	belongs_to :college
	has_many :courses, dependent: :destroy
end
