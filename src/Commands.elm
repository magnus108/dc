module Commands exposing (fetchPage)


import Http

import RemoteData

import Json.Decode as Decode exposing (Decoder)

import Messages exposing (Msg(..))

import User.Models exposing (User)
import User.Commands exposing (userDecoder)


fetchPage : Cmd Msg
fetchPage =
  Http.get fetchUsersUrl usersDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchUsers


usersDecoder : Decoder ( List User )
usersDecoder =
  Decode.list userDecoder


fetchUsersUrl : String
fetchUsersUrl =
  -- FIX permissions
  "http://localhost:8080/web/api/users"
