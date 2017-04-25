module Page.Commands exposing (pageDecoder)


import Json.Decode as Decode exposing (Decoder, field)

import Page.Models exposing (Page)


pageDecoder : Decoder Page
pageDecoder =
  Decode.map2 Page
    (field "title" Decode.string)
    (field "body" Decode.string)
