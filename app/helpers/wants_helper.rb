module WantsHelper

  def priority_text(p)
    case p
      when 1
        'Very Low'
      when 2
        'Low'
      when 3
        'Normal'
      when 4
        'High'
      when 5
        'Very High'
    end
  end

end
