class Course < ActiveRecord::Base
	belongs_to :subject
	belongs_to :term
end
