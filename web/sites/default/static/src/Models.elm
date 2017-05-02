module Models exposing (Model, init)


import RemoteData exposing (WebData)

import Messages exposing (Msg)

import Commands

import Page.Models exposing (Page)


type alias Model =
  { page : WebData Page }


initialModel : Model
initialModel =
  { page = RemoteData.Loading }


initialCommands : Cmd Msg
initialCommands =
  Commands.fetchPage


init : (Model, Cmd Msg)
init =
  (initialModel, initialCommands)
