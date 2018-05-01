class User < ActiveRecord::Base
  has_many :reviews
  validates :email, uniqueness: {case_sensitive: false}, presence: true
  validates :first_name, :last_name, presence: true
  validates :password_digest, length: { minimum: 3 }
  has_secure_password

  def authenticate_with_credentials(email, password)
    if (email && password)
      email = self.strip_whitespace.downcase
      User.create(first_name: "First", last_name: "Last", email: email, password: password)
    else
      nil
    end
  end

  def strip_whitespace
    self.email = self.email.strip unless self.email.nil?
  end
end
