module Models exposing (Model, init)


import RemoteData exposing (WebData)

import Table

import Messages exposing (Msg)

import Commands

import User.Models exposing (User)


type alias Model =
  { users : WebData (List User)
  , tableState : Table.State
  }


initialModel : Model
initialModel =
  { users = RemoteData.Loading
  , tableState = Table.initialSort "name" --"should be some field to string"
  }


initialCommands : Cmd Msg
initialCommands =
  Commands.fetchPage


init : (Model, Cmd Msg)
init =
  (initialModel, initialCommands)
