class LfuLruCache
  Node = Struct.new(:key, :value, :freq)

  def initialize(capacity)
    @capacity = capacity
    @cache = {} # key -> Node
    @freq_map = {} # freq -> List of Nodes
    @min_freq = 0
  end

  def get(key)
    return nil unless @cache.key?(key)

    node = @cache[key]
    _update_node(node)
    node.value
  end

  def put(key, value)
    if @cache.key?(key)
      node = @cache[key]
      node.value = value
      _update_node(node)
    else
      if @cache.size >= @capacity
        _remove_least_frequent_node
      end
      new_node = Node.new(key, value, 1)
      @cache[key] = new_node
      _add_to_freq_map(new_node, 1)
      @min_freq = 1
    end
  end

  def status
    puts "Current Cache State:"
    @cache.each do |key, node|
      puts "Key: #{key}, Value: #{node.value}, Frequency: #{node.freq}"
    end
  end

  private

  def _update_node(node)
    freq = node.freq
    node.freq += 1
    _remove_from_freq_map(node, freq)
    _add_to_freq_map(node, node.freq)

    @min_freq += 1 if @freq_map[freq].nil? && freq == @min_freq
  end

  def _add_to_freq_map(node, freq)
    @freq_map[freq] ||= []
    @freq_map[freq] << node
  end

  def _remove_from_freq_map(node, freq)
    @freq_map[freq].delete(node)
    @freq_map.delete(freq) if @freq_map[freq].empty?
  end

  def _remove_least_frequent_node
    nodes = @freq_map[@min_freq]
    node_to_remove = nodes.shift

    @cache.delete(node_to_remove.key)
    @freq_map.delete(@min_freq) if nodes.empty?
  end
end

def main
  puts "LFU-LRU Cache Demo"
  print "Enter cache capacity: "
  capacity = gets.chomp.to_i
  cache = LfuLruCache.new(capacity)

  loop do
    print "Enter command (put <key> <value>, get <key>, status, exit): "
    input = gets.chomp
    command, *args = input.split

    case command
    when "put"
      key, value = args
      cache.put(key, value)
      puts "Put (#{key}, #{value})"
    when "get"
      key = args.first
      value = cache.get(key)
      if value.nil?
        puts "Key #{key} not found."
      else
        puts "Get: (#{key}, #{value})"
      end
    when "status"
      cache.status
    when "exit"
      puts "Exiting..."
      break
    else
      puts "Invalid command. Use 'put <key> <value>', 'get <key>', 'status', or 'exit'."
    end
  end
end

main

