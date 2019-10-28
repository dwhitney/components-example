module UI.Component where

import Prelude

import Data.Symbol (SProxy(..))
import Effect (Effect)
import React.Basic (JSX)
import Run (FProxy, Run)
import Run as Run
import Unsafe.Coerce (unsafeCoerce)

type BoxProps =
  { child :: JSX
  , onClick :: Effect Unit
  }

data ComponentDSL a 
  = Box BoxProps (JSX -> a)
  | Text String (JSX -> a)

derive instance functorComponentDSL :: Functor ComponentDSL


_component :: SProxy "component"
_component = SProxy

type COMPONENT = FProxy ComponentDSL

type Component a = Run(component :: COMPONENT) a


box :: BoxProps -> Component JSX 
box props = Run.lift _component (Box props identity)

text :: String -> Component JSX
text str = Run.lift _component (Text str unsafeCoerce)