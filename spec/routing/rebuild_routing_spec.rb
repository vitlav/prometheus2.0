require File.expand_path(File.dirname(__FILE__) + '/../rails_helper')

describe 'Rebuild routing' do
  it 'should route /rebuild to rebuild#index' do
    expect(get: '/rebuild').to route_to('rebuild#index')
  end

  it 'should route /:locale/rebuild to rebuild#index' do
    expect(get: '/en/rebuild').to route_to(
      controller: 'rebuild',
      action: 'index',
      locale: 'en'
    )
  end
end
