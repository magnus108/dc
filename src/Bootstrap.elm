module Bootstrap
  exposing
  ( mdColumn
  , mdRow
  , mdContent
  , mdTitle
  , mdMarkdown
  )


import Html
  exposing
    ( Html
    , div
    , h1
    )

import Markdown

import Html.CssHelpers

import MyCss exposing (CssClasses(..))


{id, class, classList} =
  Html.CssHelpers.withNamespace MyCss.name


mdColumn : List (Html msg) -> Html msg
mdColumn =
  div [ class [ Column, Flex ] ]


mdContent : List (Html msg) -> Html msg
mdContent =
  div [ class [ MdContent ] ]


mdRow : List (Html msg) -> Html msg
mdRow =
  div [ class [ Row, Flex ] ]


mdTitle : String -> Html msg
mdTitle =
  h1 [ class [ Title ] ] << toText


mdMarkdown : String -> Html msg
mdMarkdown =
  Markdown.toHtml [ class [ Markdown ] ]


toText : String -> List (Html msg)
toText =
  List.singleton << Html.text
