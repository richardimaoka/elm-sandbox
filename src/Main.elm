module Main exposing (main)

import Browser
import Dict exposing (update)
import Html exposing (Html, div, text)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg ->
            model


view : Model -> Html Msg
view _ =
    div [] [ text "hello" ]
