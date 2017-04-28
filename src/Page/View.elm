module Page.View exposing (page)

import Html exposing (Html, text)

import Bootstrap
  exposing
  ( mdContent
  , mdTitle
  , mdMarkdown
  )


import Page.Models exposing (Page)
import Page.Messages exposing (Msg(..))


page : Page -> Html Msg
page x =
  mdContent
    [ mdTitle x.title
    , mdMarkdown x.body
    ]
