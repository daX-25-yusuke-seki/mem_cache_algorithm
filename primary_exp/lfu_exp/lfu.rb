class LFUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = {}
    @frequency = Hash.new(0)
  end

  def get(key)
    if @cache.key?(key)
      @frequency[key] += 1
      return @cache[key]
    end
    -1
  end

  def put(key, value)
    if @cache.size >= @capacity
      least_frequent = @frequency.min_by { |_, freq| freq }[0]
      @cache.delete(least_frequent)
      @frequency.delete(least_frequent)
    end

    @cache[key] = value
    @frequency[key] = 1
  end
end

