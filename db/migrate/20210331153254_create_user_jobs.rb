class CreateUserJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_jobs do |t|
      t.belongs_to :user, index: true
      t.belongs_to :job, index: true

      t.timestamps
    end
  end
end
