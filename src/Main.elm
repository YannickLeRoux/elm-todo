module Main exposing (Model, Msg, init, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List.Extra exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { todos : List String
    , todo : String
    }


init : Model
init =
    { todos = [ "test" ], todo = "" }


type Msg
    = Change String
    | AddTodo
    | DeleteTodo String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change txt ->
            { model | todo = txt }

        AddTodo ->
            if String.length model.todo > 0 then
                { model | todos = model.todo :: model.todos, todo = "" }

            else
                model

        DeleteTodo todo ->
            { model | todos = List.Extra.remove todo model.todos }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Todo List" ]
        , div
            []
            [ input [ placeholder "Add a Todo", onInput Change, value model.todo ] []
            , button [ onClick AddTodo ] [ text "Add" ]
            , div
                []
                [ todosList
                    model.todos
                ]
            ]
        ]


todosList : List String -> Html Msg
todosList lst =
    lst
        |> List.map (\t -> div [] [ li [ style "float" "left", style "marginRight" "10px" ] [ text t ], button [ onClick (DeleteTodo t) ] [ text "-" ] ])
        |> ul []
