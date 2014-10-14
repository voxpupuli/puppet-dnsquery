#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'the dns_txt function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('dns_txt')).to eq('function_dns_txt')
  end

  it 'should raise a ArgumentError if there is less than 1 arguments' do
    expect { scope.function_dns_txt([]) }.to raise_error(ArgumentError)
  end

  it 'should return a list of lists of strings when doing a lookup' do
    results = scope.function_dns_txt(['google.com'])
    expect(results).to be_a Array
    expect(results).to all(be_a Array)
    expect(results).to all(all(be_a String))
  end
end
