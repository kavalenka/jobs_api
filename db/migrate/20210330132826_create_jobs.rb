class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :rate_per_hour
      t.string :languages

      t.timestamps
    end
  end
end
