FactoryBot.define do
  factory :borrower do
    sequence :name do |n|
      "Borrower-#{n}"
    end
    cc_number { "1111-1111-1111-1111" }
    cc_expiration { 1.month.since.to_date }
  end
end