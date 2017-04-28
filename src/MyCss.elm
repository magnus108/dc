module MyCss exposing (..)


import Css exposing (..)

import Css.Elements
  exposing
    ( html
    , body
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
    ]
  , class Markdown
    [ backgroundColor primaryLightColor
    ]
  ]
