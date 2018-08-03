class Professor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :firstName, type: String
  field :lastName, type: String
  field :helpfulness, type: Float, default: 0.0
  field :pedagogy, type: Float, default: 0.0
  field :easiness, type: Float, default: 0.0
  field :overall, type: Float, default: 0.0
  validates_presence_of :firstName, :lastName

  has_many :reviews, after_add: :calculate_ratings

  protected
  def calculate_ratings(review)
    reviews_count = self.reviews.count
    if reviews_count <= 0
      self.helpfulness = review.helpfulness
      self.pedagogy = review.pedagogy
      self.easiness = review.easiness
    else
      self.helpfulness = (helpfulness * reviews_count + review.helpfulness) / (reviews_count + 1)
      self.pedagogy = (pedagogy * reviews_count + review.pedagogy) / (reviews_count + 1)
      self.easiness = (easiness * reviews_count + review.easiness) / (reviews_count + 1)
    end
    self.overall = (pedagogy + easiness + helpfulness) / 3.0
  end


end


