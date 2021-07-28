require 'test_helper'

class NotaFiscalDuplicatasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get nota_fiscal_duplicatas_new_url
    assert_response :success
  end

  test "should get create" do
    get nota_fiscal_duplicatas_create_url
    assert_response :success
  end

end
