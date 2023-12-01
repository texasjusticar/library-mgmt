namespace :librarian do
    desc "Setup Librarian"
    task setup: :environment do
        api_user = Librarian.create(name: 'API User')
        puts "\n==============================="
        puts "API key: #{api_user.auth_token}"
        puts "===============================\n"
    end
  end