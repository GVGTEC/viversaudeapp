require "application_system_test_case"

class TransportadorasTest < ApplicationSystemTestCase
  setup do
    @transportadora = transportadoras(:one)
  end

  test "visiting the index" do
    visit transportadoras_url
    assert_selector "h1", text: "Transportadoras"
  end

  test "creating a Transportadora" do
    visit transportadoras_url
    click_on "New Transportadora"

    fill_in "Bairro", with: @transportadora.bairro
    fill_in "Cep", with: @transportadora.cep
    fill_in "Cidade", with: @transportadora.cidade
    fill_in "Cnpj", with: @transportadora.cnpj
    fill_in "Endereco", with: @transportadora.endereco
    fill_in "Ie", with: @transportadora.ie
    fill_in "Nome", with: @transportadora.nome
    fill_in "Uf", with: @transportadora.uf
    click_on "Create Transportadora"

    assert_text "Transportadora was successfully created"
    click_on "Back"
  end

  test "updating a Transportadora" do
    visit transportadoras_url
    click_on "Edit", match: :first

    fill_in "Bairro", with: @transportadora.bairro
    fill_in "Cep", with: @transportadora.cep
    fill_in "Cidade", with: @transportadora.cidade
    fill_in "Cnpj", with: @transportadora.cnpj
    fill_in "Endereco", with: @transportadora.endereco
    fill_in "Ie", with: @transportadora.ie
    fill_in "Nome", with: @transportadora.nome
    fill_in "Uf", with: @transportadora.uf
    click_on "Update Transportadora"

    assert_text "Transportadora was successfully updated"
    click_on "Back"
  end

  test "destroying a Transportadora" do
    visit transportadoras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transportadora was successfully destroyed"
  end
end
