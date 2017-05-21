require 'faker'

Company.destroy_all
Job.destroy_all
Category.destroy_all
Contact.destroy_all

COMPANIES = ["ESPN", "Aetna", "United Airlines", "Denver Public Schools", "Shopify", "Starbucks", "Pivotal Labs", "Captain U"]
JOBS = ["Engineering", "Development", "Dev Ops", "Quality Assurance", "Teacher", "Product Manager", "Consultant", "Community Manager"]
CITIES = ["Seattle", "Denver", "Portland", "Indianapolis", "Madison", "Orlando", "San Diego", "Austin", "Las Vegas", "Little Rock", "Boise", "Eugene", "Oakland"]
CATEGORIES = ["Web Development", "Education", "Finance"]

CATEGORIES.each do |title|
  category = Category.create!(title: title)
end

COMPANIES.each do |name|
  company = Company.create!(name: name)
  puts "Created #{company.name}"
  10.times do |num|
    company.jobs.create!(title: JOBS.sample, description: "What a great position!", level_of_interest: num + rand(100), city: CITIES.sample, category: Category.all.sample)
    puts "  Created #{company.jobs[num].title}"
  end
  3.times do |num|
    company.contacts.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      position: Faker::Company.profession,
      email: Faker::Internet.email
    )
    puts "  Created #{company.contacts[num].full_name}"
  end
end
