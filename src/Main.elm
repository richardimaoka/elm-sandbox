module Main exposing (Model, main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Dict exposing (update)
import Html exposing (Html, a, b, div, li, text, ul)
import Html.Attributes exposing (href)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )


type Msg
    = UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        _ ->
            ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "titleee"
    , body =
        [ text "The current URL is : "
        , b [] [ text (Url.toString model.url) ]
        , ul []
            [ viewLink "/home" ]
        ]
    }


viewLink : String -> Html Msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
