class AddIsCorrectAndRemoveUserIdGuessesTable < ActiveRecord::Migration
  def change
    remove_column :guesses, :user_id
    add_column :guesses, :is_correct, :boolean
  end
end
