module Main exposing (main)

import Browser
import Html exposing (Html, a, article, button, code, div, h3, img, li, p, pre, text, ul)
import Html.Attributes exposing (class, href, src, style)
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
        [ taskListView
            [ TaskStepButton
                { url = "https://google.com"
                , buttonText = "プロジェクトの設定"
                , description = "下記のボタンを押して、Cloud Consoleへ飛びます"
                }
            , TaskStepScreenshots
                [ "https://cloud.google.com/docs/images/overview/console.png"
                , "https://cloud.google.com/docs/images/overview/console.png"
                , "https://cloud.google.com/docs/images/overview/console.png"
                ]
            , TaskStepCode """export GOOGLE_APPLICATION_CREDENTIALS=" KEY_PATH"""
            , TaskStepDescription "Python 開発環境の設定の詳細については、Python 開発環境設定ガイドをご覧ください。"
            ]
        ]


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


taskListView : List TaskStep -> Html Msg
taskListView taskStepList =
    ul [ class "mx-4 list-disc" ]
        (List.map
            taskStepView
            taskStepList
        )


type TaskStep
    = TaskStepDescription String
    | TaskStepButton
        { url : String
        , buttonText : String
        , description : String
        }
    | TaskStepCode String
    | TaskStepScreenshots (List String)


taskStepView : TaskStep -> Html Msg
taskStepView step =
    case step of
        TaskStepDescription description ->
            li [] [ text description ]

        TaskStepButton { url, buttonText, description } ->
            li []
                [ p [] [ text description ]
                , button [ class "bg-indigo-400 py-2 px-4 font-bold text-bold text-white" ] [ a [ href url ] [ text buttonText ] ]
                ]

        TaskStepCode codeString ->
            li []
                [ p [] [ text "下記のコードを実行してください" ]
                , codeBlock codeString
                ]

        TaskStepScreenshots imageUrls ->
            let
                screenshotList =
                    List.map (\url -> img [ src url ] []) imageUrls

                combined =
                    p [] [ text "下記のスクリーンショットに沿って操作してください" ] :: screenshotList
            in
            li [] combined


myCode : Html msg
myCode =
    codeBlock """package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
"""
