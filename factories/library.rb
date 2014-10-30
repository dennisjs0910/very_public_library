FactoryGirl.define do
  factory :library do
    name			Faker::Company.name
    late_fee 	Faker::Number.number(2) 
    capacity  Faker::Number.number(5)
  end
end
