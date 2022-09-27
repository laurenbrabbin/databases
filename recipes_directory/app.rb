require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory')

#print all recipes
  #recipe_repository = RecipeRepository.new
  #recipe_repository.all.each do |recipe|
    #p recipe
  #end

#prints the first recipe name
repo = RecipeRepository.new
recipe = repo.find(1)
puts recipe.name

#prints the second recipe name
repo = RecipeRepository.new
recipe = repo.find(2)
puts recipe.name
  