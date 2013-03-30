# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed  or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create [{ name: 'Chicago' }  { name: 'Copenhagen' }])
#   Mayor.create name: 'Emanuel'  city: cities.first)

require 'nokogiri'
require 'open-uri'

Pdf.destroy_all
Office.destroy_all
Doctor.destroy_all
Payer.destroy_all

############################################################################################

#   Michigan Avenue Dental Associates

dentist = Office.new(:name => "Michigan Avenue Dental Associates",
                     :address => "122 South Michigan Avenue, Suite 1212",
                     :city => "Chicago",
                     :state => "IL",
                     :zipcode => "60603",
                     :phone => "(312) 922-9595",
                     :fax => "(312) 922-9599",
                     :email => "info@madachicago.com",
                     :abrv => "mada")
dentist.save
Pdf.create(:form_name => "mada", :office_id => dentist.id)


doc2 =  Nokogiri::HTML(open('http://www.madachicago.com/dentists/'))

doc2.css('div.content p a').each do |link|
  Doctor.create(:title => link.content, :office_id => dentist.id)
end

puts "Michigan Avenue Dental Associates -- Done"

############################################################################################

#   Chicago Lake Shore Medical Associates

office = Office.new(:name => "Chicago Lake Shore Medical Associates",
                    :address => "676 North St. Clair Suite 2300",
                    :city => "Chicago",
                    :state => "IL",
                    :zipcode => "60603",
                    :phone => "(312) 926-6000",
                    :fax => "(312) 926-6600",
                    :abrv => "clsma")
office.save
Pdf.create(:form_name => "clsma", :office_id => office.id)

doc1 =  Nokogiri::HTML(open('http://www.clsma.com/physicians/phys_alpha.html'))

doc1.css('div.list a').each do |link|
  Doctor.create(:title => link.content, :office_id => office.id)
end

puts "Chicago Lake Shore Medical Associates -- done"

############################################################################################

#   Midwest Health Center

office = Office.new(:name => "Midwest Health Center",
                    :address => "1244 N. Milwaukee Ave",
                    :city => "Chicago",
                    :state => "IL",
                    :zipcode => "60622",
                    :phone => "(312) 470-6655",
                    :fax => "(773) 698-6456",
                    :abrv => "mhc")
office.save
Pdf.create(:form_name => "mhc", :office_id => office.id)

doc3 = Nokogiri::HTML(open('http://www.midwesthealthchicago.com/our-doctors'))

doc3.css('div.content strong').each do |link|
  if /[a-zA-Z]/.match(link.content)
    doctor = link.content.to_s.gsub("&nbsp;", " ").gsub(/\u00A0/,'').strip
    Doctor.create(:title => doctor, :office_id => office.id)
  end
end

puts "Midwest Health Center -- done"

############################################################################################

# => Haresh Sawlani MD PC

office = Office.new(:name => "Haresh Sawlani MD PC",
                    :address => "3445 N. Central Avenue, Unit C",
                    :city => "Chicago",
                    :state => "IL",
                    :zipcode => "60634",
                    :phone => "(773) 205-0800",
                    :fax => "(773) 205-1804",
                    :abrv => "sawlani_demographics")
office.save
Pdf.create(:form_name => "sawlani_demographics", :office_id => office.id)

puts "Haresh Sawlani MD PC -- done"

############################################################################################
# => Insurance company Names and Payer Codes

doc4 = Nokogiri::HTML(open('https://eligibleapi.com/information-sources'))

doc4.css("ul#posts li").each do |payer_info|
    if payer_info.at_css("div.num").present?
        payer_id = payer_info.at_css("div.num").text
        payer_name = payer_info.at_css("div.name").text
        Payer.create(payer_name: payer_name, payer_code: payer_id)
    end
end

puts "You have added #{Payer.count} Insurance companies"
