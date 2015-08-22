module API
  module Entities
    class Package < Grape::Entity
      expose :id
      expose :srpm_id
      expose :name
      expose :version
      expose :release
      expose :epoch
      expose :filename
      expose :sourcepackage
      expose :arch
      expose :summary
      expose :groupname, as: :group
      expose :group_id
      expose :license
      expose :url
      expose :description
      expose :buildtime
      expose :md5
      expose :size
      expose :created_at
      expose :updated_at
    end
  end
end