class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = {}
  end

  def get(key)
    if @cache.key?(key)
      value = @cache.delete(key)
      @cache[key] = value # move to the end (most recently used)
      return value
    end
    -1 # Key not found
  end

  def put(key, value)
    if @cache.key?(key)
      @cache.delete(key)
    elsif @cache.size >= @capacity
      @cache.shift # remove the least recently used
    end
    @cache[key] = value
  end
end

