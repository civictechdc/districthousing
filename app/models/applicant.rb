  class Applicant < ActiveRecord::Base
  include Progress

  progress_includes :identity
  progress_includes_collection :household_members
  progress_includes_collection :residences
  progress_includes_collection :incomes
  progress_includes_collection :employments
  progress_includes_collection :criminal_histories
  progress_includes_collection :contacts

  has_many :people
  has_many :household_members, dependent: :destroy
  has_many :household_members_people, through: :household_members, source: :person, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :household_members, allow_destroy: true

  has_many :contacts, dependent: :destroy
  has_many :contacts_people, through: :contacts, source: :person, class_name: "Contact", dependent: :destroy
  accepts_nested_attributes_for :contacts, allow_destroy: true

  belongs_to :identity, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :identity

  has_many :residences, ->{ order(current: :desc, end: :desc) }, dependent: :destroy
  accepts_nested_attributes_for :residences, allow_destroy: true
  has_many :landlords, through: :residences, class_name: "Person", dependent: :destroy
  accepts_nested_attributes_for :landlords, allow_destroy: true

  belongs_to :user

  has_many :incomes, through: :people
  has_many :employments, through: :people
  has_many :criminal_histories, through: :people

  has_one :salesforce_applicant

  has_and_belongs_to_many :housing_forms

  before_validation :initialize_applicant
  validates_associated :identity, :household_members, :residences, :employments, :incomes, :criminal_histories, :contacts
  validates :identity, presence: true
  validates :user, presence: true

  def initialize_applicant
    self.identity ||= Person.create
  end

  def household_members_including_self
    [identity, household_members_people].flatten.compact.uniq
  end

  # The many kinds of addresses an applicant has
  has_many :residence_addresses, through: :residences, source: :address, dependent: :destroy
  has_many :household_members_people_mail_addresses, through: :household_members_people, source: :mail_address, class_name: "Address", dependent: :destroy
  has_many :employment_addresses, through: :employments, source: :address, dependent: :destroy

  def addresses
    [identity.mail_address,
     residence_addresses,
     household_members_people_mail_addresses,
     employment_addresses
    ].flatten.compact.uniq { |a| a.to_s }
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

  def current_residence
    residences.where(current: true).first
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
    when /^Residence(\d+)(.*)$/
      index = $1.to_i - 1
      delegate_field_to residences[index], $2
    when /^Residence(.*)$/
      delegate_field_to residences[0], $1
    when /^Address(\d+)(.*)$/
      index = $1.to_i - 1
      delegate_field_to residences[index], $2
    when /^Address(.*)$/
      delegate_field_to residences[0], $1
    when /^Job(\d+)(.+)$/
      index = $1.to_i - 1
      delegate_field_to employments[index], $2
    when /^Job(.+)$/
      delegate_field_to employments[0], $1
    when /^Contact(\d+)(.+)$/
      index = $1.to_i - 1
      delegate_field_to contacts[index], $2
    when /^Contact(.+)$/
      delegate_field_to contacts[0], $1
    when /^Income(\d+)(.+)$/
      index = $1.to_i - 1
      delegate_field_to incomes[index], $2
    when /^Income(.+)$/
      delegate_field_to incomes[0], $1
    when /^Crime(\d+)(.+)$/
      index = $1.to_i - 1
      delegate_field_to criminal_histories[index], $2
    when /^Crime(.+)$/
      delegate_field_to criminal_histories[0], $1
    else
      identity && identity.value_for_field(field_name) || ""
    end
  end

end
