defmodule FFMPEG_PROCTest do
  use ExUnit.Case
  doctest FFMPEG_PROC

  test "greets the world" do
    assert FFMPEG_PROC.hello() == :world
  end
end
