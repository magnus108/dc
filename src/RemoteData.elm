module RemoteData
  exposing
    ( RemoteData(..)
    , WebData
    , sendRequest
    , update
    , Config(..)
    , view
    )

import Http

import Html exposing (Html)


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


type Config msg e a =
  Config
    { success : a -> Html msg
    , notAsked : Html msg
    , loading : Html msg
    , failure : e -> Html msg
    }


view : Config msg e a -> RemoteData e a -> Html msg
view (Config { success, notAsked, loading, failure }) remoteData =
  case remoteData of
    NotAsked ->
      notAsked

    Loading ->
      loading

    Failure err ->
      failure err

    Success x ->
      success x
