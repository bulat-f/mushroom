module ApplicationHelper

  def full_title(str)
    result = 'Mushroom'
    unless str.blank?
      "#{ result } | #{ str }"
    else
      result
    end
  end

end
