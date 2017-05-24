module User.Update exposing (update)


import User.Models exposing (User)
import User.Messages exposing (Msg(..))


update : Msg -> User -> (User, Cmd Msg)
update msg user =
  case msg of
    NoOp ->
      ( user, Cmd.none )
