require 'singleton'

module Sdk
  class Device

    attr_accessor :secrect_key

    def initialize
      @secrect_key = Settings.device.secrect_key
    end

    # 解密
    def decryption(cipher)
      logger.info(cipher)

      des = OpenSSL::Cipher::Cipher.new('des-ede3')
      des.decrypt
      des.key = @secrect_key
      result = des.update(Base64.strict_decode64(cipher)) + des.final

      logger.info(result)

      if Nokogiri::XML(result).errors.empty?
        Hash.from_xml(result)
      else
        result
      end
    end

    # 加密
    def encryption(value)
      logger.info(value)

      des2 = OpenSSL::Cipher::Cipher.new('des-ede3')
      des2.encrypt
      des2.key = @secrect_key

      result = des2.update(value) + des2.final
      encoded = Base64.strict_encode64(result)
      logger.info(encoded)
      encoded
    end

    def logger
      @@logger ||= Logger.new('./log/device.log')
    end

  end
end
