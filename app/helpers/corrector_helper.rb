module CorrectorHelper
  def informations_for(correctors)
    return if correctors.nil?
    content = ""
    correctors.each do |corrector|
        content += "<div><b>Name:</b> #{corrector.user.name}
        </div>"
    end
    content.html_safe
  end
end
