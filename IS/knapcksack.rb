require 'pry'
require 'random/online'

MUTATION_PERCENTAGE = 20
SELECTION_HARSHNESS = 2.0 / 3

class RandomGenerator
  RANDOM_NUMBERS_PER_QUERY = 1_000

  attr_accessor :binary_randoms
  attr_reader :random_generator

  def initialize
    @random_generator = RealRand::RandomOrg.new
    # @binary_randoms   = query_binary_numbers
  end

  def get_binary_values(n)
    refil_binary_randoms if binary_randoms.size <= n

    res = binary_randoms.first(n)
    binary_randoms = binary_randoms[n..-1]
    res
  end

  def get_binary_value
    refil_binary_randoms if binary_randoms.empty?

    binary_randoms.shift
  end

  def refil_binary_randoms
    binary_randoms.concat(query_binary_numbers)
  end

  def query_binary_numbers
    random_generator.randnum(RANDOM_NUMBERS_PER_QUERY, 0, 1)
  end

  def binary_value
    0 == get_binary_value
  end

  def random_in(from, to)
    random_generator.randnum(1, from, to)
  end
end


class Array; def second; self[1]; end; end

class Thief
  attr_accessor :bag_size, :genes, :population
  attr_reader :random_generator

  def initialize(bag_size, genes)
    @bag_size         = bag_size
    @genes            = genes
    @random_generator = RandomGenerator.new

    @population       = initialize_population(genes)
  end

  def strategize
    alltime_favourite = population.first.clone
    generation        = 0
    loop do
      generation += 1

      runner_up = population.fittest
      if runner_up.fitness > alltime_favourite.fitness || (runner_up.fitness == alltime_favourite.fitness && runner_up.size < alltime_favourite.size)
        alltime_favourite = runner_up.clone
      end

      print "\n\n-------------GENERATION #{generation}'s FAVOURITE---------------\n"
      print "#{population.fittest}\n\n"
      print "#{population.fittest.dna}\n\n"
      print population.to_s


      evaluate_fitness
      selection
      crossover_and_mutation
    end
  end

  private

  def initialize_population(genes, last_failed = 0)
    population                = OrderedArray.new
    Specimen.genes            = genes
    Specimen.max_size         = bag_size
    Specimen.random_generator = random_generator

    # generate the dnas for every speciem in one go
    size_for_all_dnas = genes.size ** 2
    random_dnas = Array.new(size_for_all_dnas)
    # random_dnas.map! { |_| random_generator.binary_value } QUOTA EXCEEDED
    random_dnas.map! { |_| rand(0..1) == 0 }

    if last_failed != 0
      random_dnas.each_with_index do |random_dna, i|
        random_dnas[i] = false if random_dna && rand(0..last_failed) > 0
      end
    end

    # break up the different dnas
    random_dnas.each_slice(genes.size).each { |dna| population << Specimen.new(dna, Specimen.calculate_fitness(dna)) }

    # adjust the initial population so it's in the weight limit and is bigger than one fifth of the genes' count
    if population.all?(&:too_heavy?) || population.select { |a| a.size <= bag_size }.count < genes.size / 5
      initialize_population(genes, last_failed + 1)
    else
      population
    end
  end

  def evaluate_fitness
    population.each do |specimen|
       genes_in_specimen = genes.zip(specimen.dna).select { |genes_and_dna| genes_and_dna.second }.map(&:first)

       specimen.fitness  = genes_in_specimen.reduce(0) { |sum, gene| sum + gene.first }

       specimen.fitness = -1 if specimen.size > bag_size
    end
  end

  def selection
    population.reject!(&:too_heavy?)
    number_of_survivals_after_selection = (genes.size * SELECTION_HARSHNESS).floor

    return if population.size < number_of_survivals_after_selection

    fittest = population.fittest
    if population.all? { |specimen| specimen.fitness == fittest.fitness && specimen.size == fittest.size }
      pop_size = population.size
      die = pop_size / 3 * 2

      die.times { population.pop }

      size_for_all_dnas = genes.size * (pop_size - die)
      random_dnas = Array.new(size_for_all_dnas)
      # random_dnas.map! { |_| random_generator.binary_value } QUOTA EXCEEDED
      random_dnas.map! { |_| rand(0..1) == 0 }

      # break up the different dnas
      random_dnas.each_slice(genes.size).each { |dna| population << Specimen.new(dna, Specimen.calculate_fitness(dna)) }
      return
    end

    (population.size - number_of_survivals_after_selection).times { population.pop }
  end

  def crossover_and_mutation
    (population.size / 2).times do
      specimen_a = choose_specimen_from(population)
      specimen_b = choose_specimen_from(population.without(specimen_a))

      child = Specimen.child_of(specimen_a, specimen_b)
      population << child
    end
  end

  def create_reproduction_array(population)
    Array.new(population.size).tap do |reproduction_array|
      reproduction_array[0] = population.first.fitness

      population.each_with_index do |specimen, i|
        next if i == 0
        reproduction_array[i] = reproduction_array[i - 1] + specimen.fitness
      end
    end
  end

  def choose_specimen_from(population)
    reproduction_array = create_reproduction_array(population)

    # gods_will = random_generator.random_in(1, reproduction_array.last).first
    gods_will = rand(1..reproduction_array.last)

    population[reproduction_array.procreation_of_the_fittest(gods_will)]
  end
