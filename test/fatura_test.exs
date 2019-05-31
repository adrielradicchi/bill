defmodule FaturaTest do
  use ExUnit.Case
  doctest Fatura

  test "deve criar uma lista de faturas" do
    faturas = Fatura.criar_faturas(["Telefone"], [5,10])
    assert faturas == [
        %Fatura.Conta{fatura: "Telefone", vencimento: 5},
        %Fatura.Conta{fatura: "Telefone", vencimento: 10}
    ]
  end

  test "deve ordenar uma lista de faturas" do
    faturas = Fatura.criar_faturas(["Agua","Telefone","Luz"], [5,10])
    assert Fatura.ordena_faturas(faturas) == [
      %Fatura.Conta{fatura: "Agua", vencimento: 5},
      %Fatura.Conta{fatura: "Agua", vencimento: 10},
      %Fatura.Conta{fatura: "Luz", vencimento: 5},
      %Fatura.Conta{fatura: "Luz", vencimento: 10},
      %Fatura.Conta{fatura: "Telefone", vencimento: 5},
      %Fatura.Conta{fatura: "Telefone", vencimento: 10}
    ]
  end

  test "deve verificar se existe uma fatura dentro de uma lista de faturas" do
    faturas = Fatura.criar_faturas(["Agua","Telefone","Luz"], [5,10])
    assert true == Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: "Telefone", vencimento: 5})
  end
  
end
