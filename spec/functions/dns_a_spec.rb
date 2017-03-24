#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'dns_a' do
  it 'should return a list of IPv4 addresses when doing a lookup' do
    results = subject.execute('google.com')
    expect(results).to be_a Array
    results.each do |res|
      expect(res).to match(/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)
    end
  end

  it 'returns lambda value if result is empty' do
    skip('This needs rspec-puppet 2.6+, not available now')

    is_expected.to run
      .with_params('foo.example.com')
      .and_return('127.0.0.1')
      .with_lambda('127.0.0.1')
  end
end
