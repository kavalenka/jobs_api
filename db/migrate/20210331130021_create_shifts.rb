class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.integer :job_id
      t.date :start_date
      t.integer :working_hours

      t.timestamps
    end
  end
end
