module Page.Commands exposing (pageDecoder)


import Json.Decode as Decode exposing (Decoder, field)

import Page.Models exposing (Page)


pageDecoder : Decoder Page
pageDecoder =
  Decode.map4 Page
    (field "title" Decode.string)
    (field "body" Decode.string)
    (field "field_image" Decode.string)
    (field "field_meta_tags" Decode.string)
