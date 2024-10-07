# lfu_spec.rb
require 'rspec'
require_relative 'lfu' # LFUCacheの実装ファイル

RSpec.describe LFUCache do
  before do
    @cache = LFUCache.new(2)
  end

  it "returns -1 when the key is not found" do
    expect(@cache.get(1)).to eq(-1)
  end

  it "adds new key-value pairs and returns the correct value" do
    @cache.put(1, 1)
    @cache.put(2, 2)
    expect(@cache.get(1)).to eq(1) # キー1の値を取得
  end

  it "removes the least frequently used item when capacity is reached" do
    @cache.put(1, 1)
    @cache.put(2, 2)
    @cache.get(1) # 使用頻度を上げる
    @cache.put(3, 3) # capacity reached, key 2 (least frequent) should be removed
    expect(@cache.get(2)).to eq(-1)
    expect(@cache.get(1)).to eq(1)
  end

  it "updates usage frequency and removes least frequent item correctly" do
    @cache.put(1, 1)
    @cache.put(2, 2)
    @cache.get(1) # キー1の使用頻度を上げる
    @cache.put(3, 3) # capacity reached, key 2 should be removed
    expect(@cache.get(1)).to eq(1)
    expect(@cache.get(2)).to eq(-1)
  end
end

