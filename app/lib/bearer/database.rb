# frozen_string_literal: true

module Bearer
  class Database
    class << self
      def jti(user_id)
        jti = next_available_jti
        redis.set("jti:#{jti}", user_id, ex: Config::EXPIRATION_TIME)
        jti
      end

      def user_id(jti)
        redis.get("jti:#{jti}")
      end

      def revoke(jti)
        redis.del("jti:#{jti}")
      end

      private

      # :nocov:
      def next_available_jti
        loop do
          hex = SecureRandom.alphanumeric(6)
          return hex unless redis.exists?("jti:#{hex}")
        end
      end
      # :nocov:

      def redis
        @redis ||= Redis.new(url: Config::REDIS_URL)
      end
    end
  end
end
