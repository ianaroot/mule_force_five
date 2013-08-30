class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :deck_id
      t.integer :user_id
      t.integer :times_correct, default: 0
      t.integer :times_incorrect, default: 0
      t.timestamps
    end
  end
end
