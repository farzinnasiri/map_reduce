defmodule SampleDomains do
  require Randomizer
  use GenServer

  def dict_reducer(x, y) do
    %{
      get_key(x) => get_value(y) + get_value(x)
    }
  end

  defp get_key(x) do
    Map.keys(x)
    |> List.first()
  end

  defp get_value(x) do
    Map.values(x)
    |> List.first()
  end

  def dict_mapper(x) do
    %{x => 1}
  end

  def init(_args) do
    {:ok, %{}}
  end

  def handle_call({:word_count, _pid}, _from, _state) do
    {:reply, {&dict_mapper/1, &dict_reducer/2}, %{}}
  end

  def handle_call({:get_sample_list, :word_count}, _from, _state) do
    {:reply, Randomizer.randomizer(3, 1_000), %{}}
  end

  def handle_call({:page_rank}, _from, _state) do
    {:reply, {&link_mapper/1, &link_reducer/2}, %{}}
  end

  def link_mapper({source, target}) do
    %{target => [source]}
  end

  def link_reducer(a, b) do
    %{get_key(a) => Enum.concat(get_value(a), get_value(b))}
  end
end
