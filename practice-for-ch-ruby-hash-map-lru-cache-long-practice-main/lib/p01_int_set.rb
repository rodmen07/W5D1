class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num)
      # num_idx = @store.index(num) 
      @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if !is_valid?(num)
    # num_idx = @store.index(num) 
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    @store.length == @store.length + 1
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % 20
    @store[i] << num
  end

  def remove(num)
    i = num % 20
    @store[i].delete(num)
  end

  def include?(num)
    i = num % 20
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self.resize! if @count == @store.length
    i = num % self.num_buckets
    if !@store[i].include?(num)
      @store[i] << num 
      @count += 1
    end
  end

  def remove(num)
    i = self[num]
    if @store[i].include?(num)
      @store[i].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    i = self[num]
    @store[i].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_size = self.num_buckets 
    new_arr = Array.new(new_size * 2) { Array.new }
    @store.each do |subarr|
      num = subarr[0]
      i = num % new_arr.length
      new_arr[i] << num
    end
    
    @store = new_arr
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % self.num_buckets
  end
end