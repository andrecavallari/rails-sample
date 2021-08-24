# frozen_string_literal: true

class User < ApplicationRecord
  include BCrypt

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6, maximum: 12 }

  before_save :crypt_password

  private

  def crypt_password
    self.password = Password.create(password)
  end
end
