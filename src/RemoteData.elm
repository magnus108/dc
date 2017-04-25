module RemoteData
  exposing
    ( RemoteData(..)
    , WebData
    , sendRequest
    , update
    )


import Http


type RemoteData e a
  = NotAsked
  | Loading
  | Failure e
  | Success a


type alias WebData a =
  RemoteData Http.Error a


fromResult : Result e a -> RemoteData e a
fromResult result =
  case result of
    Err e ->
      Failure e

    Ok x ->
      Success x


sendRequest : Http.Request a -> Cmd (WebData a)
sendRequest =
  Http.send fromResult


update : (a -> ( b, Cmd c )) -> RemoteData e a -> ( RemoteData e b, Cmd c )
update f remoteData =
  case remoteData of
    Success data ->
      let
        ( first, second ) =
          f data
      in
        ( Success first, second )

    NotAsked ->
      ( NotAsked, Cmd.none )

    Loading ->
      ( Loading, Cmd.none )

    Failure error ->
      ( Failure error, Cmd.none )
