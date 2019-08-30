require 'rex/parser/fusionvm_nokogiri'

module Msf::DBManager::Import::FusionVM
  def import_fusionvm_xml(args={})
    args[:wspace] = Msf::Util::DBManager.process_opts_workspace(args, framework).name
    bl = validate_ips(args[:blacklist]) ? args[:blacklist].split : []
    doc = Rex::Parser::FusionVMDocument.new(args,self)
    parser = ::Nokogiri::XML::SAX::Parser.new(doc)
    parser.parse(args[:data])
  end
end