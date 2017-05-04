module Models exposing (Model, init)


import RemoteData exposing (WebData)

import Messages exposing (Msg)

import Commands

import User.Models exposing (User)


type alias Model =
  { users : WebData (List User) }


initialModel : Model
initialModel =
  { users = RemoteData.Loading }


initialCommands : Cmd Msg
initialCommands =
  Commands.fetchPage


init : (Model, Cmd Msg)
init =
  (initialModel, initialCommands)
