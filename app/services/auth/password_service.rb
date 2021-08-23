# frozen_string_literal: true

module Auth
  class PasswordService
    include BCrypt

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user.present? && valid_password? ? user : nil
    end

    private

    def user
      @user ||= User.find_by(email: @email)
    end

    def valid_password?
      Password.new(user.password) == @password
    end
  end
end
