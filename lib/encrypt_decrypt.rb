# for encryped
require "openssl"
require "base64"
include Base64

class EncryptDecrypt < ActiveRecord::Base

  def self.for_encrypt(msg)
    #
    cipher = OpenSSL::Cipher.new 'aes-128-cbc'
    cipher.encrypt
    key = cipher.random_key
    iv = cipher.random_iv
    cipher_text = cipher.update(msg) + cipher.final
    # encoding to utf-8 for save in DB
    key_db = Base64.encode64(key).encode('utf-8')
    iv_db = Base64.encode64(iv).encode('utf-8')
    cipher_text_db = Base64.encode64(cipher_text).encode('utf-8')
    #
    return [key_db, iv_db, cipher_text_db]
  end

  def self.for_decrypt(key, iv, msg)
    # encoding to US-ASCII for decrypt
    key_asc = Base64.decode64 key.encode('US-ASCII')
    iv_asc = Base64.decode64 iv.encode('US-ASCII')
    msg_asc = Base64.decode64 msg.encode('US-ASCII')
    # work
    cipher = OpenSSL::Cipher.new 'aes-128-cbc'
    cipher.decrypt
    cipher.key = key_asc
    cipher.iv = iv_asc
    decrypted_plain_text = cipher.update(msg_asc) + cipher.final
    #
    decrypted_plain_text
  end

end