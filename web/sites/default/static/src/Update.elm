module Update exposing (update)


import RemoteData

import Models exposing (Model)

import Messages exposing (Msg(..))

import Page.Update as PU
import Page.Messages as PM


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnFetchPage response ->
      { model | page = response }
        |> update ( PageMsg PM.Port ) -- fix at somepoint, this is sideeffect

    PageMsg subMsg ->
      let
        (newPage, cmds) =
          RemoteData.update (PU.update subMsg) model.page
      in
        { model | page = newPage }
          ! [ Cmd.map PageMsg cmds ]
