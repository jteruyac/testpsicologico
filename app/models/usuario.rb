require 'digest/sha1'
require 'openssl'

class Usuario < ActiveRecord::Base
  has_many :evaluacions
  belongs_to :carrera
  belongs_to :institucion

  attr_reader :iv

  def crypt_nombre
    c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    c.encrypt
    c.key = Digest::SHA1.hexdigest("secretkey")
    @iv = c.random_iv
    c.iv = @iv
    e = c.update(nombre)
    e << c.final
    write_attribute("nombre", e)
  end

  def decrypt_nombre
    c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    c.decrypt
    c.key = Digest::SHA1.hexdigest("secretkey")
    c.iv = @iv
    d = c.update(nombre)
    d << c.final
    write_attribute("nombre", d)
  end



  def self.authenticate(usuario, password)
    first(:select => "id, nombre, administrador" ,:conditions => ["usuario = ? AND password = ?", usuario, sha1(password)])
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
