require 'test_helper'

class EmpresasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @empresa = empresas(:one)
  end

  test "should get index" do
    get empresas_url
    assert_response :success
  end

  test "should get new" do
    get new_empresa_url
    assert_response :success
  end

  test "should create empresa" do
    assert_difference('Empresa.count') do
      post empresas_url, params: { empresa: { aliquota_cofins: @empresa.aliquota_cofins, aliquota_pis: @empresa.aliquota_pis, ambiente: @empresa.ambiente, bairro: @empresa.bairro, cep: @empresa.cep, cidade: @empresa.cidade, cnae: @empresa.cnae, cnpj: @empresa.cnpj, codcid_ibge: @empresa.codcid_ibge, codigo_uf_emitente: @empresa.codigo_uf_emitente, complemento: @empresa.complemento, credito_icms_pc: @empresa.credito_icms_pc, email: @empresa.email, emissor_nfe: @empresa.emissor_nfe, empresa_uninfe: @empresa.empresa_uninfe, endereco: @empresa.endereco, inscricao_estadual: @empresa.inscricao_estadual, inscricao_municipal: @empresa.inscricao_municipal, nome: @empresa.nome, nome_fantasia: @empresa.nome_fantasia, numero: @empresa.numero, pasta_envio: @empresa.pasta_envio, pasta_retorno: @empresa.pasta_retorno, permite_credito_icms: @empresa.permite_credito_icms, regime_tributario: @empresa.regime_tributario, senha: @empresa.senha, serie_nfe: @empresa.serie_nfe, telefone: @empresa.telefone, uf: @empresa.uf, versao_layout: @empresa.versao_layout } }
    end

    assert_redirected_to empresa_url(Empresa.last)
  end

  test "should show empresa" do
    get empresa_url(@empresa)
    assert_response :success
  end

  test "should get edit" do
    get edit_empresa_url(@empresa)
    assert_response :success
  end

  test "should update empresa" do
    patch empresa_url(@empresa), params: { empresa: { aliquota_cofins: @empresa.aliquota_cofins, aliquota_pis: @empresa.aliquota_pis, ambiente: @empresa.ambiente, bairro: @empresa.bairro, cep: @empresa.cep, cidade: @empresa.cidade, cnae: @empresa.cnae, cnpj: @empresa.cnpj, codcid_ibge: @empresa.codcid_ibge, codigo_uf_emitente: @empresa.codigo_uf_emitente, complemento: @empresa.complemento, credito_icms_pc: @empresa.credito_icms_pc, email: @empresa.email, emissor_nfe: @empresa.emissor_nfe, empresa_uninfe: @empresa.empresa_uninfe, endereco: @empresa.endereco, inscricao_estadual: @empresa.inscricao_estadual, inscricao_municipal: @empresa.inscricao_municipal, nome: @empresa.nome, nome_fantasia: @empresa.nome_fantasia, numero: @empresa.numero, pasta_envio: @empresa.pasta_envio, pasta_retorno: @empresa.pasta_retorno, permite_credito_icms: @empresa.permite_credito_icms, regime_tributario: @empresa.regime_tributario, senha: @empresa.senha, serie_nfe: @empresa.serie_nfe, telefone: @empresa.telefone, uf: @empresa.uf, versao_layout: @empresa.versao_layout } }
    assert_redirected_to empresa_url(@empresa)
  end

  test "should destroy empresa" do
    assert_difference('Empresa.count', -1) do
      delete empresa_url(@empresa)
    end

    assert_redirected_to empresas_url
  end
end
