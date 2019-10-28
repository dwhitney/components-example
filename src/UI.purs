module UI where

import Prelude

import Effect.Console as Console
import React.Basic (JSX)
import UI.Component as UI

button :: UI.Component JSX
button = do
  child    <- UI.text "Click me!"
  let onClick = Console.log "Hello, World!"
  UI.box { onClick, child }