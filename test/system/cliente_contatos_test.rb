require "application_system_test_case"

class ClienteContatosTest < ApplicationSystemTestCase
  setup do
    @cliente_contato = cliente_contatos(:one)
  end

  test "visiting the index" do
    visit cliente_contatos_url
    assert_selector "h1", text: "Cliente Contatos"
  end

  test "creating a Cliente contato" do
    visit cliente_contatos_url
    click_on "New Cliente Contato"

    fill_in "Cliente", with: @cliente_contato.cliente_id
    fill_in "Email", with: @cliente_contato.email
    fill_in "Nome", with: @cliente_contato.nome
    fill_in "Telefone", with: @cliente_contato.telefone
    click_on "Create Cliente contato"

    assert_text "Cliente contato was successfully created"
    click_on "Back"
  end

  test "updating a Cliente contato" do
    visit cliente_contatos_url
    click_on "Edit", match: :first

    fill_in "Cliente", with: @cliente_contato.cliente_id
    fill_in "Email", with: @cliente_contato.email
    fill_in "Nome", with: @cliente_contato.nome
    fill_in "Telefone", with: @cliente_contato.telefone
    click_on "Update Cliente contato"

    assert_text "Cliente contato was successfully updated"
    click_on "Back"
  end

  test "destroying a Cliente contato" do
    visit cliente_contatos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cliente contato was successfully destroyed"
  end
end
