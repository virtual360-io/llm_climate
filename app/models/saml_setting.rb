class SamlSetting
  include Singleton

  def setting
    @setting ||= YAML.load_file("#{Rails.root}/config/saml.yml")[Rails.env]
  end

  def setting_exists?
    @setting_exists ||= File.exist?("#{Rails.root}/config/saml.yml")
  end
end
