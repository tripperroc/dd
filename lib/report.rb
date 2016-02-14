# export RAILS_ENV=production; rails runner lib/report.rb

def report2()
	ResponseSet.all.each do |response_set| 
		#puts (response_set)
	 	uri = URI('https://cmhost.gccis.rit.edu/ritsurv/surveys/rit-quality-of-life-survey/' + response_set.access_code + '.json')
	 	resp = Net::HTTP.get(uri)
		puts(resp)

	end
end


def get_banner3()
	uri = URI("https://cmhost.gccis.rit.edu/ritsurv/surveys/rit-quality-of-life-survey.json")
	resp = Net::HTTP.get(uri)
	puts(resp )
end
get_banner3()
report2()
