# rubocop:disable Layout/EndOfLine
# frozen_string_literal: true

require 'rbnacl'
require 'base64'

# Module to perform Modern Symetric Cipher
module ModernSymmetricCipher
  def self.generate_new_key
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    key_base64 = Base64.strict_encode64(key)
    key_base64
    # TODO: Return a new key as a Base64 string
  end

  def self.encrypt(document, key)
    # use simplebox to encrypt the document
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    encrypted_message_base64 = Base64.strict_encode64(simple_box.encrypt(document.to_s))
    encrypted_message_base64
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
  end

  def self.decrypt(encrypted_cc, key)
    # use simplebox to decrypt the document
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    decrypted_message = simple_box.decrypt(Base64.strict_decode64(encrypted_cc))
    decrypted_message
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
  end
end

# rubocop:enable Layout/EndOfLine
