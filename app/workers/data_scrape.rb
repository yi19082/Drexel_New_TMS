class DataScrape
	require 'nokogiri'
	require 'open-uri'

	def self.open_url(endpoint)
		home_url = 'https://duapp2.drexel.edu'
		Nokogiri::HTML(open(home_url + endpoint))
	end

	def self.get_term_data
		data = open_url('/webtms_du/app')
		term_data = {}
		data.css('.term').each do |term|
			term_url = term.at('a').attributes['href'].to_s
			term_name = term.text.strip
			term_data[term_name] = term_url
		end
		term_data
	end

	def self.get_college_data(term_url)
		college_data = {}
		data = open_url(term_url)
		data.css('#sideLeft a').each do |college|
			college_url = college.attributes['href'].to_s
			college_name = college.text.strip
			college_data[college_name] = college_url
		end
		college_data
	end

	def self.get_subject_data(college_url)
		subject_data = {}
		data = open_url(college_url)
		data.css('.odd').each do |subject|
			subject_url = subject.at('a').attributes['href'].to_s
			subject_name = subject.at('a').text
			subject_data[subject_name] = subject_url
		end
		data.css('.even').each do |subject|
			subject_url = subject.at('a').attributes['href'].to_s
			subject_name = subject.at('a').text
			subject_data[subject_name] = subject_url
		end
		subject_data
	end

	def self.get_course_data(subject_url)
		courses = []
		course_data = {}
		data = open_url(subject_url)
		data.css('.odd').each do |course|
			if course.elements.count >= 9
				elements = course.elements
				course_data[:course_number] = elements[0].text + elements[1].text + ' - ' + elements[4].text # number and section
				course_data[:name] = elements[6].text
				course_data[:crn] = elements[5].text
				course_data[:day] = elements[7].text.strip.split("\r").first
				course_data[:time] = elements[7].text.strip.split("\r").last.strip
				course_data[:instructor] = elements[8].text
				c = Course.create(course_data)
				courses << c
			else
				#puts course.text
			end
		end
		data.css('.even').each do |course|
			if course.elements.count >= 9
				elements = course.elements
				course_data[:course_number] = elements[0].text + ' ' + elements[1].text + '-' + elements[4].text # number and section
				course_data[:name] = elements[6].text
				course_data[:crn] = elements[5].text
				course_data[:day] = elements[7].text.strip.split("\r").first
				course_data[:time] = elements[7].text.strip.split("\r").last.strip
				course_data[:instructor] = elements[8].text
				c = Course.create(course_data)
				courses << c
			else
				#puts course.text
			end
		end
		courses
	end

	def self.perform
		term_data = get_term_data
		term_data.each do |term_name, term_url|
			term_record = Term.find_by(name: term_name) || Term.create(name: term_name)
			college_data = get_college_data(term_url)
			college_data.each do |college_name, college_url|
				college_record = College.find_by(name: college_name) || College.create(name: college_name)
				subject_data = get_subject_data(college_url)
				subject_data.each do |subject_name, subject_url|
					subject_record = Subject.find_by(name: subject_name) || college_record.subjects.create(name: subject_name)
					courses = get_course_data(subject_url)
					courses.each do |course|
						subject_record.courses << course
						term_record.courses << course
					end
					# subject_record.courses = courses
					# term_record.courses = courses
				end
			end
		end
	end
end
