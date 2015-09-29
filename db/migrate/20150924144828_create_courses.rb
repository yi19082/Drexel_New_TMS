class CreateCourses < ActiveRecord::Migration
	def change
		create_table :courses do |t|
			t.string :name
			t.string :course_number
			t.string :pre_req
			t.string :instructor
			t.string :day
			t.string :time
			t.integer :crn
			t.string :type
			t.string :building
			t.string :room
			t.timestamps null: false
		end
		add_reference :courses, :term, index: true, foreign_key: true
	end
end
