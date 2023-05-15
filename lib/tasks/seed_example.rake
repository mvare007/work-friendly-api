if Rails.env.development?
  namespace :seed_example do
    desc 'Seed example data for Lisbon only'
    task lisbon: :environment do
      city = City.find_by(name: 'Lisbon')

      puts 'Creating users...'
      users = FactoryBot.create_list(:user, 20, city:)

      puts 'Creating businesses...'
      businesses = FactoryBot.create_list(:business, 10, city:)

      puts 'Adding facility amenities to businesses...'
      businesses.each do |business|
        business.facility_amenities << FacilityAmenity.all.sample(rand(1..5))
      end

      puts 'Creating work spaces...'
      work_spaces = businesses.flat_map do |business|
        FactoryBot.create_list(:work_space, 10, business:)
      end

      puts 'Adding amenities to work spaces...'
      work_spaces.each do |work_space|
        work_space.work_space_amenities << WorkSpaceAmenity.all.sample(rand(1..5))
      end

      puts 'Creating bookings...'
      booked_work_spaces = WorkSpace.joins(business: :city).where(cities: { id: city.id }).sample(10)
      users.sample(10).zip(booked_work_spaces).each do |user, work_space|
        FactoryBot.create(:booking, user:, work_space:)
      end

      puts 'Creating reviews...'
      businesses.sample(20).each do |business|
        FactoryBot.create(:review, business:, user: User.all.sample)
      end
    end
  end
end
