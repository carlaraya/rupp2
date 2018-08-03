module ApplicationHelper
    def display_name professor
	[professor.lastName, professor.firstName].join(", ")
    end
end
