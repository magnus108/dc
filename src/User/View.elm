module User.View exposing (user)

import Html exposing (Html, text)

import Bootstrap
  exposing
  ( mdContent
  , mdTitle
  )


import User.Models exposing (User)
import User.Messages exposing (Msg(..))


user : User -> Html Msg
user x =
  mdContent
    [ mdTitle x.name
    , text x.mail
    ]
