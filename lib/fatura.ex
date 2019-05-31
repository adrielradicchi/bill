defmodule Fatura do
  @moduledoc """
     Este módulos executamos funções de faturas
  """
  @doc """
    Ao receber `fatura` retorna uma array de faturas
      ## Exemplos
       iex> Fatura.criar_faturas(["Telefone", "Agua", "Luz"], [5,10])
       [
          %Fatura.Conta{fatura: "Telefone", vencimento: 5},
          %Fatura.Conta{fatura: "Agua", vencimento: 5},
          %Fatura.Conta{fatura: "Luz", vencimento: 5},
          %Fatura.Conta{fatura: "Telefone", vencimento: 10},
          %Fatura.Conta{fatura: "Agua", vencimento: 10},
          %Fatura.Conta{fatura: "Luz", vencimento: 10}
       ]
  """

  def criar_faturas(faturas, vencimentos) do
    for vencimento <- vencimentos, fatura <- faturas do
      %Fatura.Conta{vencimento: vencimento, fatura: fatura}
    end
  end

  def faturas_a_pagar(faturas, quantidade) do
    Enum.split(faturas,quantidade)
  end

  @doc """
    Ao receber `fatura` retorna uma array de faturas
      ## Exemplos
       iex> faturas = Fatura.criar_faturas(["Telefone", "Agua", "Luz"], [5,10])
       iex> Fatura.save(faturas, "struct")
       :ok
  """

  def save(faturas, nome_arquivo) do
    binary = :erlang.term_to_binary(faturas)
    File.write(nome_arquivo, binary)
  end

    @doc """
    Ao receber `fatura` retorna uma array de faturas
      ## Exemplos
       iex> Fatura.load("struct")
       [
          %Fatura.Conta{fatura: "Telefone", vencimento: 5},
          %Fatura.Conta{fatura: "Agua", vencimento: 5},
          %Fatura.Conta{fatura: "Luz", vencimento: 5},
          %Fatura.Conta{fatura: "Telefone", vencimento: 10},
          %Fatura.Conta{fatura: "Agua", vencimento: 10},
          %Fatura.Conta{fatura: "Luz", vencimento: 10}
       ]
  """

  def load(nome_arquivo) do
    case File.read(nome_arquivo) do
      {:ok, binario} -> :erlang.binary_to_term(binario)
      {:error, _} -> "Não foi possível carregar o nosso arquivo!!!"
    end
  end

  @doc """
    Ao receber dados para gerar fatura, deve ordenar e salvar em um arquivo
    iex> Fatura.pagar_faturas(["Telefone", "Agua", "Luz"], [5,10], 1, "salvado")
    :ok
  """

  def pagar_faturas(faturas, vencimento, quantidade, nome_arquivo) do
    criar_faturas(faturas, vencimento)
    |> ordena_faturas()
    |> faturas_a_pagar(quantidade)
    |> save(nome_arquivo)
  end

  @doc """
    Ao receber uma `fatura` retorna um array de faturas ordenado
      ## Exemplos
        iex> faturas = Fatura.criar_faturas(["Telefone","Agua","Luz"], [5,10])
        iex> Fatura.ordena_faturas(faturas)
        [
          %Fatura.Conta{fatura: "Agua", vencimento: 5},
          %Fatura.Conta{fatura: "Agua", vencimento: 10},
          %Fatura.Conta{fatura: "Luz", vencimento: 5},
          %Fatura.Conta{fatura: "Luz", vencimento: 10},
          %Fatura.Conta{fatura: "Telefone", vencimento: 5},
          %Fatura.Conta{fatura: "Telefone", vencimento: 10},
        ]
  """

  def ordena_faturas(faturas) do
    Enum.sort(faturas)
  end

  @doc """
    Ao receber `fatura` retorna uma array de faturas
      ## Exemplos
       iex> faturas = Fatura.criar_faturas(["Telefone","Agua","Luz"], [5,10])
       iex(4)> Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: "Telefone", vencimento: 5})
       true
  """
  def fatura_existe?(faturas, fatura) do
    Enum.member?(faturas, fatura)
  end

end
