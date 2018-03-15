defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash_input should return Image with hex list with string hash" do
    hash = Identicon.hash_input("banana")
    assert is_list(hash.hex)
    hash2 = Identicon.hash_input("banana")
    assert hash == hash2
  end

  test "pick color should return a Image with hex and color" do
    %Identicon.Image{color: color} =
      "banana"
      |> Identicon.hash_input()
      |> Identicon.pick_color()

    assert is_tuple(color)
    assert tuple_size(color) == 3
  end

  test "build a grid" do
    %Identicon.Image{grid: grid} =
      "banana"
      |> Identicon.hash_input()
      |> Identicon.pick_color()
      |> Identicon.build_grid()

    assert is_list(grid)
    assert length(grid) == 25
  end

  test "filter odd squares" do
    %Identicon.Image{grid: grid} =
      "banana"
      |> Identicon.hash_input()
      |> Identicon.pick_color()
      |> Identicon.build_grid()
      |> Identicon.filter_odd_squares()

    assert is_list(grid)
    assert length(grid) == 9
  end

  test "build a pixel map" do
    %Identicon.Image{pixel_map: pixel_map} =
      "banana"
      |> Identicon.hash_input()
      |> Identicon.pick_color()
      |> Identicon.build_grid()
      |> Identicon.filter_odd_squares()
      |> Identicon.build_pixel_map()

    assert length(pixel_map) == 9
    [first | _rest] = pixel_map
    assert is_tuple(first)
  end
end
