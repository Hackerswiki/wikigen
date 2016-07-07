{-# LANGUAGE OverloadedStrings #-}
module Template where

import Data.Text.Lazy (Text)

import Text.Blaze.Html (toHtml)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

import Types

-- | take an article's HTML and wrap it in a well-formed page
articlePage :: Article -> Html
articlePage (Article name content) = docTypeHtml $
    H.head $ do
        H.title $ toHtml name
        body $ do
            h1 "Hacker's Wiki"
            H.div ! A.id "article" $ content
