# encoding: utf-8

require 'spec_helper'

describe Acl do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :maintainer }
    it { should belong_to :srpm }
  end

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :maintainer }
    it { should validate_presence_of :srpm }
  end

  it { should have_db_index :branch_id }
  it { should have_db_index :maintainer_id }
  it { should have_db_index :srpm_id }

  pending "acl import and update"
end
