module ApplicationHelper
  def mood_fontawesome(rating)
    case rating
    when "awful" then "far fa-sad-cry"
    when "meh" then "far fa-meh"
    when "neutral" then "far fa-smile"
    when "happy" then "far fa-laugh-beam"
    when "fabulous" then "far fa-grin-hearts"
    else
      "fas fa-times"
    end
  end
end
