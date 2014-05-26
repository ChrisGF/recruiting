class Deal < ActiveRecord::Base
  include Groundfloor::Addressable
  
  belongs_to :user
  
  scope :published, -> {    
    self.with_state(:published)
  }
  
  monetize :amount_to_raise_cents
  
  CLOSE_TIMELINE = ['Jun 2014', 'Jul 2014', 'Aug 2014', 'Sep 2014', 'Oct 2014', 'Nov 2014', 'Dec 2014', '2015', "Flexible"]
  CAPITAL_TYPE =  ["Debt",  "Equity", "Both", "Flexible"]
  
  # RULES
  INVALID_DATES=['Jun 2014', 'Jul 2014', 'Aug 2014', 'Sep 2014']
  INVALID_CAPITAL_TYPES=['Equity','Both','']
  
  before_save :validate_project
  
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

  def invalid_deal?
    ( INVALID_DATES.include?(self.close_timeline) ||
      self.amount_to_raise > 200000 ||
      INVALID_CAPITAL_TYPES.include?(self.capital_type) ||
      self.address.state != 'GA'
    )
  end
  
  def validate_project
    if invalid_deal?
      self.state = "failed_submission"
    else
      self.state = "published" unless self.closed?
    end
  end
  
end
