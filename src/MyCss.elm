module MyCss exposing (..)


import Css exposing (..)

import Css.Elements
  exposing
    ( html
    , body
    , img
    )

import Css.Namespace exposing (namespace)

import Colors exposing (..)


type CssClasses
  = MdContent
  | Flex
  | Row
  | Column
  | Title
  | Markdown
  | BackgroundImage


name : String
name = "bootstrap"


css : Stylesheet
css =
  (stylesheet << namespace name)
  [ html
    [ height (pct 100)
    ]
  , body
    [ displayFlex
    , margin zero
    , height (pct 100)
    ]
  , class MdContent
    [ flex (int 8)
    , padding2 zero (px 40)
    ]
  , class Flex
    [ flex (int 1)
    ]
  , class Row
    [ displayFlex
    , flexFlow2 noWrap row
    ]
  , class Column
    [ displayFlex
    , flexFlow2 noWrap column
    ]
  , class Title
    [ color primaryTextColor
    , backgroundColor primaryDarkColor
    ]
  , class Markdown
    [ backgroundColor primaryLightColor
    ]
  , class BackgroundImage
    [ position fixed
    , top (pct -50)
    , left (pct -50)
    , width (pct 200)
    , height (pct 200)
    , zIndex (int -1)
    , children
      [ img
        [  position absolute
        , top zero
        , left zero
        , right zero
        , bottom zero
        , margin auto
        , minWidth (pct 50)
        , minHeight (pct 50)
        ]
      ]
    ]
  ]
