json.partial! "professors/professor", professor: @professor

json.reviews @professor.reviews do |review|
    json.extract! review, :comment, :helpfulness, :pedagogy, :easiness, :overall, :class_taken, :year, :attendance 
end
