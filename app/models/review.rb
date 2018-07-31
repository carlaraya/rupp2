class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment, type: String
  field :helpfulness, type: Integer
  field :pedagogy, type: Integer
  field :easiness, type: Integer
  field :overall, type: Float
  field :classTaken, type: String
  field :year, type: String
  field :attendance, type: String

  validates_presence_of :helpfulness, :pedagogy, :easiness

  belongs_to :professor, counter_cache: true

  before_save :assign_overall

  protected
  def assign_overall
    self.overall = (pedagogy + easiness + helpfulness) / 3.0
  end
end
