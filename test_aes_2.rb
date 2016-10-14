require "openssl"
require "base64"

include Base64


plain_text = "The beatings will continue until morale improves"

cipher = OpenSSL::Cipher.new 'aes-128-cbc'
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
cipher_text = cipher.update(plain_text) + cipher.final
enc_msg = urlsafe_encode64(cipher_text)
enc_key = urlsafe_encode64(key)
cipher_text1 = Base64.encode64(cipher_text).encode('utf-8')


cipher = OpenSSL::Cipher.new 'aes-128-cbc'
cipher.decrypt
cipher.key = key
cipher.iv = iv
#decrypted_plain_text = cipher.update(cipher_text) + cipher.final
decrypted_plain_text1 = Base64.decode64 cipher_text1.encode('US-ASCII')
decrypted_plain_text = cipher.update(decrypted_plain_text1) + cipher.final
puts "AES128 in CBC mode"
puts "Key: " + urlsafe_encode64(key)
puts "Iv: " + urlsafe_encode64(iv)
puts "Plain text: " + plain_text
puts "Cipher text: " + urlsafe_encode64(cipher_text)
puts "Cipher text22222: " + decrypted_plain_text1

puts "Decrypted plain text: " + decrypted_plain_text
puts cipher_text
puts cipher_text1
