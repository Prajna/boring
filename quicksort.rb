def quicksort(ary)
  return if ary.empty?

  pivot = ary.delete_at(rand(ary.size))
  left, right = ary.partition {|ele| ele < pivot}

  return *quicksort(left), pivot, *quicksort(right)
end

ary = [1,2,48,64,38,2,64,84,9,8,7,9,100,345]
p quicksort(ary)

# iterative implementation of binary search in Ruby

def binary_search(an_array, item)
    first = 0
    last = an_array.length - 1

    while first <= last
        i = (first + last) / 2

        if an_array[i] == item
            return "#{item} found at position #{i}"
        elsif an_array[i] > item
            last = i - 1
        elsif an_array[i] < item
            first = i + 1
        else
            return "#{item} not found in this array"
        end
    end
end


# recursive implementation of binary search in Ruby

def binary_search_recursive(an_array, item)
    first = 0
    last = an_array.length - 1

    if an_array.length == 0
        return "#{item} was not found in the array"
    else
        i = (first + last) / 2
        if item == an_array[i]
            return "#{item} found"
        else
            if an_array[i] < item
                return binary_search_recursive(an_array[i+1, last], item)
            else
                return binary_search_recursive(an_array[first, i-1], item)
            end
        end
    end
end

ary2 = [1,2,48,64,38,2,64,84,9,8,7,9,100,345].sort

class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end
