module User.Commands exposing (userDecoder)


import Json.Decode as Decode exposing (Decoder, field)

import User.Models exposing (User)


userDecoder : Decoder User
userDecoder =
  Decode.map2 User
    (field "name" Decode.string)
    (field "mail" Decode.string)
