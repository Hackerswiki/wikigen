module Types where

import Data.Text.Lazy (Text)

import Text.Blaze.Html5 (Html)

-- | Article datatype: name and content
data Article = Article Text Html
