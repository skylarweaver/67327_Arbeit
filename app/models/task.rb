class Task < ActiveRecord::Base
  
  # Relationships
  belongs_to :project
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  belongs_to :completer, :class_name => "User", :foreign_key => "completed_by"
  has_many :assignments, :through => :project

  
  PRIORITY_LIST = [ ["High", "high"], ["Med", "med"], ["Low", "low"], ["Who cares?", "unkn"] ]
  
  # Named scopes
  scope :chronological, order("due_on")
  scope :by_completion_date, order("updated_at DESC")
  scope :by_priority,   order("priority, due_on")
  scope :last,          lambda { |num| limit(num) }
  scope :by_name,       order("name ASC")
  scope :in_next_days,  lambda { |days| { :conditions => ["due_on between ? and ?", Date.today.to_time, (Date.today+days).to_time] } }
  scope :upcoming,      where("due_on > ?", Time.now)
  scope :incomplete,    where("completed = ?", false)
  scope :overdue,       where("due_on < ? and completed = ?", Time.now, false)
  scope :completed,     where("completed = ?", true)
  scope :high_priority, where("priority = ?", "high")
  scope :med_priority,  where("priority = ?", "med")
  scope :for_project,   lambda { |project_id| where("project_id = ?", project_id) }
  scope :for_creator,   lambda { |user_id| where("created_by = ?", user_id) }
  scope :for_completer, lambda { |user_id| where("completed_by = ?", user_id) }
  
  # Validations
  validates_presence_of :name
  validates_datetime :due_on, :on => :update
  # validate :date_is_in_future, :on => :create  ## CAN'T USE THIS WITH POPULATE SCRIPT
  
  # Callback
  before_validation :set_due_on_from_string
  
  def set_due_on_from_string
    return true if self.due_string.nil?
    date = Chronic.parse(self.due_string)
    if date.nil?
      self.errors.add :due_string, "was not a proper date: #{self.due_string}"
    end
    self.due_on = date
  end
  
  # def date_is_in_future
  #   return true if self.due_on.nil? # skip this validation if due_on not properly set
  #   self.errors.add :due_on, "needs to be in the future" unless self.due_on.future?
  # end
  
  # Other methods
  def status
    return "Overdue" if due_on < Time.now && !completed
    return "Pending" if due_on > Time.now && !completed
    return "Completed" if completed
  end
  
end
