require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Prof. H's deny method to improve readability of tests
  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end
  
  # Context for domains
  def create_domain_context
    @software = FactoryGirl.create(:domain)
    @academic = FactoryGirl.create(:domain, name: 'Academic')
    @personal = FactoryGirl.create(:domain, name: 'Personal')
    @poetry = FactoryGirl.create(:domain, name: 'Poetry', active: false)
  end
  
  def remove_domain_context
    @software.destroy
    @academic.destroy
    @personal.destroy
    @poetry.destroy

  end
  
  # Context for users
  def create_user_context
    @ed = FactoryGirl.create(:user)
    @ted = FactoryGirl.create(:user, first_name: "Ted")
    @fred = FactoryGirl.create(:user, first_name: "Fred", role: "admin", email: "fred@example.com")
    @ned = FactoryGirl.create(:user, first_name: "Ned", active: false)
  end
  
  def remove_user_context
    @ed.destroy
    @ted.destroy
    @fred.destroy
    @ned.destroy
  end
  
  # Context for projects (assumes contexts for domains, users)
  def create_project_context
    @arbeit = FactoryGirl.create(:project, domain: @software, manager: @ted, start_date: 1.week.ago.to_date, end_date: nil)
    @proverbs = FactoryGirl.create(:project, name: 'Proverbs', domain: @software, manager: @ed, start_date: 9.weeks.ago.to_date, end_date: nil)
    @bookmanager = FactoryGirl.create(:project, name: 'BookManager', domain: @software, manager: @fred, start_date: 8.weeks.ago.to_date, end_date: nil)
    @choretracker = FactoryGirl.create(:project, name: 'ChoreTracker', domain: @software, manager: @fred, start_date: 7.weeks.ago.to_date)
  end
  
  def remove_project_context
    @arbeit.destroy
    @proverbs.destroy
    @bookmanager.destroy
    @choretracker.destroy

  end
  
  # Context for assignments (assumes contexts for [projects, domains], users)
  def create_assignment_context
    @arbeit_ed = FactoryGirl.create(:assignment, project: @arbeit, user: @ed)
    @arbeit_ted = FactoryGirl.create(:assignment, project: @arbeit, user: @ted)
    @arbeit_fred = FactoryGirl.create(:assignment, project: @arbeit, user: @fred)
    @bookmanager_ed = FactoryGirl.create(:assignment, project: @bookmanager, user: @ed, active: false)
    @bookmanager_ted = FactoryGirl.create(:assignment, project: @bookmanager, user: @ted)
    @bookmanager_fred = FactoryGirl.create(:assignment, project: @bookmanager, user: @fred)
    @proverbs_ed = FactoryGirl.create(:assignment, project: @proverbs, user: @ed)
    @proverbs_ted = FactoryGirl.create(:assignment, project: @proverbs, user: @ted)
  end
  
  def remove_assignment_context
    @arbeit_ed.destroy
    @arbeit_ted.destroy
    @arbeit_fred.destroy
    @bookmanager_ed.destroy
    @bookmanager_ted.destroy
    @bookmanager_fred.destroy
    @proverbs_ed.destroy
    @proverbs_ted.destroy
  end
  
  # Context for tasks (assumes contexts for [projects, domains], users)
  def create_task_context
    @arbeit_t1 = FactoryGirl.create(:task, project: @arbeit, creator: @ed, completer: @ed)
    @arbeit_t2 = FactoryGirl.create(:task, name: 'Wireframing', project: @arbeit, due_on: 1.day.from_now, due_string: "tomorrow", creator: @ted, completer: nil, completed: false)
    @arbeit_t3 = FactoryGirl.create(:task, name: 'Create stylesheets', project: @arbeit, due_on: 3.days.from_now, due_string: "3 days ago", creator: @ted, completer: nil, completed: false)
    @proverbs_t1 = FactoryGirl.create(:task, name: 'Unit testing', project: @proverbs, due_on: 5.days.ago, due_string: "5 days ago", creator: @ted, completer: @ted, completed: true)
    @bookmanager_t1 = FactoryGirl.create(:task, name: 'Modify controllers', project: @bookmanager, due_on: 4.days.ago, due_string: "4 days ago", creator: @fred, completer: @fred, completed: true, priority: 2)
    @bookmanager_t2 = FactoryGirl.create(:task, name: 'User testing', project: @bookmanager, due_on: 3.days.ago, due_string: "3 days ago", creator: @ted, completer: @fred, completed: true)
    @bookmanager_t3 = FactoryGirl.create(:task, name: 'Security review', project: @bookmanager, due_on: 2.days.ago, due_string: "2 days ago", creator: @fred, completer: nil, completed: false)
  end
  
  def remove_task_context
    @arbeit_t1.destroy
    @arbeit_t2.destroy
    @arbeit_t3.destroy
    @proverbs_t1.destroy
    @bookmanager_t1.destroy
    @bookmanager_t2.destroy
    @bookmanager_t3.destroy
  end
end