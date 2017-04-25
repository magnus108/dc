module Page.Update exposing (update)


import Page.Models exposing (Page)
import Page.Messages exposing (Msg(..))


update : Msg -> Page -> (Page, Cmd Msg)
update msg page =
  case msg of
    NoOp ->
      ( page, Cmd.none )
