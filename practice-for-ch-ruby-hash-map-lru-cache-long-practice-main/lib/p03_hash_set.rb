class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self.resize! if @count == @store.length
    i = self[key.hash]
    if !@store[i].include?(key)
      @store[i] << key
      @count += 1
    end
  end

  def include?(key)
    i = self[key.hash]
    @store[i].include?(key)
  end

  def remove(key)
    i = self[key.hash]
    if @store[i].include?(key)
      @store[i].delete(key)
      @count -= 1
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_size = self.num_buckets 
    new_arr = Array.new(new_size * 2) { Array.new }
    @store.each do |subarr|
      if !subarr.empty?
        subarr.each do |ele|
          key = ele.hash
          i = key % new_arr.length
          new_arr[i] << ele
        end
      end
    end
    @store = new_arr
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % self.num_buckets
  end
end