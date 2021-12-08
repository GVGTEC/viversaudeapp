require 'test_helper'

class OrcamentoItensControllerTest < ActionDispatch::IntegrationTest
  before do
    @orcamento_item = orcamento_itens(:one)
  end

  test 'should get index' do
    get orcamento_itens_url
    assert_response :success
  end

  test 'should get new' do
    get new_orcamento_item_url
    assert_response :success
  end

  test 'should create orcamento_item' do
    assert_difference('OrcamentoItem.count') do
      post orcamento_itens_url,
           params: { orcamento_item: { orcamento_id: @orcamento_item.orcamento_id, preco_total: @orcamento_item.preco_total,
                                       preco_unitario: @orcamento_item.preco_unitario, produto_id: @orcamento_item.produto_id, quantidade: @orcamento_item.quantidade } }
    end

    assert_redirected_to orcamento_item_url(OrcamentoItem.last)
  end

  test 'should show orcamento_item' do
    get orcamento_item_url(@orcamento_item)
    assert_response :success
  end

  test 'should get edit' do
    get edit_orcamento_item_url(@orcamento_item)
    assert_response :success
  end

  test 'should update orcamento_item' do
    patch orcamento_item_url(@orcamento_item),
          params: { orcamento_item: { orcamento_id: @orcamento_item.orcamento_id, preco_total: @orcamento_item.preco_total,
                                      preco_unitario: @orcamento_item.preco_unitario, produto_id: @orcamento_item.produto_id, quantidade: @orcamento_item.quantidade } }
    assert_redirected_to orcamento_item_url(@orcamento_item)
  end

  test 'should destroy orcamento_item' do
    assert_difference('OrcamentoItem.count', -1) do
      delete orcamento_item_url(@orcamento_item)
    end

    assert_redirected_to orcamento_itens_url
  end
end
