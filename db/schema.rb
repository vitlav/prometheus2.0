# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101003232213) do

  create_table "acls", :force => true do |t|
    t.string   "package"
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
  end

  add_index "acls", ["branch_id"], :name => "index_acls_on_branch_id"
  add_index "acls", ["login"], :name => "index_acls_on_login"
  add_index "acls", ["package"], :name => "index_acls_on_package"

  create_table "branches", :force => true do |t|
    t.string   "vendor"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "bugs", :force => true do |t|
    t.integer  "bug_id"
    t.string   "bug_status"
    t.string   "resolution"
    t.string   "bug_severity"
    t.string   "product"
    t.string   "component"
    t.string   "assigned_to"
    t.string   "reporter"
    t.string   "short_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gitrepos", :force => true do |t|
    t.string   "repo"
    t.string   "login"
    t.datetime "lastchange"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
  end

  add_index "groups", ["branch_id"], :name => "index_groups_on_branch_id"

  create_table "leaders", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.integer  "srpm_id"
    t.integer  "packager_id"
  end

  add_index "leaders", ["branch_id"], :name => "index_leaders_on_branch_id"
  add_index "leaders", ["packager_id"], :name => "index_leaders_on_packager_id"
  add_index "leaders", ["srpm_id"], :name => "index_leaders_on_srpm_id"

  create_table "maintainers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.boolean  "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "filename"
    t.string   "sourcepackage"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "epoch"
    t.string   "arch"
    t.string   "summary"
    t.string   "license"
    t.string   "url"
    t.text     "description"
    t.datetime "buildtime"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "srpm_id"
    t.integer  "branch_id"
    t.integer  "group_id"
  end

  add_index "packages", ["arch"], :name => "index_packages_on_arch"
  add_index "packages", ["branch_id"], :name => "index_packages_on_branch_id"
  add_index "packages", ["group_id"], :name => "index_packages_on_group_id"
  add_index "packages", ["sourcepackage"], :name => "index_packages_on_sourcepackage"
  add_index "packages", ["srpm_id"], :name => "index_packages_on_srpm_id"

  create_table "repocops", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "arch"
    t.string   "srcname"
    t.string   "srcversion"
    t.string   "srcrel"
    t.string   "testname"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repocops", ["srcname"], :name => "index_repocops_on_srcname"
  add_index "repocops", ["srcrel"], :name => "index_repocops_on_srcrel"
  add_index "repocops", ["srcversion"], :name => "index_repocops_on_srcversion"

  create_table "srpms", :force => true do |t|
    t.string   "filename"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "epoch"
    t.string   "summary"
    t.string   "license"
    t.string   "url"
    t.text     "description"
    t.datetime "buildtime"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repocop",     :default => "skip"
    t.integer  "branch_id"
    t.integer  "group_id"
  end

  add_index "srpms", ["branch_id"], :name => "index_srpms_on_branch_id"
  add_index "srpms", ["group_id"], :name => "index_srpms_on_group_id"
  add_index "srpms", ["name"], :name => "index_srpms_on_name"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
  end

  add_index "teams", ["branch_id"], :name => "index_teams_on_branch_id"

end
