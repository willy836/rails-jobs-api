class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :position
      t.integer :status, default: 1
      t.integer :author_id

      t.timestamps
    end
  end
end
