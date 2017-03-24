# Retrieves DNS TXT records and returns it as an array. Each record in the
# array will be a array containing the strings of the TXT record.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_txt) do
  dispatch :dns_txt do
    param 'String', :record
  end

  dispatch :dns_txt_with_default do
    param 'String', :record
    block_param
  end

  def dns_txt(record)
    Resolv::DNS.new.getresources(
      record, Resolv::DNS::Resource::IN::TXT
    ).collect do |res|
      res.strings
    end
  end

  def dns_txt_with_default(record)
    ret = dns_txt(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
