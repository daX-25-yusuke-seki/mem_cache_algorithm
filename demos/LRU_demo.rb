class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = {}
  end

  def get(key)
    if @cache.key?(key)
      value = @cache.delete(key)
      @cache[key] = value # Move to the end (most recently used)
      puts "GET: #{key} => #{value}"
      return value
    end
    puts "GET: #{key} => -1 (Not Found)"
    -1
  end

  def put(key, value)
    if @cache.key?(key)
      @cache.delete(key)
    elsif @cache.size >= @capacity
      removed = @cache.shift # Remove the least recently used
      puts "REMOVE: #{removed[0]} => #{removed[1]}"
    end
    @cache[key] = value
    puts "PUT: #{key} => #{value}"
  end

  def display
    puts "Cache State: #{@cache}"
  end
end

# Command line demo(cache limitation is 5) 
cache = LRUCache.new(5)

loop do
  puts "\nEnter command (get <key>, put <key> <value>, display, exit):"
  input = gets.chomp
  command = input.split

  case command[0]
  when "get"
    cache.get(command[1])
  when "put"
    cache.put(command[1], command[2])
  when "display"
    cache.display
  when "exit"
    break
  else
    puts "Invalid command."
  end
end

