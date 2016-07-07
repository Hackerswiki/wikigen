{-# LANGUAGE OverloadedStrings #-}
module Text.Wikigen.Template where

import Data.Text.Lazy (Text)

import Text.Blaze.Html (toHtml, Html)
import Text.Blaze.Html5 ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Text.Wikigen.Types

-- | take an article's HTML and wrap it in a well-formed page
articlePage :: Article -> Html
articlePage (Article name content) = H.docTypeHtml $
    H.head $ do
        H.title $ toHtml name
        H.body $ do
            H.h1 "Hacker's Wiki"
            H.div ! A.id "article" $ content
