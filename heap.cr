class Heap(T)
  property elements = Array(T).new
  property locs = Hash(T, Int32).new

  def peek? : T | Nil
    empty? ? nil : @elements.first
  end

  def min? : T | Nil
    el = peek?
    
    if el
      @locs[size - 1] = 0
      @locs.delete(el)

      @elements.swap(0, -1)
      @elements.pop

      _heapify_down
    end

    el
  end

  def push(el : T)
    @elements.push el
    @locs[el] = size - 1
    _heapify_up 
  end

  def delete(el : T)
    node = locs[el]
    if node
      @locs[@elements.last] = node != size - 1 ? node : size - 2
      #handle if it's the last item
      @locs.delete(el)
      @elements.swap(node, size - 1)
      @elements.delete(size - 1)

      parent = (node - 1) // 2

      if(@elements[node] < @elements[parent])
        _heapify_up
      else
        _heapify_down
      end
    end
  end

  def empty?
    @elements.empty?
  end

  def size
    @elements.size
  end

  private def _heapify_up
    node = size - 1
    loop do
      parent = (node - 1) // 2
      break if (parent < 0) || (@elements[parent] < @elements[node])
      @locs[@elements[parent]] = node
      @locs[@elements[node]] = parent
      @elements.swap(parent, node)
      node = parent
    end
  end

  private def _heapify_down
    node = 0
    loop do
      left_child = (2 * node) + 1
      right_child = (2 * node) + 2
 
      break if left_child > size
      smallest = left_child
      if right_child < size && @elements[right_child] < @elements[left_child]
        smallest = right_child
      end

      break if @elements[node] < elements[smallest]
      @locs[@elements[node]] = smallest
      @locs[@elements[smallest]] = node
      @elements.swap(node, smallest)
      node = smallest
    end
  end
end

h = Heap(Int32).new
h.push(2)
h.push(5)
h.push(7)
h.push(8)
h.push(10)
h.push(9)
# h.push(34)
# h.push(3)


puts h.elements

h.delete 10

puts h.elements