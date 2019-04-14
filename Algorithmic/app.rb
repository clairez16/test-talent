require 'json'

def couples_from_unordered_array_summing_to(sum, array_of_integers)
  array_of_integers.map { |integer| array_of_integers.include?(sum - integer) ? [integer, sum - integer].sort : nil }
                   .compact
                   .uniq
end

def couples_from_ordered_array_summing_to(sum, array_of_integers)
  return if sum < 0

  truncated_array = array_of_integers.delete_if {|i| i > sum }

  truncated_array.map { |integer| truncated_array.include?(sum - integer) ? [integer, sum - integer].sort : nil }
                 .compact
                 .uniq
                 .flatten
                 .sum
end

def measure_speed_unordered
  file_content = File.read('unordered_integers.json')
  array = JSON.parse(file_content)

  start_time = Time.now
  10.times do
    couples_from_unordered_array_summing_to(8765, array)
  end
  p Time.now - start_time
end

def measure_speed_ordered
  file_content = File.read('ordered_positive_integers.json')
  array = JSON.parse(file_content)

  start_time = Time.now
  10.times do
    couples_from_ordered_array_summing_to(8765, array)
  end
  p Time.now - start_time
end

#Time complexity: A nombre égal d'élements dans le tableau, 10 itérations prennent 5.16s pour la première méthode et 0.25s pour la deuxième
