module Interpreters.React where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import React.Basic.DOM as R
import React.Basic.Events as Events
import Run (Run)
import Run as Run
import UI as UI
import UI.Component (ComponentDSL(..), _component)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

handler :: ComponentDSL ~> Run()
handler = case _ of
  Box props next -> do
    let onClick = Events.handler_ props.onClick
        children = [ props.child ]
        jsx = R.div { onClick, children }
    pure $ next jsx
  Text str next -> do
    pure $ next $ R.text str

main :: Effect Unit
main = do
  container <- getElementById "container" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Nothing -> throw "Container element not found"
    Just c  -> do
      let run = Run.interpret (Run.on _component handler Run.send) UI.button
      let jsx = Run.extract run
      render jsx c