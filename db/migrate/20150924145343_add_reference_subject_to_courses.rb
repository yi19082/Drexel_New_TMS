class AddReferenceSubjectToCourses < ActiveRecord::Migration
  def change
  	change_table(:courses) do |t|
        t.references :subject
    end
 end
end
