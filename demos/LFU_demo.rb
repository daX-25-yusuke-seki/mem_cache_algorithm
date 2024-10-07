class LFUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = {}
    @frequency = Hash.new(0)
  end

  def get(key)
    if @cache.key?(key)
      @frequency[key] += 1
      value = @cache[key]
      puts "GET: #{key} => #{value} (Freq: #{@frequency[key]})"
      return value
    end
    puts "GET: #{key} => -1 (Not Found)"
    -1
  end

  def put(key, value)
    if @cache.size >= @capacity
      least_frequent = @frequency.min_by { |_, freq| freq }[0]
      puts "REMOVE: #{least_frequent} => #{@cache[least_frequent]} (Freq: #{@frequency[least_frequent]})"
      @cache.delete(least_frequent)
      @frequency.delete(least_frequent)
    end

    @cache[key] = value
    @frequency[key] = 1
    puts "PUT: #{key} => #{value} (Freq: #{@frequency[key]})"
  end

  def display
    puts "Cache State: #{@cache}"
    puts "Frequency: #{@frequency}"
  end
end

# Cache capacity is 5 
cache = LFUCache.new(5)

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

