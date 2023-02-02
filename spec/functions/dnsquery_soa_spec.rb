#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'dnsquery::soa' do
  it 'should return a hash of SOA-records parts when doing a lookup' do
    results = subject.execute('google.com')
    expect(results).to be_a Hash
    expect(results['expire']).to be_a Integer
    expect(results['minimum']).to be_a Integer
    expect(results['mname']).to be_a Resolv::DNS::Name
    expect(results['refresh']).to be_a Integer
    expect(results['retry']).to be_a Integer
    expect(results['rname']).to be_a Resolv::DNS::Name
    expect(results['serial']).to be_a Integer
  end
end

