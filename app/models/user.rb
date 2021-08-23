# frozen_string_literal: true

class User < ApplicationRecord
  include BCrypt

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6, maximum: 12 }

  before_save :crypt_password

  def self.login(email, password)
    user = User.find_by(email: email)
    return false unless user

    password == Password.new(user.password) ? user : false
  end

  def valid_password?(password_param)
    password_param == Password.new(password)
  end

  private

  def crypt_password
    self.password = Password.create(password)
  end
end
