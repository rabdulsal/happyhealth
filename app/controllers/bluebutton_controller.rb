require 'nokogiri'
require 'open-uri'

class BluebuttonController < ApplicationController
  
  def receive_attachment
  	direct_post = params[:to]

  	#Use Nokogiri to open direct_post xml contents and save to a variable
  	doc = Nokogiri::XML(open("https://secure.happyhealth.me/incoming/ccda/for/#{direct_post}"))
  	
  	#Capture the variable and send it over to the ccda_summary to show in the view
  	ccda_summary(doc)
  end

  def ccda_summary(xml_doc)
  	if xml_doc.nil?
  		@ccda = "Sorry, nothing to show."
  	else
  		@ccda = xml_doc
  	end
  end

end
