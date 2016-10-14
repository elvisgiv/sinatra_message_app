# for encryped
require "openssl"
require "base64"
include Base64
# for datetime
require 'date'

class Message < ActiveRecord::Base

  TIME_NOW = DateTime.current
  CLICK = 1

  ##
  scope :expired_actual, -> { where("expires_at > current_timestamp") }
  scope :visit_actual, -> { where("visit_count <= visit_total") }

  ### list
  def self.get_list
    q = Message.where('1=1')
    # paging
    q = q.order('id desc').limit(100)
    q
  end

  def self.message_encrypt(msg)
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

  def self.message_decrypt(key, iv, msg)
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

  def self.get_by_uid(uid)
    Message.where(uid: uid).first
  end

  ### for tests
  def self.random_string(n)
    (0...n).map { ('a'..'z').to_a[rand(26)] }.join
  end

end