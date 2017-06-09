port module Page.Update exposing (update)


import Page.Models exposing (Page)
import Page.Messages exposing (Msg(..))


port meta : String -> Cmd msg

update : Msg -> Page -> (Page, Cmd Msg)
update msg page =
  case msg of
    NoOp ->
      ( page, Cmd.none )

    Port ->
      ( page, meta page.field_meta_tags )
