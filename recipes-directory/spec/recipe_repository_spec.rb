require 'recipe_repository' 

RSpec.describe RecipeRepository do 
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({host: '127.0.0.1',
    dbname: 'recipes_directory' })
    connection.exec(seed_sql)
  end

  describe RecipeRepository do
    before(:each) do
      reset_recipes_table
    end
  
    it "returns a list of all recipes" do
      repo = RecipeRepository.new
      recipes = repo.all

      expect(recipes.first.id).to eq('1')
      expect(recipes.first.name).to eq('pizza')
      expect(recipes.first.cooking_time).to eq('1')
      expect(recipes.first.rating).to eq('4')
    end
    it "returns the first recipe" do
      repo = RecipeRepository.new
      recipe = repo.find(1)
      expect(recipe.id).to eq("1")
      expect(recipe.name).to eq('pizza')
      expect(recipe.cooking_time).to eq ('1')
      expect(recipe.rating).to eq ('4')
    end
    it "returns the second recipe" do
      repo = RecipeRepository.new
      recipe = repo.find(2)
      expect(recipe.id).to eq("2")
      expect(recipe.name).to eq('pasta')
      expect(recipe.cooking_time).to eq ('1')
      expect(recipe.rating).to eq ('3')
    end
  end
end