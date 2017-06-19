# Statuses
Status.create(label: "prospective")
Status.create(label: "pending")
Status.create(label: "approved")
Status.create(label: "inactive")
Status.create(label: "banned")

# Teaching Assistants (with varying status levels)
prospective = Status.find_by_label("prospective")
TeachingAssistant.create(name: "Prospective TA", email: "prospective@ta.com", status_id: prospective.id)

pending = Status.find_by_label("pending")
TeachingAssistant.create(name: "Pending TA", email: "pending@ta.com", status_id: pending.id)

approved = Status.find_by_label("approved")
TeachingAssistant.create(name: "Approved TA", email: "approved@ta.com", status_id: approved.id)

inactive = Status.find_by_label("inactive")
TeachingAssistant.create(name: "Inactive TA", email: "inactive@ta.com", status_id: inactive.id)

banned = Status.find_by_label("banned")
TeachingAssistant.create(name: "Banned TA", email: "banned@ta.com", status_id: banned.id)
