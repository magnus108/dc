module Page.Models exposing (Page)


type alias Title = String
type alias Body = String
type alias Image = String

type alias Page =
  { title : Title
  , body : Body
  , field_image : Image
  }