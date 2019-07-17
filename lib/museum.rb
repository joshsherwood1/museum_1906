require 'pry'
class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommend_exhibits_array = []
    @exhibits.find_all do |exhibit|
      recommend_exhibits_array << exhibit if patron.interests.include?(exhibit.name)
    end
    recommend_exhibits_array
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    hash = {}
    @exhibits.each do |exhibit|
      hash[exhibit] = find_patrons(exhibit)
    end
    hash
  end

  # def find_patrons(exhibit)
  #   patrons_array = []
  #   @patrons.find_all do |patron|
  #     patrons_array << patron if patron.interests.include?(exhibit.name)
  #   end
  # end

  ##### refactored find_patrons_method #####

  def find_patrons(exhibit)
    @patrons.find_all do |patron|
      patron.interests.include?(exhibit.name)
    end
  end

  # def admit(patron)
  #   chosen_exhibit = recommend_exhibits(patron).max_by do |exhibit|
  #     exhibit.cost
  #   end
  #   patron.spending_money - chosen_exhibit.cost
  # end
end
