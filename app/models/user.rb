class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by("LOWER(email) = ?", email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
