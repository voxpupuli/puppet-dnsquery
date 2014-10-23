#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'the dns_a function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('dns_a')).to eq('function_dns_a')
  end

  it 'should raise a ArgumentError if there is less than 1 arguments' do
    expect { scope.function_dns_a([]) }.to raise_error(ArgumentError)
  end

  it 'should return a list of IPv4 addresses when doing a lookup' do
    results = scope.function_dns_a(['google.com'])
    expect(results).to be_a Array
    results.each do |res|
      expect(res).to match(/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)
    end
  end

  it 'should raise an error on empty reply' do
    expect { scope.function_dns_a(['foo.example.com']) }.to raise_error(Resolv::ResolvError)
  end
end
