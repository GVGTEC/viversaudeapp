require "application_system_test_case"

class EmpresasTest < ApplicationSystemTestCase
  setup do
    @empresa = empresas(:one)
  end

  test "visiting the index" do
    visit empresas_url
    assert_selector "h1", text: "Empresas"
  end

  test "creating a Empresa" do
    visit empresas_url
    click_on "New Empresa"

    fill_in "Aliquota cofins", with: @empresa.aliquota_cofins
    fill_in "Aliquota pis", with: @empresa.aliquota_pis
    fill_in "Ambiente", with: @empresa.ambiente
    fill_in "Bairro", with: @empresa.bairro
    fill_in "Cep", with: @empresa.cep
    fill_in "Cidade", with: @empresa.cidade
    fill_in "Cnae", with: @empresa.cnae
    fill_in "Cnpj", with: @empresa.cnpj
    fill_in "Codcid ibge", with: @empresa.codcid_ibge
    fill_in "Codigo uf emitente", with: @empresa.codigo_uf_emitente
    fill_in "Complemento", with: @empresa.complemento
    fill_in "Credito icms pc", with: @empresa.credito_icms_pc
    fill_in "Email", with: @empresa.email
    fill_in "Emissor nfe", with: @empresa.emissor_nfe
    fill_in "Empresa uninfe", with: @empresa.empresa_uninfe
    fill_in "Endereco", with: @empresa.endereco
    fill_in "Inscricao estadual", with: @empresa.inscricao_estadual
    fill_in "Inscricao municipal", with: @empresa.inscricao_municipal
    fill_in "Nome", with: @empresa.nome
    fill_in "Nome fantasia", with: @empresa.nome_fantasia
    fill_in "Numero", with: @empresa.numero
    fill_in "Pasta envio", with: @empresa.pasta_envio
    fill_in "Pasta retorno", with: @empresa.pasta_retorno
    fill_in "Permite credito icms", with: @empresa.permite_credito_icms
    fill_in "Regime tributario", with: @empresa.regime_tributario
    fill_in "Senha", with: @empresa.senha
    fill_in "Serie-nfe", with: @empresa.serie-nfe
    fill_in "Telefone", with: @empresa.telefone
    fill_in "Uf", with: @empresa.uf
    fill_in "Versao layout", with: @empresa.versao_layout
    click_on "Create Empresa"

    assert_text "Empresa was successfully created"
    click_on "Back"
  end

  test "updating a Empresa" do
    visit empresas_url
    click_on "Edit", match: :first

    fill_in "Aliquota cofins", with: @empresa.aliquota_cofins
    fill_in "Aliquota pis", with: @empresa.aliquota_pis
    fill_in "Ambiente", with: @empresa.ambiente
    fill_in "Bairro", with: @empresa.bairro
    fill_in "Cep", with: @empresa.cep
    fill_in "Cidade", with: @empresa.cidade
    fill_in "Cnae", with: @empresa.cnae
    fill_in "Cnpj", with: @empresa.cnpj
    fill_in "Codcid ibge", with: @empresa.codcid_ibge
    fill_in "Codigo uf emitente", with: @empresa.codigo_uf_emitente
    fill_in "Complemento", with: @empresa.complemento
    fill_in "Credito icms pc", with: @empresa.credito_icms_pc
    fill_in "Email", with: @empresa.email
    fill_in "Emissor nfe", with: @empresa.emissor_nfe
    fill_in "Empresa uninfe", with: @empresa.empresa_uninfe
    fill_in "Endereco", with: @empresa.endereco
    fill_in "Inscricao estadual", with: @empresa.inscricao_estadual
    fill_in "Inscricao municipal", with: @empresa.inscricao_municipal
    fill_in "Nome", with: @empresa.nome
    fill_in "Nome fantasia", with: @empresa.nome_fantasia
    fill_in "Numero", with: @empresa.numero
    fill_in "Pasta envio", with: @empresa.pasta_envio
    fill_in "Pasta retorno", with: @empresa.pasta_retorno
    fill_in "Permite credito icms", with: @empresa.permite_credito_icms
    fill_in "Regime tributario", with: @empresa.regime_tributario
    fill_in "Senha", with: @empresa.senha
    fill_in "Serie-nfe", with: @empresa.serie-nfe
    fill_in "Telefone", with: @empresa.telefone
    fill_in "Uf", with: @empresa.uf
    fill_in "Versao layout", with: @empresa.versao_layout
    click_on "Update Empresa"

    assert_text "Empresa was successfully updated"
    click_on "Back"
  end

  test "destroying a Empresa" do
    visit empresas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Empresa was successfully destroyed"
  end
end
