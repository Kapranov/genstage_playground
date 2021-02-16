defmodule Playground do
  @moduledoc """
  Documentation for `Playground`.
  """

  alias Playground.{Booking, Data}

  @doc """
  Make a flow from a data file
  """
  @spec by_flow(String.t(), list) :: Flow.t()
  def by_flow(source \\ "data.data", options \\ []) do
    path = Path.join(:code.priv_dir(:playground), source)
    File.stream!(path, read_ahead: 100_000)
    |> Flow.from_enumerable(options)
    |> Flow.map(&Booking.string_to_booking/1)
  end

  @doc """
  Make a flow from a endless stream of booking data
  The STream hhould preferably be made into a GenStage producer.
  """
  @spec by_stream(list) :: Flow.t()
  def by_stream(options \\ []) do
    Data.get_stream(-1)
    |> Flow.from_enumerable(options)
    |> Flow.map(&Booking.string_to_booking/1)
  end
end