end

class Specimen
  attr_accessor :dna, :fitness, :size

  def initialize(dna, fitness)
    @dna     = dna
    @fitness = fitness
    @size    = Specimen.calculate_size(dna)
  end

  def self.random_generator=(generator)
    @@random_generator = generator
  end

  def self.random_generator
    @@random_generator
  end

  def self.genes=(genes)
    @@genes = genes
  end

  def self.genes
    @@genes
  end

  def self.max_size=(max_size)
    @@max_size = max_size
  end

  def self.max_size
    @@max_size
  end

  def too_heavy?
    fitness == -1
  end

  def self.child_of(a, b)
    parents_dnas = [a.dna, b.dna]
    child_dna    = Array.new(genes.size)

    # (0...genes.size).each { |i| child_dna[i] = parents_dnas[random_generator.get_binary_value][i] } QUOTA EXCEEDED
    (0...genes.size).each { |i| child_dna[i] = parents_dnas[rand(0..1)][i] }

    specimen = Specimen.new(child_dna, Specimen.calculate_fitness(child_dna))
    specimen.mutate? ? specimen.mutate! : specimen
  end

  def mutate!
    print "\nMUTATION\n"

    mutation_index = rand(0...dna.size)
    dna[mutation_index] = !dna[mutation_index]

    @size = Specimen.calculate_size(dna)
    @fitness = Specimen.calculate_fitness(dna)

    mutate? ? mutate! : self
  end

  def mutate?
    # Specimen.0.random_in(0, 99).first < MUTATION_PERCENTAGE QUOTA EXCEEDED
    rand(0..99) < MUTATION_PERCENTAGE
  end

  def calculate_size
    Specimen.genes.zip(dna).select { |genes_and_dna| genes_and_dna.second }.map(&:first).reduce(0) { |sum, gene| sum + gene.second }
  end

  def calculate_fitness
    fitness = genes.zip(dna).select { |genes_and_dna| genes_and_dna.second }.map(&:first).reduce(0) { |sum, gene| sum + gene.first }

    size(dna) > max_size ? -1 : fitness
  end

  def self.calculate_fitness(dna)
    fitness = genes.zip(dna).select { |genes_and_dna| genes_and_dna.second }.map(&:first).reduce(0) { |sum, gene| sum + gene.first }

    calculate_size(dna) > max_size ? -1 : fitness
  end

  def self.calculate_size(dna)
    genes.zip(dna).select { |genes_and_dna| genes_and_dna.second }.map(&:first).reduce(0) { |sum, gene| sum + gene.second }
  end

  def to_s
    "FITNESS: #{fitness}---SIZE: #{size}"
  end
end

class OrderedArray
  include Enumerable

  attr_reader :array

  def initialize
    @array = []
  end

  def <<(obj)
    array.each_with_index do |other_obj, i|
      if obj.fitness > other_obj.fitness || (obj.fitness == other_obj.fitness && obj.size < other_obj.size)
        array.insert(i, obj)
        return
      end
    end

    # array is empty or object is lowest
    array << obj
  end

  def pop
    array.pop
  end

  def size
    array.size
  end

  def each(&block)
    array.each(&block)
  end

  def fittest
    array.first
  end

  def [](index)
    array[index]
  end

  def reject!(&block)
    array.reject!(&block)
  end

  def without(obj)
    clone = array.clone

    clone.delete(obj)
    clone
  end

  def to_s
    array.map(&:to_s).join("\n")
  end
end


