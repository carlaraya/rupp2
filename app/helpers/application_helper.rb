module ApplicationHelper
    def display_name professor
	[professor.lastName, professor.firstName].join(", ")
    end

    def get_rating_color value
	if value <= 2.0
	    color = "is-danger"
	elsif value <= 3
	    color = "is-warning"
	else
	    color = "is-success"
	end
	color
    end
end
