module View exposing (view)


import Html exposing (Html, div, text)

import RemoteData exposing (RemoteData(..))

import Models exposing (Model)

import Messages exposing (Msg(..))

import User.View


view : Model -> Html Msg
view model =
  div []
    [ users model ]


users : Model -> Html Msg
users model =
  case model.users of
    NotAsked -> text "Starter"

    Loading -> text "Henter"

    Failure err -> text ("Error: " ++ toString err)

    Success x ->
      div [] ( List.map (\y -> User.View.user y |> Html.map UserMsg) x )
