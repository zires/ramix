require 'helper'

class TestBuilder < Test::Unit::TestCase

  def setup
    @f      = File.new(File.expand_path( File.dirname(__FILE__) + '/fixtures/template.rb' ), 'w+')
    @recipe = Ramix::Template.new('recipe', File.expand_path( File.dirname(__FILE__) + '/fixtures' ))
    @b      = Ramix::Builder.new(@f.path)
  end
 
  def teardown
    require 'fileutils'
    FileUtils.rm @f.path, :force => true
  end

  def test_run
    @b.import @recipe
    path = @b.run
    assert_match /"recipe body"/, @f.read
    assert_equal @f.path, path
  end

end