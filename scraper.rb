# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

 require 'scraperwiki'
 require 'mechanize'

#
 agent = Mechanize.new
#
 page = agent.get("http://www.rfs.nsw.gov.au/fire-information/fdr-and-tobans")

 page.at('tbody').search('tr').each do |row| 
   name = row.search(:td).first.inner_text
   dangerToday = row.search('td')[1].inner_text
   toBanToday = row.search(:td)[2].inner_text
   fireDangerTomorrow = row.search(:td)[3].inner_text
   toBanTomorrow = row.search(:td)[4].inner_text
   councils = row.search(:td)[5].inner_text

  record = {
    date_scraped: Date.today,
    name: name,
    dangerToday: dangerToday,
    toBanToday: toBanToday,
    fireDangerTomorrow: fireDangerTomorrow,
    toBanTomorrow: toBanTomorrow,
    councils: councils
  }

  p record
  ScraperWiki.save_sqlite([:name], record)
end

puts 'done'

#
# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
