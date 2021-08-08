namespace :demo_club do
	desc 'Create demo club and populate'
	task :populate, [:club_name] => :environment do |task, args|

		club_name = args[:club_name]

		# Create club
		Club.create(name: club_name, short_name: club_name, show_patrols: true, show_rosters: true, show_swaps: true, show_skills_maintenance: false, show_outreach: false, lat: -33.89051, lon: 151.280002)
		club = Club.find_by_name(club_name)

		puts club.name

		# Create patrols
		(1..14).map do |count|
			Patrol.create(name: "Demo Patrol #{count}", special_event: false, need_bbm: 1, need_irbd: 1, need_irbc: 2, need_artc: 0, need_firstaid: 0, need_spinal: 0, need_bronze: 5, need_src: 0, organisation: club.name, short_name: club.short_name)
		end
		patrols = Patrol.where(organisation: club.name)

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
	  				bronze = true
	  				src = false
	  			when 1
	  				default_position = 'Vice Captain'
	  				bbm = true
	  				irbd = false
	  				irbc = false
	  				artc = true
	  				spinal = true
	  				firstaid = true
	  				bronze = true
	  				src = false
	  			when 2
	  				default_position = 'IRB Driver'
	  				bbm = false
	  				irbd = true
	  				irbc = true
	  				artc = false
	  				spinal = true
	  				firstaid = true
	  				bronze = true
	  				src = false
	  			when 3 || 4
	  				default_position = 'IRB Crew'
	  				bbm = false
	  				irbd = false
	  				irbc = true
	  				artc = false
	  				spinal = false
	  				firstaid = true
	  				bronze = true
	  				src = false
	  			else
	  				default_position = 'Bronze Member'
	  				bbm = false
	  				irbd = false
	  				irbc = false
	  				artc = [true,false].sample
	  				spinal = false
	  				firstaid = [true,false].sample
	  				bronze = true
	  				src = false
	  			end

	  			User.create(

	  				id: user_id,
	  				first_name: Faker::Name.first_name,
	  				last_name: Faker::Name.last_name,
	  				email: Faker::Internet.email,
	  				password: 'password',
	  				mobile_phone: '0401222333',
	  				dob: Time.at((date2.to_f - date1.to_f)*rand + date1.to_f).strftime('%y-%m-%d'),
	  				date_joined_organisation: today.strftime('%y-%m-%d'),
	  				category: 'Active (18yrs and over)',
	  				status: 'Active',
	  				season: "#{this_year}/#{next_yr}",
	  				organisation: club_name,
	  				patrol_name: patrol.name,
	  				default_position: default_position,
	  				bbm: bbm,
	  				irbd: irbd,
	  				irbc: irbc,
	  				artc: artc,
	  				spinal: spinal,
	  				firstaid: firstaid,
	  				bronze: bronze,
	  				src: src

	  				)

	  			user = User.find(user_id)

	  			puts '   '+user.name+' - '+user.default_position

	  			PatrolMember.create(

	  				user_id: user_id,
	  				default_position: default_position,
	  				patrol_name: patrol.name,
	  				organisation: club_name

					)

				# Create awards
				if user.bbm
					award_number = 'DNS'+rand.to_s[2..10]
					award_date = Date.today - 6.months
					Award.create(
						user_id: user_id,
						award_number: award_number,
						award_name: 'Silver Medallion Beach Management',
						award_date: award_date.strftime('%Y-%m-%d'),
						proficiency_date: (award_date+1.year).strftime('%Y-%m-%d'),
						originating_organisation: club.name
						)
				end
				if user.irbd
					award_number = 'DNS'+rand.to_s[2..10]
					award_date = Date.today - 6.months
					Award.create(
						user_id: user_id,
						award_number: award_number,
						award_name: 'Silver Medallion IRB Driver',
						award_date: award_date.strftime('%Y-%m-%d'),
						proficiency_date: (award_date+1.year).strftime('%Y-%m-%d'),
						originating_organisation: club.name
						)
				end
				if user.irbc
					award_number = 'DNS'+rand.to_s[2..10]
					award_date = Date.today - 6.months
					Award.create(
						user_id: user_id,
						award_number: award_number,
						award_name: 'IRB Crew Certificate',
						award_date: award_date.strftime('%Y-%m-%d'),
						proficiency_date: (award_date+1.year).strftime('%Y-%m-%d'),
						originating_organisation: club.name
						)
				end
				if user.artc
					award_number = 'DNS'+rand.to_s[2..10]
					award_date = Date.today - 6.months
					Award.create(
						user_id: user_id,
						award_number: award_number,
						award_name: 'Advanced Resuscitation Techniques Certificate',
						award_date: award_date.strftime('%Y-%m-%d'),
						proficiency_date: (award_date+1.year).strftime('%Y-%m-%d'),
						originating_organisation: club.name
						)
				end
				if user.bronze
					award_number = 'DNS'+rand.to_s[2..10]
					award_date = Date.today - 6.months
					Award.create(
						user_id: user_id,
						award_number: award_number,
						award_name: 'Bronze Medallion',
						award_date: award_date.strftime('%Y-%m-%d'),
						proficiency_date: (award_date+1.year).strftime('%Y-%m-%d'),
						originating_organisation: club.name
						)
				end

				user.awards.each do |award|
					puts '      '+award.award_number+' '+award.award_name
				end
			end
		end


		# Create patrol roster
		# start date, cycle through dates, check if saturday or sunday, morning or afternoon, allocate patrol, end date.
		(Date.new(Date.today.year, 9, 25)..Date.new(Date.today.year+1, 4, 30)).each do |date|
		  formatted_date = date.strftime('%Y-%m-%d')
		  if date.saturday? || date.sunday?
		  	Roster.create(
	    		start: Time.zone.parse(formatted_date + ' ' + '07:45' + ':00').utc.iso8601,
	    		finish: Time.zone.parse(formatted_date + ' ' + '13:00' + ':00').utc.iso8601,
	  			organisation: club.name,
	  			patrol_name: Patrol.where(organisation: club.name).sample.name,
	  			secret: Digest::SHA256.hexdigest(('a'..'z').to_a.shuffle[0,10].join)
		  	)
		  	roster = Roster.last
		  	puts roster.patrol_name+'   '+roster.start.strftime('%a %d %b %Y')+'   '+roster.start.strftime('%H:%M')+' - '+roster.finish.strftime('%H:%M')
		  	Roster.create(
	    		start: Time.zone.parse(formatted_date + ' ' + '12:45' + ':00').utc.iso8601,
	    		finish: Time.zone.parse(formatted_date + ' ' + '18:00' + ':00').utc.iso8601,
	  			organisation: club.name,
	  			patrol_name: Patrol.where(organisation: club.name).sample.name,
	  			secret: Digest::SHA256.hexdigest(('a'..'z').to_a.shuffle[0,10].join)
		  	)
			roster = Roster.last
		  	puts roster.patrol_name+'   '+roster.start.strftime('%a %d %b %Y')+'   '+roster.start.strftime('%H:%M')+' - '+roster.finish.strftime('%H:%M')
		  end
		end

		Roster.where(organisation: club.name).each do |roster|
			roster.awards_count
		end

	end

	desc "Destroy all records related to the fake club and it's members."
	task :destroy, [:club_name] => :environment do |task, args|

		club_name = args[:club_name]

		Club.where(name: club_name).destroy_all
		PatrolMember.where(organisation: club_name).destroy_all
		Patrol.where(organisation: club_name).destroy_all
		User.where(organisation: club_name).each do |user|
			Award.where(user_id: user.id).destroy_all
			user.destroy
		end
		Roster.where(organisation: club_name).destroy_all

	end

end
