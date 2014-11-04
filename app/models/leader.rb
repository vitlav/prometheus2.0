class Leader
  # TODO: send Branch instance instead vendor_name and branch_name
  # TODO: move leader url to Branch class
  def self.update_redis_cache(vendor_name, branch_name, url)
    branch = Branch.where(name: branch_name, vendor: vendor_name).first
    file = open(URI.escape(url)).read
    Redis.current.multi

    branch.srpms.select('name').all.each do |srpm|
      Redis.current.del("#{ branch.name }:#{ srpm.name }:leader")
    end

    file.each_line do |line|
      package = line.split[0]
      Redis.current.del("#{ branch.name }:#{ package }:leader")
      login = line.split[1]
      login = 'php-coder' if login == 'php_coder'
      login = 'p_solntsev' if login == 'psolntsev'
      login = '@vim-plugins' if login == '@vim_plugins'
      Redis.current.set("#{ branch.name }:#{ package }:leader", login)
    end

    Redis.current.exec
  end
end
