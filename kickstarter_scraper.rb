require 'nokogiri' #no requirement for open-uri because scraping from a static/nonlive page
require 'pry'

def create_project_hash

  projects = {}

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a").children[3].text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects


end

#create_project_hash

#projects: kickstarter.css("li.project.grid_4")
#titles: project.css("h2.bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta li a").children[3].text **use this first
#location: project.css("ul.project-meta li span.location-name").text  **use this second (Flatiron's version)
#percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
