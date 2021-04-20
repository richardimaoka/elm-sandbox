module Main exposing (main)

import Html exposing (text)
import Json.Decode exposing (decodeString, string)


main =
    case decodeString string "{ \"a042\": 42 }" of
        Ok a ->
            text a

        Err _ ->
            text "Err"
