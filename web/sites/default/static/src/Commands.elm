module Commands exposing (fetchPage)


import Http

import RemoteData

import Messages exposing (Msg(..))

import Page.Commands exposing (pageDecoder)


fetchPage : Cmd Msg
fetchPage =
  Http.get fetchPageUrl pageDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchPage


fetchPageUrl : String
fetchPageUrl =
  "http://localhost:8080/web/api/pages/16"
