# frozen_string_literal: true

# Retrieves a DNS CNAME record and returns it as a string.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:'dnsquery::cname') do
  dispatch :dns_cname do
    param 'String', :record
  end

  dispatch :dns_cname_with_default do
    param 'String', :record
    block_param
  end

  def dns_cname(record)
    Resolv::DNS.new.getresource(
      record, Resolv::DNS::Resource::IN::CNAME
    ).name.to_s
  end

  def dns_cname_with_default(record)
    dns_cname(record)
  rescue Resolv::ResolvError
    yield
  end
end
