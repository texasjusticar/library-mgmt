FactoryBot.define do
  factory :library do
    sequence :name do |n|
      "Library-#{n}"
    end
  end
end