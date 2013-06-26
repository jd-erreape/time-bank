class CreateTimeBuckets < ActiveRecord::Migration
  def change
    create_table :time_buckets do |t|
      t.integer :time_left
      t.integer :time_locked
      t.integer :lock_version
      t.references :user, index: true

      t.timestamps
    end
  end
end
