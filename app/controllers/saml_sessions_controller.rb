class SamlSessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ init consume ]

  skip_forgery_protection

  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings), allow_other_host: true)
  end

  def consume
    response          = OneLogin::RubySaml::Response.new(params[:SAMLResponse], allowed_clock_drift: 1.minute)
    response.settings = saml_settings

    # We validate the SAML Response and check if the user already exists in the system
    if response.is_valid?
      start_new_session_for User.find_or_create_with_email_address(response.attributes[yaml_settings["email_attribute"]])
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."  # This method shows an error message
    end
  end

  private

  def saml_settings
    settings = OneLogin::RubySaml::Settings.new

    settings.assertion_consumer_service_url = yaml_settings["assertion_consumer_service_url"]
    settings.sp_entity_id                   = yaml_settings["sp_entity_id"]
    settings.idp_entity_id                  = yaml_settings["idp_entity_id"]
    settings.idp_sso_service_url            = yaml_settings["idp_sso_service_url"]
    settings.idp_slo_service_url            = yaml_settings["idp_slo_service_url"]
    settings.idp_cert_fingerprint           = yaml_settings["idp_cert_fingerprint"]
    settings.idp_cert_fingerprint_algorithm = yaml_settings["idp_cert_fingerprint_algorithm"]

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    settings
  end

  def yaml_settings
    @yaml_settings ||= SamlSetting.instance.setting
  end
end
