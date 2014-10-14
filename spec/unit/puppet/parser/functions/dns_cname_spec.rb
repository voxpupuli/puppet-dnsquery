#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'the dns_cname function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('dns_cname')).to eq('function_dns_cname')
  end

  it 'should raise a ArgumentError if there is less than 1 arguments' do
    expect { scope.function_dns_cname([]) }.to raise_error(ArgumentError)
  end

  it 'should return a CNAME destination when doing a lookup' do
    result = scope.function_dns_cname(['mail.google.com'])
    expect(result).to be_a String
  end
end
