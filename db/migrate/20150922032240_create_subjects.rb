class CreateSubjects < ActiveRecord::Migration
	def change
		create_table :subjects do |t|
			t.string :name
			t.timestamps null: false
		end

		add_reference :subjects, :college, index: true, foreign_key: true
	end
end
