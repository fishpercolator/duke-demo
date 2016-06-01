class CreateAwesomes < ActiveRecord::Migration
  def change
    create_table :awesomes do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
