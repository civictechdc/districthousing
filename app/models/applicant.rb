class Applicant < ActiveRecord::Base

  has_many :household_members, dependent: :destroy
  has_many :household_members_people, through: :household_members, source: :person, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :household_members, allow_destroy: true

  belongs_to :identity, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :identity

  has_many :residences, dependent: :destroy
  accepts_nested_attributes_for :residences, allow_destroy: true
  has_many :landlords, through: :residences, class_name: "Person", dependent: :destroy
  has_many :addresses, through: :residences, class_name: "Address", dependent: :destroy
  accepts_nested_attributes_for :landlords, allow_destroy: true

  belongs_to :user

  attr_accessible :identity_attributes, :landlords_attributes, :household_members_attributes, :residences_attributes

  def preferred_attrs_for field_names
    field_names.map do |field_name|
      begin
        preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def description
    identity.description
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
    when "Today"
      Date.today
    when "Now"
      now = Time.now
      "%d:%d" % [now.hour, now.sec]
    else
      identity.value_for_field(field_name)
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
