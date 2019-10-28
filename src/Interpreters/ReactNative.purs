module Interpreters.ReactNative where

import Prelude

import Effect (Effect)
import React.Basic (JSX)
import React.Basic.Native as RN
import React.Basic.Native.Events (capture_)
import Run (Run)
import Run as Run
import UI as UI
import UI.Component (ComponentDSL(..), _component)

handler :: ComponentDSL ~> Run()
handler = case _ of
  Box props next -> do
    let onPress = capture_ props.onClick
        jsx = RN.view { children : [ props.child ] }
        touchable = RN.touchableWithoutFeedback { onPress, children : [ jsx ] }
    pure $ next jsx
  Text str next -> do
    pure $ next $ RN.text { children : [ RN.string str ] }

main :: Effect JSX
main = do
  let run = Run.interpret (Run.on _component handler Run.send) UI.button
  let jsx = Run.extract run
  pure jsx