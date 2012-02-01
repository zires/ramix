require 'helper'

class TestTemplate < Test::Unit::TestCase

  def setup
    @recipe_exist                = Ramix::Template.new('recipe', File.expand_path( File.dirname(__FILE__) + '/fixtures' ))
    @recipe_exist_with_diff_name = Ramix::Template.new('diff_recipe', File.expand_path( File.dirname(__FILE__) + '/fixtures' ))
    @recipe_not_exist            = Ramix::Template.new('test')
  end

  def test_name
    assert_equal 'recipe', @recipe_exist.name
    assert_equal 'recipe', @recipe_exist_with_diff_name.name
    assert_equal 'test',   @recipe_not_exist.name
  end

  def test_output
    assert_equal "# >====================== [test] =======================<\n\ngem 'test'\n\n",   @recipe_not_exist.output
    assert_equal "# >====================== [recipe] =======================<\r\n\"recipe body\"\n\n",   @recipe_exist.output
  end

  def test_respond_to_attributes
    Ramix::Template::ATTRIBUTE.each do |attr|
      assert_respond_to( @recipe_exist, attr )
    end
  end

  def test_desc
    assert_equal 'Just a test recipe for ramix.', @recipe_exist.desc
  end

  def test_dependence
    assert_equal ['-O'], @recipe_exist.dependence
  end

end