class Array
  def procreation_of_the_fittest(value)
    return index_of(value) if length <= 3
    binary_search(value, 0, length)
  end

  def binary_search(value, from, to)
    return self[(from..to)].index_of(value) if to - from <= 2

    middle = (to + from) / 2

    return middle if self[middle] == value

    self[middle] > value ? binary_search(value, from, middle - 1) : binary_search(value, middle, to)
  end

  def index_of(value)
    return length if value > last
    find_index { |other_value| other_value >= value }
  end
end

module Puzzle
  def self.solve
    print 'Enter capacity(M) and number of objects(N). Format "M N":'
    m, n = gets.split(' ')

    objects = []
    n.to_i.times do
      print 'Enter value(c) and size(m) of the object. Format "c m":'
      objects << gets.split(' ')
    end

    Thief.new(m, objects).strategize


    # Thief.new(30, [[2,3],[5,1],[3,2],[7,3],[6,6],[3,8],[4,5],[1,3],[4,3],[5,4]]).strategize

    # test_200 = [[137, 69], [7750, 37], [510, 41], [20808, 35], [317, 22], [374, 66], [23244, 75], [445, 62], [201, 43], [10070, 63], [464, 73], [394, 85], [21546, 40], [330, 99], [192, 76], [10560, 35], [252, 77], [425, 89], [9072, 83], [330, 65], [353, 20], [7752, 86], [295, 66], [156, 76], [26564, 55], [259, 27], [519, 55], [22951, 74], [180, 21], [90, 55], [26280, 79], [264, 68], [592, 71], [4347, 37], [4120, 404], [968, 481], [772, 328], [21777, 392], [402, 218], [897, 401], [11418, 491], [777, 317], [1005, 467], [14697, 276], [916, 233], [984, 355], [23496, 146], [757, 270], [635, 280], [11300, 157], [780, 450], [1047, 211], [28730, 370], [1142, 425], [588, 487], [14499, 159], [890, 296], [1276, 350], [21700, 373], [751, 314], [794, 345], [17313, 167], [250, 85], [91, 45], [27145, 37], [533, 69], [558, 56], [22258, 73], [855, 372], [615, 174], [35010, 297], [1035, 304], [1323, 185], [15934, 189], [985, 213], [441, 144], [29280, 283], [1217, 119], [848, 444], [34848, 446], [690, 134], [571, 341], [29478, 176], [1442, 285], [661, 133], [32095, 316], [1008, 326], [489, 326], [24336, 393], [1561, 355], [503, 352], [15318, 172], [1675, 142], [1003, 324], [43434, 200], [655, 246], [1318, 488], [30849, 139], [828, 390], [492, 222], [38400, 329], [1996, 168], [1853, 187], [70233, 450], [1104, 279], [1171, 367], [19026, 485], [2021, 106], [989, 320], [57491, 399], [721, 397], [902, 269], [88088, 317], [1516, 470], [670, 136], [25290, 130], [1692, 168], [805, 455], [87814, 106], [1019, 341], [16155, 932], [1478, 532], [1537, 718], [15456, 511], [1081, 649], [1317, 999], [15453, 810], [1182, 574], [997, 662], [29610, 958], [1873, 746], [1544, 502], [24833, 908], [1312, 970], [1896, 587], [28160, 966], [1146, 920], [1432, 862], [34923, 555], [1106, 894], [2081, 995], [41074, 550], [1403, 683], [1711, 774], [51083, 913], [1233, 641], [1723, 664], [30456, 750], [1725, 950], [1502, 584], [43750, 997], [2480, 698], [1651, 581], [66924, 865], [2421, 959], [1809, 896], [70983, 783], [2363, 809], [2514, 600], [77224, 673], [2247, 593], [2308, 576], [82418, 779], [2907, 596], [1716, 613], [89010, 840], [2070, 761], [2938, 964], [86180, 882], [2998, 679], [2441, 790], [56608, 552], [2422, 831], [2280, 991], [103653, 664], [1897, 620], [3100, 826], [108766, 662], [3300, 715], [1956, 989], [4220, 2383], [850, 2232], [1476, 2281], [4344, 1406], [1464, 2463], [1452, 1436], [11270, 1843], [1954, 2361], [1099, 1162], [14048, 1748], [1197, 1955], [1748, 1860], [11673, 2189], [1641, 1336], [1830, 1043], [17590, 1979], [1529, 2119], [1302, 1831], [15807, 1502], [1989, 2090]]
    # Thief.new(15_000, test_200).strategize
  end
end

Puzzle::solve
