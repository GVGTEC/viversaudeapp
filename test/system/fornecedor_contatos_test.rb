require "application_system_test_case"

class FornecedorContatosTest < ApplicationSystemTestCase
  setup do
    @fornecedor_contato = fornecedor_contatos(:one)
  end

  test "visiting the index" do
    visit fornecedor_contatos_url
    assert_selector "h1", text: "Fornecedor Contatos"
  end

  test "creating a Fornecedor contato" do
    visit fornecedor_contatos_url
    click_on "New Fornecedor Contato"

    fill_in "Email", with: @fornecedor_contato.email
    fill_in "Fornecedor", with: @fornecedor_contato.fornecedor_id
    fill_in "Nome", with: @fornecedor_contato.nome
    fill_in "Telefone", with: @fornecedor_contato.telefone
    click_on "Create Fornecedor contato"

    assert_text "Fornecedor contato was successfully created"
    click_on "Back"
  end

  test "updating a Fornecedor contato" do
    visit fornecedor_contatos_url
    click_on "Edit", match: :first

    fill_in "Email", with: @fornecedor_contato.email
    fill_in "Fornecedor", with: @fornecedor_contato.fornecedor_id
    fill_in "Nome", with: @fornecedor_contato.nome
    fill_in "Telefone", with: @fornecedor_contato.telefone
    click_on "Update Fornecedor contato"

    assert_text "Fornecedor contato was successfully updated"
    click_on "Back"
  end

  test "destroying a Fornecedor contato" do
    visit fornecedor_contatos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fornecedor contato was successfully destroyed"
  end
end
