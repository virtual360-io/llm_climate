class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  class << self
    def find_or_create_with_email_address(email)
      find_or_create_by(email_address: email) do |user|
        user.password = SecureRandom.hex(16)
      end
    end
  end
end
