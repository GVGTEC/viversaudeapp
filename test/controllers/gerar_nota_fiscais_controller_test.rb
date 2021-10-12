require 'test_helper'

class GerarNotaFiscaisControllerTest < ActionDispatch::IntegrationTest
  test 'should get gerar_nota' do
    get gerar_nota_fiscais_gerar_nota_url
    assert_response :success
  end
end
