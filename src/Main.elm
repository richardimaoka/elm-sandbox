module Main exposing (main)

import Browser
import Html exposing (Html, article, code, div, h3, li, pre, text, ul)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    Bool


init : flags -> ( Model, Cmd Msg )
init _ =
    ( True, Cmd.none )


type Msg
    = Open
    | Close


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Open ->
            ( True, Cmd.none )

        Close ->
            ( False, Cmd.none )


subView : Html Msg
subView =
    div []
        (taskListView
            [ TaskStepDescription "下記のボタンを押して、Cloud Consoleへ飛びます"
            , TaskStepDescription "下記のスクリーンショットに沿って操作"
            , TaskStepDescription "下記のコマンドを実行して、環境変数を設定します"
            , TaskStepDescription "Python 開発環境の設定の詳細については、Python 開発環境設定ガイドをご覧ください。"
            ]
        )


view : Model -> Html Msg
view model =
    if model then
        div []
            [ h3 [ onClick Close ] [ Debug.log "wwwaaa" (text "title") ]
            , div [ style "overflow" "hidden" ] [ subView ]
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


codeBlock : String -> Html msg
codeBlock codeString =
    pre [ class "bg-gray-800 text-white p-4" ]
        [ code [] [ text codeString ]
        ]


taskListView : List TaskStep -> List (Html Msg)
taskListView taskStepList =
    List.map taskStepView taskStepList


type TaskStep
    = TaskStepDescription String
    | TaskStepButton
        { url : String
        , description : String
        }
    | TaskStepCode String


taskStepView : TaskStep -> Html Msg
taskStepView step =
    case step of
        TaskStepDescription description ->
            li [] [ text description ]

        TaskStepButton { url, description } ->
            li [] [ text description ]

        TaskStepCode codeString ->
            li [] [ text codeString ]


myCode : Html msg
myCode =
    codeBlock """package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
"""
