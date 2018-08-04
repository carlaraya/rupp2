=begin
Professor
{"_id":"534ab2e4b1a8c802008d03e7","createdAt":"2014-04-13T15:53:08.846Z","firstName":"Aura Berta","lastName":"Abiera","rating":{"helpfulness":3.7058823529411766,"_numHelpfulness":17,"pedagogy":3.6470588235294117,"_numPedagogy":17,"easiness":2.9411764705882355,"_numEasiness":17,"overall":3.431372549019608,"_numOverall":0},"updatedAt":"2018-07-19T16:11:09.129Z"}

Rating
{"rating":{"helpfulness":3,"pedagogy":3,"easiness":3},"classTaken":"FIL 10","year":"2012","attendance":"true","comment":"Hindi siya gaanong magaling magturo at mahilig siya magparecite isa isa. Tapos madami ding reportings at readings. Mayroong dalawang exam pero mahirap at puro identification. May essay pero di siya mataas magbigay doon ng points. Overall ay medyo boring ang klase at karamihan ng output ay nanggaling sa mga estudyante.","professor_id":"534ab2e4b1a8c802008d03e7","user":{"ip":"10.34.186.222"},"createdAt":"2014-04-13T15:55:22.165Z","updatedAt":"2014-04-13T15:55:22.165Z","_id":"534ab36ab1a8c802008d03e8"}

Duplicates
Solamo, Weng ok
Marfil, Ramon Inigo ok???
Ona, Mark Philip ok
Soberano, Rubicon ok
Monsod, Toby Melissa ok
Roque, Marian ok
Shangkuan, Beverly ok
=end

puts "Creating professors hashes"
professors = JSON.parse(File.read('db/Professor.json'))
profs = professors.map{ |prof| {
  first_name: prof["firstName"],
  last_name: prof["lastName"],
  created_at: prof["createdAt"],
  updated_at: prof["updatedAt"]
} }
# filter profs with duplicate names
profs_uniq = profs.uniq { |pr| [pr[:first_name], pr[:last_name]] }
puts "Inserting professors hashes"
Professor.create!(profs_uniq)

reviews = JSON.parse(File.read('db/Review.json'))
puts "Creating reviews hashes"
revs = reviews.map{ |rev|
  professorObj = professors.find { |prof| prof["_id"] == rev["professor_id"] }
  {
    comment: rev["comment"],
    helpfulness: rev["rating"]["helpfulness"],
    pedagogy: rev["rating"]["pedagogy"],
    easiness: rev["rating"]["easiness"],
    class_taken: rev["classTaken"],
    year: rev["year"],
    attendance: rev["attendance"],
    professor_id: Professor.find_by(
      first_name: professorObj["firstName"],
      last_name: professorObj["lastName"]
    ).id,
    created_at: rev["createdAt"],
    updated_at: rev["updatedAt"]
  }
}
puts "Inserting reviews hashes"
Review.create!(revs)
