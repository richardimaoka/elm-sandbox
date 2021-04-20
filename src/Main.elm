module Main exposing (main)

import Dict
import Html exposing (text)
import Json.Decode exposing (decodeString, dict, int)


main =
    case decodeString (dict int) "{ \"a042\": 42 }" of
        Ok a ->
            case Dict.get "a042" a of
                Just i ->
                    text <| String.fromInt i

                Nothing ->
                    text "wrong key"

        Err _ ->
            text "Err"
