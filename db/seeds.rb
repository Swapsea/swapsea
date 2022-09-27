# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

ActiveRecord::Base.transaction do
  Role.create(name: 'member')
  Role.create(name: 'manager')
  Role.create(name: 'admin')

  club = Club.create(name: 'Swapsea SLSC', short_name: 'Swapsea', is_active: true, show_patrols: true, show_rosters: true,
                     show_swaps: true, show_skills_maintenance: true, show_outreach: false, lat: 0, lon: 0, enable_reminders_email: true, enable_reminders_sms: false)

  club_inactive = Club.create(name: 'InactiveClub SLSC', short_name: 'InactiveClub', is_active: false, show_patrols: true, show_rosters: true,
                              show_swaps: true, show_skills_maintenance: true, show_outreach: false, lat: 0, lon: 0, enable_reminders_email: true, enable_reminders_sms: false)

  p1 = Patrol.create(club:, name: 'Patrol 01', short_name:  'P01', need_bbm: 1, need_irbd: 1,
                     need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  p2 = Patrol.create(club:, name: 'Patrol 02', short_name:  'P02', need_bbm: 1, need_irbd: 1,
                     need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  p3 = Patrol.create(club:, name: 'Patrol 03', short_name:  'P03', need_bbm: 1, need_irbd: 1,
                     need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  p4 = Patrol.create(club:, name: 'Patrol 04', short_name:  'P04', need_bbm: 1, need_irbd: 1,
                     need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)

  user = User.create(first_name: 'Adam', last_name: 'Admin', email: 'mark+admin@swapsea.com.au', password: 'swapsea',
                     club:)
  user.add_role(:admin)

  user = User.create(first_name: 'Manny', last_name: 'Manager', email: 'mark+manager@swapsea.com.au', password: 'swapsea',
                     club:)
  user.add_role(:manager)

  user = User.create(first_name: 'One', last_name: 'Member1', email: 'mark+member1@swapsea.com.au', password: 'swapsea',
                     club:)
  user.add_role(:member)
  PatrolMember.create(user:, patrol: p1, default_position: 'Patrol Captain')

  user = User.create(first_name: 'Two', last_name: 'Member2', email: 'mark+member2@swapsea.com.au', password: 'swapsea',
                     club:)
  user.add_role(:member)
  PatrolMember.create(user:, patrol: p2, default_position: 'Patrol Vice Captain')

  user = User.create(first_name: 'Three', last_name: 'Member3', email: 'mark+member3@swapsea.com.au', password: 'swapsea',
                     club:)
  user.add_role(:member)
  PatrolMember.create(user:, patrol: p3, default_position: 'Member')

  user = User.create(first_name: 'Four', last_name: 'Member4', email: 'mark+member4@swapsea.com.au', password: 'swapsea',
                     club:)
  user.add_role(:member)
  PatrolMember.create(user:, patrol: p4, default_position: 'SRC')
end
