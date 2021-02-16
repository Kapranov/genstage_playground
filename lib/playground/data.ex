defmodule Playground.Data do
  @moduledoc """
  """

  @alphabet Enum.to_list(?a..?z)
  @container_type ~w(dry reef)
  @container_size ~w(20 40)

  @spec get_stream(integer) :: fun()
  def get_stream(limit) do
    Stream.resource(fn -> 0 end, fn num -> generate_with_stream(num, limit) end, fn(a) -> a end)
  end

  @spec generate_with_flow(integer) :: Flow.t()
  def generate_with_flow(num) do
    1..num
    |> Flow.from_enumerable()
    |> Flow.map(fn _ -> random_booking() end)
  end

  @spec to_file(Flow.t(), String.t()) :: :ok
  def to_file(stream, name \\ "data.data") do
    path = Path.join(:code.priv_dir(:playground), name)
    stream
    |> Stream.map(&(&1 <> "\n"))
    |> Stream.into(File.stream!(path, [:write, :utf8]))
    |> Stream.run()
  end

  @spec generate_with_stream(integer, integer) :: {[String.t()], integer} | {:halt, String.t()}
  defp generate_with_stream(num, limit) do
    case limit do
      -1 -> {[random_booking()], num+1}
      limit when limit > num -> {[random_booking()], num+1}
      _ -> {:halt, random_booking()}
    end
  end

  @spec random_booking :: String.t()
  defp random_booking do
    to = Faker.Address.country()
    from = Faker.Address.country()
    type = Enum.take_random(@container_type, 1)
    size = Enum.take_random(@container_size, 1)
    amount = :rand.uniform(500)
    booking_id = random_string(6)
    ts = DateTime.utc_now() |> DateTime.to_unix()
    "#{from}, #{to}, #{type}, #{size}, #{amount}, #{booking_id}, #{ts}"
  end

  @spec random_string(integer) :: String.t()
  defp random_string(size) do
    Enum.take_random(@alphabet, size) |> to_string()
  end
end
