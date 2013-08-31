require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :rounds
  has_many :decks, through: :rounds
  validates :email, uniqueness: true, format: { with: /^.+@.+[.].+$/,
    message: "Please enter a valid email address" }

  def password
    @password ||= Password.new(password_hash)
  end


  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def login(password)
    # @user = User.find_by_email(username)
    if self.password == password
      return self.id
    else
      nil
    end
  end
end
