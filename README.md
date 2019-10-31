# How to build apps in both React and React Native

The example uses `purescript-run` to craft an implementation agnostic components library, and then has interpreters for both React and React Native.

The basic idea is to think at a level up higher than the React `div, a, ul, li` elements and React Native `text, view` elements, and think more at a level akin to the `Box` and `Paper` components from material-ui.com. 

The example app defines a `ComponentDSL` in `src/UI/Component.purs` with two "components": `Box` and `Text`. These are the smallest building blocks of our application. From there it uses them to define a button in `src/UI.purs"

```haskell
button :: UI.Component JSX
button = do
  child    <- UI.text "Click me!"
  let onClick = Console.log "Hello, World!"
  UI.box { onClick, child }
```

The above is essentially how your entire app is built going forward. When it comes time to run the app, an interpreter is used to convert the DSL into either React or React Native.

Looking in `src/Interpreters/React.purs` you can see how `Box` and `Text` are interpreted into `React` components. And similarly for React Native in `src/Interpreters/ReactNative.purs`.

Currently you can run the `React` app with `npm run start`. I'll add all of the crap for React Native later this evening.
