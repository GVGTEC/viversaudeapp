module ApplicationHelper
  def formatar_qtd(number)
    return number.to_i if number == number.to_i

    number
  end

  def formatar_valor(valor)
    format('%.2f', valor).tr('.', ',')
  end
end
