day=$(date +"%u")

if ((day == 3)); then
   echo "Yay, it's WEDNESDAY! Let's send those email reminders..."

   # SEND PATROL EMAILS
   rails runner "Email.weekly_patrol_rosters()"

   # SEND SKILLS MAINTENANCE EMAILS
   rails runner "Email.weekly_skills_maintenance()"
else
   echo "It's not Wednesday so nothing to do today."
fi
