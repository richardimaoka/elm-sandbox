module Main exposing (..)

import Browser
import GraphQLClient exposing (makeGraphQLQuery)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Pokemon.Object
import Pokemon.Object.Pokemon as Pokemon
import Pokemon.Query as Query exposing (PokemonsRequiredArguments)
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


pokemonsRequiredArguments : Int -> PokemonsRequiredArguments
pokemonsRequiredArguments num =
    { first = num }


pokemonListSelection : SelectionSet Pokemon Pokemon.Object.Pokemon
pokemonListSelection =
    SelectionSet.map3 Pokemon
        Pokemon.id
        Pokemon.name
        Pokemon.image


fetchPokemonsQuery : Int -> SelectionSet Pokemons RootQuery
fetchPokemonsQuery num =
    Query.pokemons (pokemonsRequiredArguments num) pokemonListSelection


fetchPokemons : Int -> Cmd Msg
fetchPokemons num =
    makeGraphQLQuery (fetchPokemonsQuery num) (RemoteData.fromResult >> FetchDataSuccess)


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
