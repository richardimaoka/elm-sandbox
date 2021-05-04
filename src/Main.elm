module Main exposing (main)

import Array exposing (Array)
import Array.Extra
import Browser
import Html exposing (Html, a, article, button, code, div, h3, img, li, p, pre, section, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { title = "my first task page"
      , tasks = initTasks
      }
    , Cmd.none
    )


initTasks : Tasks
initTasks =
    tasksFromList
        [ { id = "prerequisites"
          , title = "Prerequisites"
          , isOpen = False
          , taskSteps = prerequisiteSteps
          }
        , { id = "aaaa"
          , title = "始める前に"
          , isOpen = True
          , taskSteps = taskSteps1
          }
        ]


type alias Prerequisite =
    {}


type alias PrerequisiteStep =
    { command : String
    , expected : String
    }


prerequisiteSteps : TaskSteps
prerequisiteSteps =
    taskStepsFromList
        [ TaskStepCode "elm --version"
        ]


taskSteps1 : TaskSteps
taskSteps1 =
    taskStepsFromList
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


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { title : String
    , tasks : Tasks
    }


type alias Task =
    { id : String
    , title : String
    , taskSteps : TaskSteps
    , isOpen : Bool
    }


type alias Tasks =
    Array Task


tasksFromList : List Task -> Tasks
tasksFromList list =
    Array.fromList list


tasksToList : Tasks -> List Task
tasksToList tasks =
    Array.toList tasks


tasksOpen : String -> Tasks -> Tasks
tasksOpen id tasks =
    findUpdate (\task -> task.id == id) (\task -> { task | isOpen = True }) tasks


tasksClose : String -> Tasks -> Tasks
tasksClose id tasks =
    findUpdate (\task -> task.id == id) (\task -> { task | isOpen = False }) tasks


findUpdate : (a -> Bool) -> (a -> a) -> Array a -> Array a
findUpdate predicate updateFunc array =
    case findRecursive predicate 0 array of
        Just index ->
            Array.Extra.update index updateFunc array

        Nothing ->
            array


findRecursive : (a -> Bool) -> Int -> Array a -> Maybe Int
findRecursive predicate currentIndex array =
    let
        maybeIndex =
            \currentValue ->
                if predicate currentValue then
                    Just currentIndex

                else
                    findRecursive predicate (currentIndex + 1) array
    in
    Array.get currentIndex array |> Maybe.andThen maybeIndex


type TaskStep
    = TaskStepDescription String
    | TaskStepButton
        { url : String
        , buttonText : String
        , description : String
        }
    | TaskStepCode String
    | TaskStepScreenshots (List String)


type alias TaskSteps =
    Array TaskStep


taskStepsFromList : List TaskStep -> TaskSteps
taskStepsFromList list =
    Array.fromList list


taskStepsToList : TaskSteps -> List TaskStep
taskStepsToList taskSteps =
    Array.toList taskSteps


type Msg
    = Open String
    | Close String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Open id ->
            ( { model | tasks = tasksOpen id model.tasks }, Cmd.none )

        Close id ->
            ( { model | tasks = tasksClose id model.tasks }, Cmd.none )


view : Model -> Html Msg
view model =
    article [ class "p-4 w-max-full lg:max-w-screen-md" ]
        (List.map
            taskView
            (tasksToList model.tasks)
        )


taskView : Task -> Html Msg
taskView task =
    let
        styles =
            if task.isOpen then
                [ style "overflow" "hidden" ]

            else
                [ style "max-height" "0px", style "overflow" "hidden" ]
    in
    section [ class "border-2 mb-2 shadow-md" ]
        [ sectionTitle task.id task.isOpen task.title
        , div styles [ taskListView task.taskSteps ]
        ]


sectionTitle : String -> Bool -> String -> Html Msg
sectionTitle id isOpen title =
    div [ class "flex flex-row justify-between mx-4 mb-2" ]
        [ h3 [ class "text-2xl mb-2" ] [ text title ]
        , button
            [ onClick
                (if isOpen then
                    Close id

                 else
                    Open id
                )
            ]
            [ text "expand" ]
        ]


codeBlock : String -> Html msg
codeBlock codeString =
    pre [ class "bg-gray-800 text-white p-4" ]
        [ code [] [ text codeString ]
        ]


taskListView : TaskSteps -> Html Msg
taskListView taskSteps =
    ul [ class "mx-8 list-disc" ]
        (List.map
            taskStepView
            (taskStepsToList taskSteps)
        )


taskStepView : TaskStep -> Html Msg
taskStepView step =
    case step of
        TaskStepDescription description ->
            li [] [ p [] [ text description ] ]

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
