class College < ActiveRecord::Base
	has_many :subjects, dependent: :destroy
end
