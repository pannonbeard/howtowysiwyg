module ScenariosHelper
  def image_set(x)
    case x
    when 1
      raw("<i class=\"fa fa-user-secret\"></i>")
    when 2
      raw("<i class=\"fa fa-tint\"></i>")
    when 3
      raw("<i class=\"fa fa-sticky-note-o\"></i>")
    when 4
      raw("<i class=\"fa fa-road\"></i>")
    end
  end
end
