module Page.View exposing (page)

import Html exposing (Html, div, h1, text)

import Page.Models exposing (Page)
import Page.Messages exposing (Msg(..))


page : Page -> Html Msg
page x =
  div []
    [ h1 [] [ text x.title ]
    , div [] [ text x.body ]
    ]
