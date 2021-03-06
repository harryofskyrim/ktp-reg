class User < ApplicationRecord
	has_and_belongs_to_many :teams
	has_and_belongs_to_many :events
		
=begin
	scope :search_query, lambda { |query|
		return nil  if query.blank?
		@uppercase_alphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
		@lowercase_alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
	    def downcase_word(word)
			return word.tr(@uppercase_alphabet, @lowercase_alphabet)
		end                        
	
		#terms = query.downcase.split(/\s+/)
		query = downcase_word(query)
		terms = query.split(/\s+/)
		terms = terms.map { |e|
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}

		num_or_conds = 2
			where(
				terms.map { |term| "(LOWER(users.firstName) LIKE ? OR LOWER(users.lastName) LIKE ?)"}.join(' AND '),
				*terms.map { |e| [e] * num_or_conds }.flatten
			)
	}
	
	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		when /^school/
		order("LOWER(users.school) #{ direction }")
		else
		raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
		end
	}
	
	filterrific(
		available_filters: [
			:search_query, :sorted_by
	                       ]
	)
=end
	
	before_save { self.email = email.downcase }
	validates :lastName, presence: true, length: { maximum: 50 }
	validates :firstName, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :occupation, presence: true
	
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, :if => :password
	
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
