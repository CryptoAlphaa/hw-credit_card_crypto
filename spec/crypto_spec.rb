# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  @key = 3

  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
  end

  # Define a list of ciphers to test
  ciphers = [
    { module: SubstitutionCipher::Caesar, name: 'Caesar cipher', key: @key },
    { module: SubstitutionCipher::Permutation, name: 'Permutation cipher', key: @key },
    { module: DoubleTranspositionCipher, name: 'Double Transposition Cipher', key: @key },
    { module: ModernSymmetricCipher, name: 'Modern Symmetric Cipher', key: ModernSymmetricCipher.generate_new_key }
  ]

  ciphers.each do |cipher|
    describe "Using #{cipher[:name]}" do
      it 'should encrypt card information' do
        enc = cipher[:module].encrypt(@cc, cipher[:key])
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        enc = cipher[:module].encrypt(@cc, cipher[:key])
        dec = cipher[:module].decrypt(enc, cipher[:key])
        _(dec).must_equal @cc.to_s
      end
    end

    next unless cipher[:name] == 'Modern Symmetric Cipher'

    # We want to test key generation for the ModernSymmetricCipher
    # Every new key should be different
    describe "Using #{cipher[:name]}" do
      it 'should generate a new key each time' do
        key1 = ModernSymmetricCipher.generate_new_key
        key2 = ModernSymmetricCipher.generate_new_key
        _(key2).wont_equal key1
      end
    end
  end

  describe 'Using Modern Symetric Cipher' do
    skkey = ModernSymmetricCipher.generate_new_key
    it 'should encrypt card information' do
      enc = ModernSymmetricCipher.encrypt(@cc, skkey)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = ModernSymmetricCipher.encrypt(@cc, skkey)
      dec = ModernSymmetricCipher.decrypt(enc, skkey)
      _(dec).must_equal @cc.to_s
    end
  end

end
