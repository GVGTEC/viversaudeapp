require 'application_system_test_case'

class OrcamentoItensTest < ApplicationSystemTestCase
  setup do
    @orcamento_item = orcamento_itens(:one)
  end

  test 'visiting the index' do
    visit orcamento_itens_url
    assert_selector 'h1', text: 'Orcamento Itens'
  end

  test 'creating a Orcamento item' do
    visit orcamento_itens_url
    click_on 'New Orcamento Item'

    fill_in 'Orcamento', with: @orcamento_item.orcamento_id
    fill_in 'Preco total', with: @orcamento_item.preco_total
    fill_in 'Preco unitario', with: @orcamento_item.preco_unitario
    fill_in 'Produto', with: @orcamento_item.produto_id
    fill_in 'Quantidade', with: @orcamento_item.quantidade
    click_on 'Create Orcamento item'

    assert_text 'Orcamento item was successfully created'
    click_on 'Back'
  end

  test 'updating a Orcamento item' do
    visit orcamento_itens_url
    click_on 'Edit', match: :first

    fill_in 'Orcamento', with: @orcamento_item.orcamento_id
    fill_in 'Preco total', with: @orcamento_item.preco_total
    fill_in 'Preco unitario', with: @orcamento_item.preco_unitario
    fill_in 'Produto', with: @orcamento_item.produto_id
    fill_in 'Quantidade', with: @orcamento_item.quantidade
    click_on 'Update Orcamento item'

    assert_text 'Orcamento item was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Orcamento item' do
    visit orcamento_itens_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Orcamento item was successfully destroyed'
  end
end
