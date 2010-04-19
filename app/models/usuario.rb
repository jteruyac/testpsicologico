require 'digest/sha1'
class Usuario < ActiveRecord::Base
  has_many :evaluacions
  belongs_to :carrera
  belongs_to :institucion

  def self.authenticate(usuario, password)
    first(:conditions => ["usuario = ? AND password = ?", usuario, sha1(password)])
  end

  protected

  def self.sha1(password)
    Digest::SHA1.hexdigest("change-me--#{password}--")
  end

  before_create :crypt_password

  def crypt_password
    write_attribute("password", self.class.sha1(password))
  end


end
