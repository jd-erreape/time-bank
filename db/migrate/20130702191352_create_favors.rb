class CreateFavors < ActiveRecord::Migration
  def change
    create_table :favors do |t|
      t.string :title
      t.text   :description

      t.timestamps
    end
  end
end
