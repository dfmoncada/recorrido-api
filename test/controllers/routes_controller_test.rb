require 'test_helper'

class RoutesControllerTest < ActionDispatch::IntegrationTest
  test "returns all routes" do
    routes = [
      create(:route, name: 'Santiago => Peor es Nada'),
      create(:route, name: 'Peor es Nada => Santiago')
    ]

    get routes_path

    data = JSON.parse @response.body

    assert_equal routes.length, data.length
    assert_equal routes.map(&:id).sort, data.map{|d| d['id']}.sort
  end
end
