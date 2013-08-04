module ApplicationHelper

  def full_title(page_title)
  	page_title.empty? ? "LOL.ly - Sweet URLs" : "#{page_title} | LOL.ly"
  end
end
