module Main exposing (main)

import Browser
import Html exposing (Html, article, div, h3, li, text, ul)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Markdown


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
            [ text "aaasaadaaa" ]
        , ul []
            [ li [] [ text "afffaa" ], li [] [ text "aaa" ], li [] [ text "aaa" ] ]
        ]


view : Model -> Html Msg
view model =
    if model then
        div []
            [ h3 [ onClick Close ] [ Debug.log "wwwaaa" (text "title") ]
            , div [ style "overflow" "hidden" ] [ subView ]
            , h3 [] [ text "odddddutpttt" ]
            , articleView model
            , div [ class "" ]
                [ myCode
                ]
            ]

    else
        div []
            [ h3 [ onClick Open ] [ Debug.log "wwwaaa" (text "title") ]
            , div [ style "max-height" "0px", style "overflow" "hidden" ] [ subView ]
            , h3 [] [ text "outspssssssttt" ]
            ]


articleView : Model -> Html Msg
articleView _ =
    article [ class "p-4 w-max-full lg:max-w-screen-md" ] [ text "aaaaafsadf sadf sdf sda fsdaf sadfda" ]


myCode : Html msg
myCode =
    Markdown.toHtml []
        """```go
package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
```"""
