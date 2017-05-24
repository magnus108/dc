module View exposing (view)


import Html exposing (Html, Attribute, div, text)

import RemoteData exposing (RemoteData(..))

import Table exposing (Status(..), HtmlDetails)

import Models exposing (Model)

import Messages exposing (Msg(..))

import User.View
import User.Models exposing (User)


config : Table.Config User Msg
config =
  Table.customConfig
    { toId = .name
    , toMsg = SetTableState
    , columns =
        [ Table.stringColumn "Name" .name
        , Table.stringColumn "Mail" .mail
        ]
    , customizations = customizations
    }


customizations : Table.Customizations data msg
customizations =
  { tableAttrs = []
  , caption = Nothing
  , thead = simpleThead
  , tfoot = Nothing
  , tbodyAttrs = []
  , rowAttrs = simpleRowAttrs
  }


simpleThead : List (String, Status, Attribute msg) -> HtmlDetails msg
simpleThead headers =
  HtmlDetails [] (List.map simpleTheadHelp headers)


simpleTheadHelp : ( String, Status, Attribute msg ) -> Html msg
simpleTheadHelp (name, status, onClick) =
  let
    content =
      case status of
        Unsortable ->
          [ text name ]

        Sortable selected ->
          [ text name ]

        Reversible Nothing ->
          [ text name ]

        Reversible (Just isReversed) ->
          [ Html.text name ]
  in
    Html.th [ onClick ] content


simpleRowAttrs : data -> List (Attribute msg)
simpleRowAttrs _ =
  []




view : Model -> Html Msg
view model =
  div []
    [ users model ]


users : Model -> Html Msg
users model =
  RemoteData.view ( userConfig model ) model.users



userConfig : Model -> RemoteData.Config Msg e (List User)
userConfig model =
  RemoteData.Config
    { success  = success model
    , notAsked = text "Starter"
    , loading = text "Henter"
    , failure = failure
    }


success : Model -> List User -> Html Msg
success model x =
  Table.view config model.tableState x


failure : e -> Html Msg
failure err =
  text ("Error: " ++ toString err)
