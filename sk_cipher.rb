# frozen_string_literal: true

require 'rbnacl'
require 'base64'

# This module provides methods for symmetric encryption using RbNaCl
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    # use simplebox to encrypt the document
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    Base64.strict_encode64(simple_box.encrypt(document.to_s))
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    # use simplebox to decrypt the document
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    simple_box.decrypt(Base64.strict_decode64(encrypted_cc))
  end
end
