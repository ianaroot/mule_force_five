class Guess < ActiveRecord::Base
  belongs_to :card
  belongs_to :round
end
