FactoryBot.define do
  factory :book do
    sequence :title do |n|
      "Library-#{n}"
    end
    sequence :author do |n|
      "Author-#{n}"
    end
    isbn { SecureRandom.hex }
  end
end