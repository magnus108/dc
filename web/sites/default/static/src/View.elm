module View exposing (view)


import Html exposing (Html, div, text)

import RemoteData exposing (RemoteData(..))

import Models exposing (Model)

import Messages exposing (Msg(..))

import Page.View


view : Model -> Html Msg
view model =
  div []
    [ page model ]


page : Model -> Html Msg
page model =
  case model.page of
    NotAsked -> text "Starter"

    Loading -> text "Henter"

    Failure err -> text ("Error: " ++ toString err)

    Success x ->
      Page.View.page x |> Html.map PageMsg
