require 'pry'

MUTATION_PERCENTAGE = 2
SELECTION_HARSHNESS = 2.0 / 3

class Array; def second; self[1]; end; end

class Thief
  attr_accessor :bag_size, :genes, :population

  def initialize(bag_size, genes)
    @bag_size   = bag_size
    @genes      = genes
    @population = initialize_population
  end

  def strategize

    generation = 0
    loop do
      p population

      p "GENERATION #{generation}"
      p "Fittest -> #{population.fittest.fitness}"

      evaluate_fitness
      selection
      crossover_and_mutation
    end
  end

  private

  def initialize_population
    Specimen.genes = genes
    population     = OrderedArray.new
    dna            = Array.new(genes.size)

    genes.size.times do
      dna.map! { |_| [true, false].sample }
      population << Specimen.new(dna)
    end
  end

  def evaluate_fitness
    population.each do |specimen|
       genes_in_specimen = genes.zip(specimen.dna).select { |genes_and_dna| genes_and_dna.second }.map(&:first)
       p genes_in_specimen
       specimen.fitness  = genes_in_specimen.reduce(0) { |sum, gene| sum + gene.first }

       specimen.fitness = -1 if specimen.fitness > bag_size
    end
  end

  def selection
    population.reject(&:too_heavy?)
    number_of_survivals_after_selection = (genes.size * SELECTION_HARSHNESS).floor

    return if population.size < number_of_survivals_after_selection

    (number_of_survivals_after_selection - population.size).times { population.pop }
  end

  def crossover_and_mutation
    reproduction_array = create_reproduction_array

    (population.size / 2).times do
      specimen_a = choose_specimen(reproduction_array)

      specimen_b = nil
      loop do
        specimen_b = choose_specimen(reproduction_array)
        break if specimen_a != specimen_b
      end

      population << Specimen.child_of(specimen_a, specimen_b)
    end
  end

  def create_reproduction_array
    Array.new(population.size).tap do |reproduction_array|
      reproduction_array[0] = population.first.fitness

      population.each_with_index do |specimen, i|
        next if i == 0
        reproduction_array[i] = reproduction_array[i - 1] + specimen.fitness
      end
    end
  end

  def choose_specimen(reproduction_array)
    index = reproduction_array.procreation_of_the_fittest( rand(1..reproduction_array.last) )
    population[index]
  end
end

class Specimen
  attr_accessor :dna, :fitness

  def initialize(dna)
    @dna     = dna
    @fitness = 0
  end

  def self.genes=(genes)
    @@genes = genes
  end

  def self.genes
    @@genes
  end

  def too_heavy?
    fitness == -1
  end

  def self.child_of(a, b)
    parents_dnas = [a.dna, b.dna]
    child_dna   = Array.new(genes.size)

    (0...genes.size).each { |i| child_dna[i] = parents_dnas.sample[i] }

    specimen = Specimen.new(child_dna)
    mutate? ? specimen.mutate! : specimen
  end

  def mutate!
    binding.pry
    mutation_index = rand(0...dna.size)
    dna[mutation_index] = !dna[mutation_index]

    mutate? ? mutate! : self
  end

  def mutate?
    rand(0...100) < MUTATION_PERCENTAGE
  end

  def to_s
    fitness
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
      if other_obj.fitness <= obj.fitness
        array.insert(i, obj)
        return
      end
    end

    # array is empty
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
end


class Array
  def procreation_of_the_fittest(value)
    binary_search(value, 0, self.length)
  end

  def binary_search(value, from, to)
    return to + 1 if from - to <= 2

    middle = (to + from) / 2

    return middle if self[middle] == value

    self[middle] > value ? binary_search(value, from, middle) : binary_search(value, middle, to)
  end
end

module Puzzle
  def self.solve
    # print 'Enter capacity(M) and number of objects(N). Format "M N":'
    # m, n = gets.split(' ')

    # objects = []
    # n.to_i.times do
    #   print 'Enter value(c) and size(m) of the object. Format "c m":'
    #   objects << gets.split(' ')
    # end

    # Thief.new(m, objects).strategize
    Thief.new(5, [[2,3],[5,1],[3,2]]).strategize
  end
end

Puzzle::solve
