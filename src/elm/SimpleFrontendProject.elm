module SimpleFrontendProject exposing(..)

import Browser
import Html exposing(Html, div, text)

type alias Flags =
  { environment : String
  }

type alias Model =
  {
  }

type Msg = NoOp


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( {}
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  ( model, Cmd.none )


view : Model -> Html Msg
view model =
  div [] [ text "Simple Frontend Project" ]


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
