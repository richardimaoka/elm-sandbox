module Main exposing (..)

import Browser
import Graphql.Http
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Pokemon.ScalarCodecs
import RemoteData exposing (RemoteData)



---- MODEL ----


type alias Pokemon =
    { id : Pokemon.ScalarCodecs.Id
    , name : Maybe String
    , image : Maybe String
    }


type alias Pokemons =
    Maybe (List (Maybe Pokemon))


type alias PokemonData =
    RemoteData (Graphql.Http.Error Pokemons) Pokemons


type alias Model =
    { pokemons : PokemonData }


init : ( Model, Cmd Msg )
init =
    ( { pokemons = RemoteData.Loading
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "https://i.gyazo.com/480551bded5134ddacf08616b2595717.png" ] []
        , h1 [] [ text "Pokemons with elm-graphql" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
