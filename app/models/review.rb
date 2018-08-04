class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment, type: String
  field :helpfulness, type: Integer
  field :pedagogy, type: Integer
  field :easiness, type: Integer
  field :overall, type: Float
  field :class_taken, type: String
  field :year, type: Integer
  field :attendance, type: String

  validates_presence_of :helpfulness, :pedagogy, :easiness
  validates :helpfulness, inclusion: { in: (1..5) }
  validates :pedagogy, inclusion: { in: (1..5) }
  validates :easiness, inclusion: { in: (1..5) }
  validate :year_within_range

  belongs_to :professor, index: true

  before_save :assign_overall

  protected
  def year_within_range
    errors.add(:year, "is not within range") unless (1970..Date.current.year).include? year
  end

  def assign_overall
    self.overall = (pedagogy + easiness + helpfulness) / 3.0
  end
end
