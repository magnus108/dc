module Messages exposing (Msg(..))


import RemoteData exposing (WebData)

import Page.Messages

import Page.Models exposing (Page)


type Msg
  = OnFetchPage (WebData Page)
  | PageMsg Page.Messages.Msg
