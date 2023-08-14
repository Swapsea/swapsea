# frozen_string_literal: true

namespace :demo_club do
  desc 'Create demo club and populate'
  task :populate, [:club_name] => :environment do |_task, args|
    club_name = args[:club_name] || 'Swapsea Demo SLSC'

    # Create/select club
    club = Club.where(name: club_name).first_or_create(name: club_name, short_name: club_name, show_patrols: true, show_rosters: true, show_swaps: true,
                                                       show_skills_maintenance: false, show_outreach: false, lat: -33.89051, lon: 151.280002,
                                                       enable_reminders_email: true, enable_reminders_sms: false)

    puts club.name

    # Create patrols
    (1..14).map do |count|
      Patrol.create(club:,
                    name: "Demo Patrol #{count}",
                    short_name: "P#{count}",
                    special_event: false,
                    need_bbm: 1,
                    need_irbd: 1,
                    need_irbc: 2,
                    need_artc: 0,
                    need_firstaid: 0,
                    need_spinal: 0,
                    need_bronze: 5,
                    need_src: 0)
    end
    patrols = Patrol.where(club:)

    today = Date.today
    this_year = today.strftime('%Y')
    next_yr = (today + 1.year).strftime('%y')

    date1 = today.to_time - 50.years
    date2 = today.to_time - 18.years

    # Create users and patrol members for each patrol
    patrols.each do |patrol|
      puts patrol.name

      rand(7...16).times do |count|
        user_id = rand.to_s[2..10]

        case count
        when 0
          default_position = 'Patrol Captain'
          bbm = true
          irbd = false
          irbc = false
          artc = true
          spinal = true
          firstaid = true
        when 1
          default_position = 'Vice Captain'
          bbm = true
          irbd = false
          irbc = false
          artc = true
          spinal = true
          firstaid = true
        when 2
          default_position = 'IRB Driver'
          bbm = false
          irbd = true
          irbc = true
          artc = false
          spinal = true
          firstaid = true
        when 3 || 4
          default_position = 'IRB Crew'
          bbm = false
          irbd = false
          irbc = true
          artc = false
          spinal = false
          firstaid = true
        else
          default_position = 'Bronze Member'
          bbm = false
          irbd = false
          irbc = false
          artc = [true, false].sample
          spinal = false
          firstaid = [true, false].sample
        end
        bronze = true
        src = false

        User.create(
          id: user_id,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          password: 'password',
          mobile_phone: '0401222333',
          dob: Time.zone.at(((date2.to_f - date1.to_f) * rand) + date1.to_f).strftime('%y-%m-%d'),
          date_joined_organisation: today.strftime('%y-%m-%d'),
          category: 'Active (18yrs and over)',
          status: 'Active',
          season: "#{this_year}/#{next_yr}",
          club:,
          default_position:,
          bbm:,
          irbd:,
          irbc:,
          artc:,
          spinal:,
          firstaid:,
          bronze:,
          src:
        )

        user = User.find(user_id)

        puts "   #{user.name} - #{user.default_position}"

        PatrolMember.create(
          patrol:,
          user_id:,
          default_position:
        )

        # Create awards
        if user.bbm
          award_number = "DNS#{rand.to_s[2..10]}"
          award_date = Date.today - 6.months
          Award.create(
            user_id:,
            award_number:,
            award_name: 'Silver Medallion Beach Management',
            award_date: award_date.strftime('%Y-%m-%d'),
            proficiency_date: (award_date + 1.year).strftime('%Y-%m-%d'),
            originating_organisation: club.name
          )
        end
        if user.irbd
          award_number = "DNS#{rand.to_s[2..10]}"
          award_date = Date.today - 6.months
          Award.create(
            user_id:,
            award_number:,
            award_name: 'Silver Medallion IRB Driver',
            award_date: award_date.strftime('%Y-%m-%d'),
            proficiency_date: (award_date + 1.year).strftime('%Y-%m-%d'),
            originating_organisation: club.name
          )
        end
        if user.irbc
          award_number = "DNS#{rand.to_s[2..10]}"
          award_date = Date.today - 6.months
          Award.create(
            user_id:,
            award_number:,
            award_name: 'IRB Crew Certificate',
            award_date: award_date.strftime('%Y-%m-%d'),
            proficiency_date: (award_date + 1.year).strftime('%Y-%m-%d'),
            originating_organisation: club.name
          )
        end
        if user.artc
          award_number = "DNS#{rand.to_s[2..10]}"
          award_date = Date.today - 6.months
          Award.create(
            user_id:,
            award_number:,
            award_name: 'Advanced Resuscitation Techniques Certificate',
            award_date: award_date.strftime('%Y-%m-%d'),
            proficiency_date: (award_date + 1.year).strftime('%Y-%m-%d'),
            originating_organisation: club.name
          )
        end
        if user.bronze
          award_number = "DNS#{rand.to_s[2..10]}"
          award_date = Date.today - 6.months
          Award.create(
            user_id:,
            award_number:,
            award_name: 'Bronze Medallion',
            award_date: award_date.strftime('%Y-%m-%d'),
            proficiency_date: (award_date + 1.year).strftime('%Y-%m-%d'),
            originating_organisation: club.name
          )
        end

        user.awards.each do |award|
          puts "      #{award.award_number} #{award.award_name}"
        end
      end
    end

    # Create patrol roster
    # start date, cycle through dates, check if saturday or sunday, morning or afternoon, allocate patrol, end date.
    (Date.new(Date.today.year, 9, 25)..Date.new(Date.today.year + 1, 4, 30)).each do |date|
      formatted_date = date.strftime('%Y-%m-%d')
      next unless date.saturday? || date.sunday?

      roster = Roster.create(
        start: Time.zone.parse("#{formatted_date} 07:45:00").utc.iso8601,
        finish: Time.zone.parse("#{formatted_date} 13:00:00").utc.iso8601,
        patrol: Patrol.with_club(club).sample,
        secret: Digest::SHA256.hexdigest(('a'..'z').to_a.sample(10).join)
      )

      puts "#{roster.patrol.name}   #{roster.start.strftime('%a %d %b %Y')}   #{roster.start.strftime('%H:%M')} - #{roster.finish.strftime('%H:%M')}"

      roster = Roster.create(
        patrol: Patrol.with_club(club).sample,
        start: Time.zone.parse("#{formatted_date} 12:45:00").utc.iso8601,
        finish: Time.zone.parse("#{formatted_date} 18:00:00").utc.iso8601,
        secret: Digest::SHA256.hexdigest(('a'..'z').to_a.sample(10).join)
      )

      puts "#{roster.patrol.name}   #{roster.start.strftime('%a %d %b %Y')}   #{roster.start.strftime('%H:%M')} - #{roster.finish.strftime('%H:%M')}"
    end

    Roster.with_club(club).each(&:update_award_counts)
  end

  desc 'Destroy all records related to the demo club and its members.'
  task :destroy, [:club_name] => :environment do |_task, args|
    club_name = args[:club_name]

    club = Club.find_by(name: club_name)

    if club
      puts "Deleting #{club.name}..."
      # Destroy in reverse order as we don't have cascading delete (for safety)
      User.with_club(club).each do |user|
        puts "   Deleting #{user.name}..."
        Award.with_user(user).destroy_all
        PatrolMember.with_user(user).destroy_all
        user.destroy
      end
      Roster.with_club(club).destroy_all
      Patrol.with_club(club).destroy_all
      Club.find(club.id).destroy
      puts "Deleted #{club.name}"
    else
      puts "Club not found: #{club_name}"
    end
  end
end
