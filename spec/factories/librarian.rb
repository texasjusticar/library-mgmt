FactoryBot.define do
  factory :librarian do
    sequence :name do |n|
      "Librarian-#{n}"
    end
    auth_token { "test-token" }
  end
end