require 'test_helper'

class NotaFiscaisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nota_fiscal = nota_fiscais(:one)
  end

  test "should get index" do
    get nota_fiscais_url
    assert_response :success
  end

  test "should get new" do
    get new_nota_fiscal_url
    assert_response :success
  end

  test "should create nota_fiscal" do
    assert_difference('NotaFiscal.count') do
      post nota_fiscais_url, params: { nota_fiscal: { cfop_id: @nota_fiscal.cfop_id, chave_acesso_nfe: @nota_fiscal.chave_acesso_nfe, cliente_id: @nota_fiscal.cliente_id, data_emissao: @nota_fiscal.data_emissao, data_saida: @nota_fiscal.data_saida, entsai: @nota_fiscal.entsai, fornecedor_id: @nota_fiscal.fornecedor_id, hora_saida: @nota_fiscal.hora_saida, meio_pagamento: @nota_fiscal.meio_pagamento, nota_cancelada_sn: @nota_fiscal.nota_cancelada_sn, numero_nota: @nota_fiscal.numero_nota, numero_parcelas_pagamento: @nota_fiscal.numero_parcelas_pagamento, numero_pedido: @nota_fiscal.numero_pedido, numero_pedido_compra: @nota_fiscal.numero_pedido_compra, observacao: @nota_fiscal.observacao, tipo_pagamento: @nota_fiscal.tipo_pagamento, valor_desconto: @nota_fiscal.valor_desconto, valor_frete: @nota_fiscal.valor_frete, valor_outras_despesas: @nota_fiscal.valor_outras_despesas, valor_produtos: @nota_fiscal.valor_produtos, valor_total_nota: @nota_fiscal.valor_total_nota, vendedor_id: @nota_fiscal.vendedor_id } }
    end

    assert_redirected_to nota_fiscal_url(NotaFiscal.last)
  end

  test "should show nota_fiscal" do
    get nota_fiscal_url(@nota_fiscal)
    assert_response :success
  end

  test "should get edit" do
    get edit_nota_fiscal_url(@nota_fiscal)
    assert_response :success
  end

  test "should update nota_fiscal" do
    patch nota_fiscal_url(@nota_fiscal), params: { nota_fiscal: { cfop_id: @nota_fiscal.cfop_id, chave_acesso_nfe: @nota_fiscal.chave_acesso_nfe, cliente_id: @nota_fiscal.cliente_id, data_emissao: @nota_fiscal.data_emissao, data_saida: @nota_fiscal.data_saida, entsai: @nota_fiscal.entsai, fornecedor_id: @nota_fiscal.fornecedor_id, hora_saida: @nota_fiscal.hora_saida, meio_pagamento: @nota_fiscal.meio_pagamento, nota_cancelada_sn: @nota_fiscal.nota_cancelada_sn, numero_nota: @nota_fiscal.numero_nota, numero_parcelas_pagamento: @nota_fiscal.numero_parcelas_pagamento, numero_pedido: @nota_fiscal.numero_pedido, numero_pedido_compra: @nota_fiscal.numero_pedido_compra, observacao: @nota_fiscal.observacao, tipo_pagamento: @nota_fiscal.tipo_pagamento, valor_desconto: @nota_fiscal.valor_desconto, valor_frete: @nota_fiscal.valor_frete, valor_outras_despesas: @nota_fiscal.valor_outras_despesas, valor_produtos: @nota_fiscal.valor_produtos, valor_total_nota: @nota_fiscal.valor_total_nota, vendedor_id: @nota_fiscal.vendedor_id } }
    assert_redirected_to nota_fiscal_url(@nota_fiscal)
  end

  test "should destroy nota_fiscal" do
    assert_difference('NotaFiscal.count', -1) do
      delete nota_fiscal_url(@nota_fiscal)
    end

    assert_redirected_to nota_fiscais_url
  end
end
