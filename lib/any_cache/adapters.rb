# frozen_string_literal: true

# @api private
# @since 0.1.0
module AnyCache::Adapters
  require_relative 'adapters/basic'
  require_relative 'adapters/delegator'
  require_relative 'adapters/dalli'
  require_relative 'adapters/redis'
  require_relative 'adapters/redis_store'
  require_relative 'adapters/active_support_naive_store'
  require_relative 'adapters/active_support_file_store'
  require_relative 'adapters/active_support_redis_cache_store'
  require_relative 'adapters/active_support_memory_store'
  require_relative 'adapters/active_support_mem_cache_store'

  class << self
    # @param driver [Object]
    # @return [AnyCache::Adapters::Basic]
    #
    # @raise [AnyCache::UnsupportedCacheDriverError]
    #
    # @api private
    # @since 0.1.0
    # rubocop:disable Metrics/LineLength
    def build(driver)
      case
      when RedisStore.supported_driver?(driver)                   then RedisStore.new(driver)
      when Redis.supported_driver?(driver)                        then Redis.new(driver)
      when Dalli.supported_driver?(driver)                        then Dalli.new(driver)
      when ActiveSupportRedisCacheStore.supported_driver?(driver) then ActiveSupportRedisCacheStore.new(driver)
      when ActiveSupportMemoryStore.supported_driver?(driver)     then ActiveSupportMemoryStore.new(driver)
      when ActiveSupportFileStore.supported_driver?(driver)       then ActiveSupportFileStore.new(driver)
      when ActiveSupportMemCacheStore.supported_driver?(driver)   then ActiveSupportMemCacheStore.new(driver)
      when Delegator.supported_driver?(driver)                    then Delegator.new(driver)
      else
        raise AnyCache::UnsupportedCacheDriverError
      end
    end
    # rubocop:enable Metrics/LineLength
  end
end
