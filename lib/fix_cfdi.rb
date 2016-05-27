require 'nokogiri'
require 'mechanize'
require "fix_cfdi/version"

module FixCfdi
  # Your code goes here...
  def verify_rfc(rfc)
    agent = Mechanize.new
    rfc_page = agent.get 'https://portalsat.plataforma.sat.gob.mx/ConsultaRFC/'
    check_form = rfc_page.form
    rfc_field = check_form.field_with(name: 'ConsultaForm:rfc')
    rfc_field.value = rfc.to_s
    button = check_form.button_with(name: 'ConsultaForm:_idJsp32')
    result = agent.submit(check_form, button)
    Nokogiri::HTML(result.body).search('.oBText').children
  end
  module_function :verify_rfc
end
