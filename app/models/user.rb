class User < ActiveRecord::Base

    validates :login, presence: true, length: { maximum: 100 }, uniqueness: true
    validates :crypted_password, presence: true, length: { maximum: 40 }
    validates :salt, presence: true, length: { maximum: 40 }
    validates :email, presence: true, length: { maximum: 100 }, uniqueness: true
    validates :firstname, presence: true, length: { maximum: 100 }
    validates :lastname, presence: true, length: { maximum: 100 }

    has_many :task_lists, dependent: :destroy



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by login: login # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end



  # before action
  def encrypt_password(password)
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end

end