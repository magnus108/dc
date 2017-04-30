module Bootstrap
  exposing
  ( mdColumn
  , mdRow
  , mdContent
  , mdTitle
  , mdMarkdown
  , mdBackgroundImage
  )


import Html
  exposing
    ( Html
    , div
    , h1
    , img
    )

import Html.Attributes
  exposing
    ( src
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


mdBackgroundImage : String -> Html msg
mdBackgroundImage x =
  div [ class [ BackgroundImage ] ] [ mdImage x ]


mdImage : String -> Html msg
mdImage x =
  img [ src x ] []


toText : String -> List (Html msg)
toText =
  List.singleton << Html.text
