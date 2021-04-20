module Main exposing (main)

import Dict
import Html exposing (a, text)
import Json.Decode exposing (bool, decodeString, dict, int)


main =
    case decodeString bool "false" of
        Ok a ->
            if a then
                text "true"

            else
                text "false"

        Err _ ->
            text "Err"
