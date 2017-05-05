module Commands exposing (fetchPage)


import Http

import RemoteData

import Json.Decode as Decode exposing (Decoder)

import Messages exposing (Msg(..))

import User.Models exposing (User)
import User.Commands exposing (userDecoder)


fetchPage : Cmd Msg
fetchPage =
  Http.request
    { method = "GET"
    , headers = []
    , url = fetchUsersUrl
    , body = Http.emptyBody
    , expect = Http.expectJson usersDecoder
    , timeout = Nothing
    , withCredentials = True
    }
  |> RemoteData.sendRequest
  |> Cmd.map OnFetchUsers


usersDecoder : Decoder ( List User )
usersDecoder =
  Decode.list userDecoder


fetchUsersUrl : String
fetchUsersUrl =
  -- FIX permissions
  "http://localhost:8080/web/api/users"
