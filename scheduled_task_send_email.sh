day=$(date +"%u")

if ((day == 1)); then
   echo "Yay, it's MONDAY! Let's send those nudge emails..."

   # SEND OFFER NUDGE EMAILS
   rails runner "Email.weekly_nudge_offers()"

elif ((day == 3)); then
   echo "Yay, it's WEDNESDAY! Let's send those email reminders..."

   # SEND PATROL EMAILS
   rails runner "Email.weekly_patrol_rosters()"

   # SEND SKILLS MAINTENANCE EMAILS
   rails runner "Email.weekly_skills_maintenance()"

else
   echo "Nothing to do today."
fi
