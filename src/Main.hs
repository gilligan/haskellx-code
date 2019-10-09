{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty

import Data.Monoid (mconcat)

main = scotty 3000 $
    get "/:name" $ do
        beam <- param "name"
        html $ mconcat ["<h1>Hello ", beam, "! Welcome to haskellX</h1>"]
