# frozen_string_literal: true

require_relative '../../../puppet_x/voxpupuli/dnsquery/util'

# Retrieves DNS NS records for a domain and return as an array.
Puppet::Functions.create_function(:'dnsquery::ns') do
  # @param domain the dns question to lookup
  # @param config_info used to override the config for Resolve::DNS.new
  # @param block an optional lambda to return a default value in case the lookup fails
  # @return The ns domain for a domain
  dispatch :dns_ns do
    param 'Dnsquery::Rr_name', :domain
    optional_param 'Optional[Dnsquery::Config_info]', :config_info
    optional_block_param :block
    return_type 'Array[String]'
  end

  def dns_ns(domain, config_info = nil)
    resolver = PuppetX::Voxpupuli::Dnsquery::Utils.resolver(config_info)
    ret = resolver.getresources(
      domain, Resolv::DNS::Resource::IN::NS
    ).map do |res|
      res.name.to_s
    end
    (block_given? && ret.empty?) ? yield : ret
  rescue Resolv::ResolvError
    block_given? ? yield : raise
  end
end
