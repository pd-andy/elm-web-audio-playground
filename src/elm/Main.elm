port module Main exposing (..)

-- Imports ---------------------------------------------------------------------
import Browser
import Html exposing (..)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import WebAudio exposing (..)
import WebAudio.Context as Context exposing (AudioContext)
import WebAudio.Property as Prop

-- Send the JSON encoded audio graph to javascript
port updateAudio : Encode.Value -> Cmd msg

-- MAIN ------------------------------------------------------------------------
main : Program Decode.Value Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- MODEL -----------------------------------------------------------------------
--
type alias Model =
  { context : AudioContext
  }

--
init : Decode.Value -> (Model, Cmd Msg)
init context =
  withCmdNone
    { context = context
    }

-- UPDATE ----------------------------------------------------------------------
--
type Msg
  = NoOp

--
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      withCmdNone model


--
withCmdNone : Model -> (Model, Cmd Msg)
withCmdNone model =
  (model, Cmd.none)

--
withAudio : Model -> (Model, Cmd Msg)
withAudio model =
  (model, audio model)

-- AUDIO -----------------------------------------------------------------------
-- This audio function combines the steps of creating an audio graph, and then
-- encoding it and sending it through a port. You might want to split those
-- two steps up.
audio : Model -> Cmd Msg
audio model =
  if Context.state model.context == Context.Running then
    updateAudio <| encodeGraph
      [
      ]
  else
    Cmd.none

-- VIEW ------------------------------------------------------------------------
--
view : Model -> Html Msg
view model =
  main_ []
    [ text ""
    ]

-- SUBSCRIPTIONS ---------------------------------------------------------------
--
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [
    ]