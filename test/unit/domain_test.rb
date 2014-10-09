require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  should have_many(:projects)
  should validate_presence_of(:name)
  
  context "Creating domain context" do
    setup do
      create_domain_context
    end
    teardown do
      remove_domain_context
    end
    
    should "have a scope to alphabetize domains" do
      assert_equal ["Academic", "Personal", "Poetry", "Software"], Domain.alphabetical.map(&:name)
    end
    
    should "have a scope to select only active domains" do
      assert_equal ["Academic", "Personal", "Software"], Domain.active.map(&:name).sort
    end
    
    should "have a scope to select only inactive domains" do
      assert_equal ["Poetry"], Domain.inactive.alphabetical.map(&:name)
    end 
  end
end
