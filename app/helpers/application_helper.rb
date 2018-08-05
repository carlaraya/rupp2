module ApplicationHelper
    def display_name professor
	[professor.last_name, professor.first_name].join(", ")
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

    def display_float float
	number_with_precision(float, precision: 2)
    end

    def get_rating_name value
	if value <= 1
	    word = "Very poor"
	elsif value <= 2
	    word = "Poor"
	elsif value <= 3
	    word = "Fair"
	elsif value <= 4
	    word = "Good"
	else
	    word = "Excellent"
	end
	word
    end
end
