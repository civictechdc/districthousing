class Applicant < ActiveRecord::Base
  include Progress

  progress_includes :identity
  progress_includes_collection :household_members
  progress_includes_collection :residences
  progress_includes_collection :incomes
  progress_includes_collection :employments
  progress_includes_collection :criminal_histories

  has_many :people
  has_many :household_members, dependent: :destroy
  has_many :household_members_people, through: :household_members, source: :person, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :household_members, allow_destroy: true

  belongs_to :identity, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :identity

  has_many :residences, ->{ order(end: :desc) }, dependent: :destroy
  accepts_nested_attributes_for :residences, allow_destroy: true
  has_many :landlords, through: :residences, class_name: "Person", dependent: :destroy
  has_many :addresses, through: :residences, class_name: "Address", dependent: :destroy
  accepts_nested_attributes_for :landlords, allow_destroy: true

  belongs_to :user

  has_many :incomes, through: :people
  has_many :employments, through: :people
  has_many :criminal_histories, through: :people

  before_validation :initialize_applicant
  validates_associated :identity, :household_members, :residences, :employments, :incomes, :criminal_histories
  validates :identity, presence: true
  validates :user, presence: true

  def initialize_applicant
    self.identity ||= Person.create
  end

  def household_members_including_self
    [identity, household_members_people].flatten
  end

  def preferred_attrs_for field_names
    field_names.map do |field_name|
      begin
        preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def to_s
    identity.to_s
  end

  def field field_name
    value_for_field(field_name).to_s
  end

  def delegate_field_to item, field_name
    item && item.value_for_field(field_name) || ""
  end

  def value_for_field field_name
    case field_name
    when /^HH(\d+)(.*)$/
      index = $1.to_i - 1
      delegate_field_to household_members[index], $2
    when /^LL(\d+)(.*)$/
      index = $1.to_i - 1
      delegate_field_to landlords[index], $2
    when /^Address(\d+)(.*)$/
      index = $1.to_i - 1
      delegate_field_to addresses[index], $2
    when /^Address(.*)$/
      delegate_field_to addresses[0], $1
    when "Today"
      Date.today
    when "Now"
      now = Time.now
      "%d:%d" % [now.hour, now.sec]
    else
      identity && identity.value_for_field(field_name) || ""
    end
  end

  # returns an inumerable of incomes, aggregated by type and regardless of household member
  def incomes_by_type
    incomes = Hash.new(0)
    household_members.each do |member|
      member.incomes.each do |income|
        incomes[income.income_type_id] += income.amount
      end
    end
    # replace income type ID with Label value and sort in descending order
    Hash[incomes.map {|k, v| [IncomeType.find(k).label, v] }].sort_by {|k, v| v}.reverse
  end

end
