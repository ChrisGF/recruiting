class Deal < ActiveRecord::Base
  include Groundfloor::Addressable
  
  attr_accessor :messages
  
  belongs_to :user
  
  scope :published, -> {    
    self.with_state(:published)
  }
  
  monetize :amount_to_raise_cents
  
  CLOSE_TIMELINE = ['Jun 2014', 'Jul 2014', 'Aug 2014', 'Sep 2014', 'Oct 2014', 'Nov 2014', 'Dec 2014', '2015', "Flexible"]
  CAPITAL_TYPE =  ["Debt",  "Equity", "Both", "Flexible"]
  
  # RULES
  INVALID_DATES=['Jun 2014', 'Jul 2014', 'Aug 2014', 'Sep 2014', '']
  INVALID_CAPITAL_TYPES=['Equity','Both','']
  
  before_save :validate_project
  
  def published
    where(published:true)
  end
  
  state_machine :state, :initial => :new do
    
    event :upgrade do
      transition :new => :unpublished, :unpublished => :published, :published => :closed
    end    

    event :downgrade do
      transition :closed => :published, :published => :unpublished, :unpublished => :new
    end    
    
    event :pass_submission do
      transition any => :published
    end    

    event :fail_submission do
      transition any => :failed_submission
    end    

    event :publish do
      transition any => :published
    end    

    event :unpublish do
      transition any => :unpublished
    end
    
    state all - [:failed_submission, :new] do
      def acceptable?
        true
      end
    end

    state :failed_submission, :new do
      def acceptable?
        false
      end
    end
    
    state all - [:new, :unpublished] do
      def is_pending_approval?
        false
      end
    end
    
    state :new, :unpublished do
      def is_pending_approval?
        true
      end
    end
  
    state all - [:unpublished, :failed_submission, :new, :closed] do
      def is_published?
        true
      end
    end
    
    state :unpublished, :failed_submission, :new, :closed do
      def is_published?
        false
      end
    end
  end
  
  def state_name
    case self.state.to_s
    when "pending_submission"
      "Pending Approval"
    when "pending_approval"
      "Pending Approval"
    else
      self.state.split("_").join(" ")
    end
  end
  
  # Nested Attributes Objects.. Automatically build if there is nothing there
  def address
    super || build_address
  end
  
  def too_long_message
    "We are not currently accepting deals that end before Oct 2014"
  end
  
  def too_much_message
    "We are only accepting deals less than $200,000"
  end
  
  def invalid_capital_message
    "We are only accepting Debt and Flexible capital types"
  end
  
  def invalid_state_message
    "We are only accepting deals in Georgia"
  end

  def invalid_deal?
    self.messages = []
    self.messages.push(self.too_long_message) if INVALID_DATES.include?(self.close_timeline)
    self.messages.push(self.too_much_message) if self.amount_to_raise.cents > 20000000
    self.messages.push(self.invalid_capital_message) if INVALID_CAPITAL_TYPES.include?(self.capital_type)
    self.messages.push(self.invalid_state_message) if self.address.state != "GA"
    return !self.messages.empty?
  end
  
  def validate_project
    if invalid_deal?
      self.state = "failed_submission"
    else
      self.state = "published" unless self.closed?
    end
  end
  
end
