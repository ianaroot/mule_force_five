class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :deck_id
      t.integer :user_id
      t.integer :times_correct
      t.integer :times_incorrect
      t.timestamps
    end
  end
end
