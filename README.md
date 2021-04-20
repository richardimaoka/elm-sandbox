```
➜  elm-sandbox git:(main) elm repl
---- Elm 0.19.1 ----------------------------------------------------------------
Say :help for help and :exit to exit! More at <https://elm-lang.org/0.19.1/repl>
--------------------------------------------------------------------------------
> import Json.Decode exposing (..)
> int
<internals> : Decoder Int
> decodeString
<function> : Decoder a -> String -> Result Error a
> decodeString (list int)
<function> : String -> Result Error (List Int)
> decodeString (list int) "[1,2,3]"
Ok [1,2,3] : Result Error (List Int)
> decodeString (list int) "[1,2,]"
Err (Failure ("This is not valid JSON! Unexpected token ] in JSON at position 5") <internals>)
```

```
 decodeString (nullable int) "13"
Ok (Just 13) : Result Error (Maybe Int)
> decodeString (nullable int) "013"
Err (Failure ("This is not valid JSON! Unexpected number in JSON at position 1") <internals>)
    : Result Error (Maybe Int)
> decodeString (nullable int) ""
Err (Failure ("This is not valid JSON! Unexpected end of JSON input") <internals>)
    : Result Error (Maybe Int)
> decodeString (nullable int) "a"
Err (Failure ("This is not valid JSON! Unexpected token a in JSON at position 0") <internals>)
    : Result Error (Maybe Int)
> decodeString ( int) "a"
Err (Failure ("This is not valid JSON! Unexpected token a in JSON at position 0") <internals>)
    : Result Error Int
> decodeString ( int) "null"
Err (Failure ("Expecting an INT") <internals>)
    : Result Error Int
> decodeString (nullable int) "null"
Ok Nothing : Result Error (Maybe Int)
> decodeString (nullable int) "undefined"
Err (Failure ("This is not valid JSON! Unexpected token u in JSON at position 0") <internals>)
    : Result Error (Maybe Int)
> decodeString (nullable int) ""null""
-- TOO MANY ARGS ---------------------------------------------------------- REPL

The `decodeString` function expects 2 arguments, but it got 4 instead.

4|   decodeString (nullable int) ""null""
     ^^^^^^^^^^^^
Are there any missing commas? Or missing parentheses?

> decodeString (nullable int) "\"null\""
Err (OneOf [Failure ("Expecting null") <internals>,Failure ("Expecting an INT") <internals>])
    : Result Error (Maybe Int)
> decodeString (nullable int) "a"
Err (Failure ("This is not valid JSON! Unexpected token a in JSON at position 0") <internals>)
    : Result Error (Maybe Int)
> decodeString (nullable int) "\"a\""
Err (OneOf [Failure ("Expecting null") <internals>,Failure ("Expecting an INT") <internals>])
    : Result Error (Maybe Int)

➜  elm-sandbox git:(main) elm repl
---- Elm 0.19.1 ----------------------------------------------------------------
Say :help for help and :exit to exit! More at <https://elm-lang.org/0.19.1/repl>
--------------------------------------------------------------------------------
> import Json.Decode exposing (..)
> field "x" int
<internals> : Decoder Int
> field "x"
<function> : Decoder a -> Decoder a
> decodeString (field "x" int) "{ \"x\": 3}"
Ok 3 : Result Error Int
> decodeString (field "x" int) "{ \"x\": 3, \"y\": false}"
Ok 3 : Result Error Int
> decodeString (field "y" int) "{ \"x\": 3, \"y\": false}"
Err (Field "y" (Failure ("Expecting an INT") <internals>))
    : Result Error Int
> decodeString (field "y" bool) "{ \"x\": 3, \"y\": false}"
Ok False : Result Error Bool
> decodeString (field "y" bool) "{ \"x\": 3, \"y\": faslse}"
Err (Failure ("This is not valid JSON! Unexpected token s in JSON at position 17") <internals>)
    : Result Error Bool
```
