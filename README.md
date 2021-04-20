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

```
