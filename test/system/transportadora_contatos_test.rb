require "application_system_test_case"

class TransportadoraContatosTest < ApplicationSystemTestCase
  setup do
    @transportadora_contato = transportadora_contatos(:one)
  end

  test "visiting the index" do
    visit transportadora_contatos_url
    assert_selector "h1", text: "Transportadora Contatos"
  end

  test "creating a Transportadora contato" do
    visit transportadora_contatos_url
    click_on "New Transportadora Contato"

    fill_in "Email", with: @transportadora_contato.email
    fill_in "Nome", with: @transportadora_contato.nome
    fill_in "Telefone", with: @transportadora_contato.telefone
    fill_in "Transportadora", with: @transportadora_contato.transportadora_id
    click_on "Create Transportadora contato"

    assert_text "Transportadora contato was successfully created"
    click_on "Back"
  end

  test "updating a Transportadora contato" do
    visit transportadora_contatos_url
    click_on "Edit", match: :first

    fill_in "Email", with: @transportadora_contato.email
    fill_in "Nome", with: @transportadora_contato.nome
    fill_in "Telefone", with: @transportadora_contato.telefone
    fill_in "Transportadora", with: @transportadora_contato.transportadora_id
    click_on "Update Transportadora contato"

    assert_text "Transportadora contato was successfully updated"
    click_on "Back"
  end

  test "destroying a Transportadora contato" do
    visit transportadora_contatos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transportadora contato was successfully destroyed"
  end
end
