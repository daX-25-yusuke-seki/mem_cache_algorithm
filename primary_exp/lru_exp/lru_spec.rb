# lru_spec.rb
require 'rspec'
require_relative 'lru' # LRUCacheの実装ファイル

RSpec.describe LRUCache do
  before do
    @cache = LRUCache.new(2)
  end

  it "returns -1 when the key is not found" do
    expect(@cache.get(1)).to eq(-1)
  end

  it "adds new key-value pairs and returns the correct value" do
    @cache.put(1, 1)
    @cache.put(2, 2)
    expect(@cache.get(1)).to eq(1) # 最近使われたキー1を取得
  end

  it "removes the least recently used item when capacity is reached" do
    @cache.put(1, 1)
    @cache.put(2, 2)
    @cache.put(3, 3) # capacity reached, key 2 should be removed
    expect(@cache.get(2)).to eq(-1)
  end

  it "updates an existing key's value and moves it to most recently used" do
    @cache.put(1, 1)
    @cache.put(2, 2)
    @cache.put(1, 10) # Key 1 updated and moved to the most recently used
    @cache.put(3, 3)  # capacity reached, key 2 should be removed
    expect(@cache.get(1)).to eq(10)
    expect(@cache.get(2)).to eq(-1)
  end
end

