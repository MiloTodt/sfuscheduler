url = "http://localhost:3000/schedule_builders/new?classes="
ARGV.each do|a|
	b = a.upcase
  url += b +"%2C"
end
url = "lynx " + url.gsub(" ", "+")
system(url)

#http://localhost:3000/schedule_builders/new?classes=CMPT+295%2CCMPT+383%2CCMPT+310%2CMACM+201%2C