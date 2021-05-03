module Main exposing (main)

import Browser
import Html exposing (Html, div, h3, li, text, ul)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    Bool


init : Model
init =
    True


type Msg
    = Open
    | Close


update : Msg -> Model -> Model
update msg _ =
    case msg of
        Open ->
            True

        Close ->
            False


subView : Html Msg
subView =
    div []
        [ div []
            [ text "aaa" ]
        , ul []
            [ li [] [ text "afffaa" ], li [] [ text "aaa" ], li [] [ text "aaa" ] ]
        ]


view : Model -> Html Msg
view model =
    if model then
        div []
            [ h3 [ onClick Close ] [ Debug.log "wwwaaa" (text "title") ]
            , div [ style "overflow" "hidden" ] [ subView ]
            , h3 [] [ text "outpttt" ]
            ]

    else
        div []
            [ h3 [ onClick Open ] [ Debug.log "wwwaaa" (text "title") ]
            , div [ style "max-height" "0px", style "overflow" "hidden" ] [ subView ]
            , h3 [] [ text "outpttt" ]
            ]
