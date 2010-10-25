SUPPORTED_LOCALES = /(en|ru|uk|br)/

Prometheus20::Application.routes.draw do |map|
  match '(/:locale)/iphone/' => 'iphone#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packager/:login' => 'iphone#maintainer_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/search' => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/find.shtml' => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/news' => 'pages#news', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/rss' => 'pages#rss', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/security' => 'pages#security', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/project' => 'pages#project', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages' => 'home#groups_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/people' => 'home#maintainers_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/team/:name' => 'team#info', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packager/:login' => 'maintainer#info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms' => 'maintainer#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/acls' => 'maintainer#acls', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/gear' => 'maintainer#gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/bugs' => 'maintainer#bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/allbugs' => 'maintainer#allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/repocop' => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }
#  match '(/:locale)/packager/:login/repocop/rss' => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages/:group(/:group2(/:group3))' => 'home#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/srpm/:branch/:name' => 'srpm#main', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/changelog' => 'srpm#changelog', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/spec' => 'srpm#rawspec', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/get' => 'srpm#download', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/gear' => 'srpm#gear', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/bugs' => 'srpm#bugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/allbugs' => 'srpm#allbugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/repocop' => 'srpm#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
#  match '(/:locale)/srpm/:branch/:name/repocop.:format' => 'home#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }

#  match '/repocop' => 'repocop#index'
#  match '/repocop/by-test/:testname' => 'repocop#bytest'

  match '(/:locale)/cli/srpm/:branch/:vendor/:name' => 'cli#srpm_info', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)' => 'home#index', :constraints => { :locale => SUPPORTED_LOCALES }

  root :to => "home#index"

  match '/sitemap.xml' => 'sitemap#sitemap_full'
  match '/sitemap_basic.xml' => 'sitemap#sitemap_basic'
  match '/:locale/sitemap1.xml' => 'sitemap#sitemap_part1', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap2.xml' => 'sitemap#sitemap_part2', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap3.xml' => 'sitemap#sitemap_part3', :constraints => { :locale => SUPPORTED_LOCALES }
end