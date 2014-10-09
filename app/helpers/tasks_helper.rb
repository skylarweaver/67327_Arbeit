module TasksHelper
  def get_priority_class(code)
    if code == "high"
      "high_priority"
    elsif code == "med"
      "med_priority"
    else "low_priority"
    end
  end
  
  def get_priority_name(code)
    if code == "high"
      "High"
    elsif code == "med"
      "Med"
    else "Low"
    end
  end
  
  def get_task_status(status)
    return "Yes" if status == true
    "No"
  end
  
  def get_project_options
    current_user.projects.map{|p| ["#{p.name}", p.id] }
  end
  
end