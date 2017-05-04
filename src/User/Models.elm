module User.Models exposing (User)


type alias Name = String
type alias Mail = String

type alias User =
  { name : Name
  , mail : Mail
  }
