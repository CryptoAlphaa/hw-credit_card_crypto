# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      it 'produces the same hash if hashed repeatedly' do
        cards.each do |card|
          hash1 = card.hash
          hash2 = card.hash
          assert_equal(hash1, hash2)
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'produces a different hash for each card' do
        hashes = cards.map(&:hash)
        assert_equal(hashes.uniq, hashes)
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      it 'produces the same cryptographic hash if hashed repeatedly' do
        cards.each do |card|
          hash1 = card.hash_secure
          hash2 = card.hash_secure
          assert_equal(hash1, hash2)
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'produces a different cryptographic hash for each card' do
        hashes = cards.map(&:hash_secure)
        assert_equal(hashes.uniq, hashes)
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      it 'produces a different hash and cryptographic hash for each card' do
        cards.each do |card|
          assert card.hash != card.hash_secure
        end
      end
    end
  end
end
