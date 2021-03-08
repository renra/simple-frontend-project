module SimpleFrontendProject exposing(..)

import Browser
import Html exposing(Html, div, text)

type alias Flags =
  { environment : String
  }

type alias Model =
  { environment : String
  }

type Msg = NoOp


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { environment = flags.environment }
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
  div [] [ text ("Simple Frontend Project (running in: " ++ model.environment ++ ")") ]


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
