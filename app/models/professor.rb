class Professor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :department, type: String

  field :helpfulness, type: Float, default: 0.0
  field :pedagogy, type: Float, default: 0.0
  field :easiness, type: Float, default: 0.0
  field :overall, type: Float, default: 0.0

  index({ first_name: 1, last_name: 1 })

  has_many :reviews, before_add: :calculate_ratings

  validates_presence_of :first_name, :last_name
  

  def full_name
      [self.first_name, self.last_name] .join(" ")
  end

  def self.search query
      any_of(
		{first_name: /.*#{query}.*/i},
		{last_name: /.*#{query}.*/i}
	    
	    )
  end


  protected
  def calculate_ratings(review)
    reviews_count = self.reviews.count
    if reviews_count <= 0
      self.helpfulness = review.helpfulness
      self.pedagogy = review.pedagogy
      self.easiness = review.easiness
    else
      self.helpfulness = (helpfulness * reviews.length + review.helpfulness) / (reviews.length + 1)
      self.pedagogy = (pedagogy * reviews.length + review.pedagogy) / (reviews.length + 1)
      self.easiness = (easiness * reviews.length + review.easiness) / (reviews.length + 1)
    end
    self.overall = (pedagogy + easiness + helpfulness) / 3.0
    self.save
  end



end
