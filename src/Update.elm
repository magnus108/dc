module Update exposing (update)


import RemoteData

import Models exposing (Model)

import Messages exposing (Msg(..))

import User.Update as UU


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnFetchUsers response ->
      ( { model | users = response }, Cmd.none )

    UserMsg subMsg ->
      ( model , Cmd.none )

    SetTableState newState ->
      ( { model | tableState = newState }, Cmd.none )
