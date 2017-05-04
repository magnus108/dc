module Messages exposing (Msg(..))


import RemoteData exposing (WebData)

import User.Messages

import User.Models exposing (User)


type Msg
  = OnFetchUsers (WebData (List User))
  | UserMsg User.Messages.Msg
