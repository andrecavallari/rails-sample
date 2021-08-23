# frozen_string_literal: true

module JWT
  class DB
    TTL = ENV.fetch('JWT_DEFAULT_TTL', 864_000)
    NAMESPACE = ENV.fetch('JWT_DEFAULT_NAMESPACE', 'jwt')

    class << self
      delegate :hgetall, :ttl, to: :redis

      def create(user_id, token_properties)
        token_properties.merge!(user_id: user_id)
        uid, key = next_available_uid_key(user_id)
        redis.hmset(key, *token_properties)
        redis.expire(key, TTL)
        uid
      end

      def exists?(user_id, uid)
        redis.exists? get_key(user_id, uid)
      end

      def fetch(user_id, uid)
        redis.hgetall get_key(user_id, uid)
      end

      def destroy(user_id, uid)
        redis.del get_key(user_id, uid)
      end

      def reset_ttl(user_id, uid)
        redis.expire get_key(user_id, uid), TTL
      end

      def user_keys(user_id)
        redis.keys("#{NAMESPACE}:#{user_id}:*")
      end

      def clear
        redis.del redis.keys("#{NAMESPACE}:*")
      end

      private

      def get_key(user_id, uid)
        "#{NAMESPACE}:#{user_id}:#{uid}"
      end

      def next_available_uid_key(user_id)
        loop do
          uid = SecureRandom.hex(10)
          key = get_key(user_id, uid)
          return [uid, key] unless redis.exists?(key)
        end
      end

      def redis
        @redis ||= Redis.new url: ENV.fetch(
          'JWT_DB_REDIS_URL',
          'redis://localhost:6379/0'
        )
      end
    end
  end
end
