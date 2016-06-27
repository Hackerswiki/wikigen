module Wikigen where

import Data.Text.Lazy (Text)
import qualified Data.Text as ST

import Text.Blaze.Html (Html)

import Text.Markdown
import Text.Markdown.Block (Block)
import Text.Markdown.Inline (Inline)

-- | generate the HTML for the markdown of an article
mdToHtml :: Text -> Html
mdToHtml = markdown settings
    where settings = def { msBlockCodeRenderer = renderCode
                         , msBlockFilter = indent
                         , msAddHeadingId = True
                         }

-- | render codeblocks to colorful HTML
renderCode :: Maybe ST.Text -> (ST.Text, Html) -> Html
renderCode (Just lang) (raw, _) = undefined
renderCode _ (_, html) = html

-- | indent all headers by one and treat h6 headers someway or another
indent :: [Block [Inline]] -> [Block [Inline]]
indent = id
