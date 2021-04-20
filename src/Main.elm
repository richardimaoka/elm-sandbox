module Main exposing (main)

import Html exposing (text)
import Json.Decode exposing (decodeString, int)


main =
    case decodeString int "042" of
        Ok a ->
            text <| String.fromInt a

        Err _ ->
            text "Err"
