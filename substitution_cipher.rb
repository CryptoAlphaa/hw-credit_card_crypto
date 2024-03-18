# frozen_string_literal: true

module SubstitutionCipher
  # Cipher Using Caesar's Shift
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.chars.map { |char| (char.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.to_s.chars.map { |char| (char.ord - key).chr }.join
    end
  end

  # Cipher Using a table of random permutation
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      document = document.to_s
      table = (0..127).to_a.shuffle(random: Random.new(key)).zip(0..127).to_h
      document.each_char.with_index { |val, idx| document[idx] = table[val.ord].chr }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      table = (0..127).to_a.shuffle(random: Random.new(key)).zip(0..127).to_h
      document.each_char.with_index { |val, idx| document[idx] = table.key(val.ord).chr }
    end
  end
end

# create test case for Permutation
# puts SubstitutionCipher::Permutation.encrypt("hello", 1234)
# puts SubstitutionCipher::Permutation.decrypt("hello", 1234)
