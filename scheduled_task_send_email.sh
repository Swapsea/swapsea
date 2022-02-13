day=$(date +"%u")

if ((day == 3)); then
   echo "Yay, it's WEDNESDAY! Let's send those email reminders..."

   # SEND PATROL EMAILS
   rails runner "Email.weekly_patrol_rosters('Avalon Beach SLSC')"
   rails runner "Email.weekly_patrol_rosters('Bronte SLSC')"
   rails runner "Email.weekly_patrol_rosters('North Bondi SLSC')"
   rails runner "Email.weekly_patrol_rosters('Wanda SLSC Inc')"
   rails runner "Email.weekly_patrol_rosters('Whale Beach SLSC Inc')"

   # SEND SKILLS MAINTENANCE EMAILS
   rails runner "Email.weekly_skills_maintenance('Avalon Beach SLSC')"
   rails runner "Email.weekly_skills_maintenance('North Bondi SLSC')"
   rails runner "Email.weekly_skills_maintenance('Whale Beach SLSC Inc')"
else
   echo "It's not Wednesday so nothing to do today."
fi
