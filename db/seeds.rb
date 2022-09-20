# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

ActiveRecord::Base.transaction do
  Role.create(name: 'member')
  Role.create(name: 'manager')
  Role.create(name: 'admin')

  Club.create(name: 'Swapsea SLSC', short_name: 'Swapsea', is_active: true, show_patrols: true, show_rosters: true,
              show_swaps: true, show_skills_maintenance: true, show_outreach: false, lat: 0, lon: 0, enable_reminders_email: true, enable_reminders_sms: false)
  Patrol.create(organisation: 'Swapsea SLSC', name: 'Patrol 01', short_name:  'P01', need_bbm: 1, need_irbd: 1,
                need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  Patrol.create(organisation: 'Swapsea SLSC', name: 'Patrol 02', short_name:  'P02', need_bbm: 1, need_irbd: 1,
                need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  Patrol.create(organisation: 'Swapsea SLSC', name: 'Patrol 03', short_name:  'P03', need_bbm: 1, need_irbd: 1,
                need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  Patrol.create(organisation: 'Swapsea SLSC', name: 'Patrol 04', short_name:  'P04', need_bbm: 1, need_irbd: 1,
                need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)
  Patrol.create(organisation: 'Swapsea SLSC', name: 'Patrol 05', short_name:  'P05', need_bbm: 1, need_irbd: 1,
                need_irbc: 1, need_artc: 1, need_firstaid: 0, need_bronze: 3, need_src: 0)

  User.create(first_name: 'Alex', last_name: 'Admin', email: 'alex.admin@swapsea.com.au', password: 'swapsea',
              organisation: 'Swapsea SLSC')
  User.create(first_name: 'Mark', last_name: 'Manager', email: 'mark.manager@swapsea.com.au', password: 'swapsea',
              organisation: 'Swapsea SLSC')
  User.create(first_name: 'One', last_name: 'Member1', email: 'member1@swapsea.com.au', password: 'swapsea',
              organisation: 'Swapsea SLSC')
  User.create(first_name: 'Two', last_name: 'Member2', email: 'member2@swapsea.com.au', password: 'swapsea',
              organisation: 'Swapsea SLSC')
  User.create(first_name: 'Three', last_name: 'Member3', email: 'member3@swapsea.com.au', password: 'swapsea',
              organisation: 'Swapsea SLSC')
  User.create(first_name: 'Four', last_name: 'Member4', email: 'member4@swapsea.com.au', password: 'swapsea',
              organisation: 'Swapsea SLSC')

  User.find_by(email: 'alex.admin@swapsea.com.au').add_role(:admin)
  User.find_by(email: 'mark.manager@swapsea.com.au').add_role(:manager)
  User.find_by(email: 'member1@swapsea.com.au').add_role(:member)
  User.find_by(email: 'member2@swapsea.com.au').add_role(:member)
  User.find_by(email: 'member3@swapsea.com.au').add_role(:member)
  User.find_by(email: 'member4@swapsea.com.au').add_role(:member)
end
