module Update exposing (update)


import RemoteData

import Models exposing (Model)

import Messages exposing (Msg(..))

import Page.Update as PU


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnFetchPage response ->
      ( { model | page = response }, Cmd.none )

    PageMsg subMsg ->
      let
        (newPage, cmds) =
          RemoteData.update (PU.update subMsg) model.page
      in
        { model | page = newPage }
          ! [ Cmd.map PageMsg cmds ]
