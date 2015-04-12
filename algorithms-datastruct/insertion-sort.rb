def insertion_sort integers
  (integers.length - 1).times do |n|
    j = n + 1
    key = integers[j]
    i = j - 1
    while i >= 0 && integers[i] < key
      integers[i + 1] = integers[i]
      i -= 1
    end
    integers[i+1] = key
  end
  integers
end

integers = [5,2,4,6,1,3]
p insertion_sort integers
integers = [200, 2, 50000, 10]
p insertion_sort integers
