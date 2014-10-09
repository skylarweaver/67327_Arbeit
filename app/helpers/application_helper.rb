module ApplicationHelper
  def task_label(status)
    if status == "Overdue"
      "<span class='label label-important'>#{status}</span>"
    elsif status == "Completed"
      "<span class='label label-success'>#{status}</span>"
    else
      "<span class='label'>#{status}</span>"
    end
  end
  
  def priority_label(priority)
    if priority == "high"
      "<span class='label label-important'>High</span>"
    elsif priority == "med"
      "<span class='label label-warning'>Med</span>"
    elsif priority == "low"
      "<span class='label'>Low</span>"
    else
      "<span class='label'>#{priority}</span>"
    end
  end
  
  def add_date_helper(boxname)
    trigger = "#{boxname}_trigger"
    %Q{
      &nbsp;<img src=\"/images/icons/calendar.gif\" id=\"#{trigger}\"
       style=\"cursor: pointer; border: 0px solid red;\"
       title=\"Date selector\"
       onmouseover=\"this.style.background='red';\"
       onmouseout=\"this.style.background=''\" />
  	   <script type=\"text/javascript\">
    	   Calendar.setup({
           inputField     :    \"#{boxname}\",
           ifFormat       :    \"%m/%d/%Y\",
           button         :    \"#{trigger}\",
           align          :    \"Tl\",
           singleClick    :    false
    	   });
  	   </script>
    }
  end

end
