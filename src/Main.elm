module Main exposing (main)

import Html exposing (Html, a, code, details, div, li, pre, text, ul)
import Html.Attributes exposing (href)


codeBlock : String -> Html msg
codeBlock codeString =
    pre []
        [ code [] [ text codeString ] ]


specificCodeBlock : Html msg
specificCodeBlock =
    let
        sdkManShellScript =
            """
    sdk () {
    COMMAND="$1" 
    QUALIFIER="$2" 
    case "$COMMAND" in
            (l) COMMAND="list"  ;;
            (ls) COMMAND="list"  ;;
            (v) COMMAND="version"  ;;
            (u) COMMAND="use"  ;;
            (i) COMMAND="install"  ;;
            (rm) COMMAND="uninstall"  ;;
            (c) COMMAND="current"  ;;
            (ug) COMMAND="upgrade"  ;;
            (d) COMMAND="default"  ;;
            (b) COMMAND="broadcast"  ;;
            (h) COMMAND="home"  ;;
            (e) COMMAND="env"  ;;
    esac
    if [[ "$COMMAND" == "home" ]]
    then
            __sdk_home "$QUALIFIER" "$3"
            return $?
    fi
    if [[ "$COMMAND" != "update" ]]
    then
            ___sdkman_check_candidates_cache "$SDKMAN_CANDIDATES_CACHE" || return 1
            ___sdkman_check_version_cache
    fi
    SDKMAN_AVAILABLE="true" 
    if [ -z "$SDKMAN_OFFLINE_MODE" ]
    then
            SDKMAN_OFFLINE_MODE="false" 
    fi
    __sdkman_update_broadcast_and_service_availability
    if [ -f "${SDKMAN_DIR}/etc/config" ]
    then
            source "${SDKMAN_DIR}/etc/config"
    fi
    if [[ -z "$COMMAND" ]]
    then
            __sdk_help
            return 1
    fi
    CMD_FOUND="" 
    CMD_TARGET="${SDKMAN_DIR}/src/sdkman-${COMMAND}.sh" 
    if [[ -f "$CMD_TARGET" ]]
    then
            CMD_FOUND="$CMD_TARGET" 
    fi
    CMD_TARGET="${SDKMAN_DIR}/ext/sdkman-${COMMAND}.sh" 
    if [[ -f "$CMD_TARGET" ]]
    then
            CMD_FOUND="$CMD_TARGET" 
    fi
    if [[ -z "$CMD_FOUND" ]]
    then
            echo ""
            __sdkman_echo_red "Invalid command: $COMMAND"
            echo ""
            __sdk_help
    fi
    local sdkman_valid_candidate=$(echo ${SDKMAN_CANDIDATES[@]} | grep -w "$QUALIFIER") 
    if [[ -n "$QUALIFIER" && "$COMMAND" != "offline" && "$COMMAND" != "flush" && "$COMMAND" != "selfupdate" && "$COMMAND" != "env" && "$COMMAND" != "completion" && -z "$sdkman_valid_candidate" ]]
    then
            echo ""
            __sdkman_echo_red "Stop! $QUALIFIER is not a valid candidate."
            return 1
    fi
    if [[ "$COMMAND" == "offline" && -n "$QUALIFIER" && -z $(echo "enable disable" | grep -w "$QUALIFIER") ]]
    then
            echo ""
            __sdkman_echo_red "Stop! $QUALIFIER is not a valid offline mode."
    fi
    CONVERTED_CMD_NAME=$(echo "$COMMAND" | tr '-' '_') 
    local final_rc=0 
    if [ -n "$CMD_FOUND" ]
    then
            __sdk_"$CONVERTED_CMD_NAME" "$QUALIFIER" "$3" "$4"
            final_rc=$? 
    fi
    if [[ "$COMMAND" != "selfupdate" ]]
    then
            __sdkman_auto_update "$SDKMAN_REMOTE_VERSION" "$SDKMAN_VERSION"
    fi
    return $final_rc
"""
    in
    codeBlock sdkManShellScript


main : Html msg
main =
    div []
        [ ul []
            [ li [] [ text """which sdk""" ]
            ]
        , ul []
            [ li [] [ text """curl -s "https://get.sdkman.io" | bash""" ]
            , li [] [ text """curl -s "https://get.sdkman.io" | bash""" ]
            , details []
                [ -- summary [] [ text "click to expand" ] ,
                  div []
                    [ specificCodeBlock ]
                ]
            ]
        ]
