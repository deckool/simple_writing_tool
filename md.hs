{-# LANGUAGE OverloadedStrings #-}

import           Prelude hiding (head, div, span, id)
import           Text.Blaze.Html5
import           Text.Blaze.Html5.Attributes hiding (title,style)
import           Text.Blaze.Html.Renderer.Utf8
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.ByteString.Char8 as D
import           Text.Discount
import           System.Directory
import qualified System.FilePath.Posix as FP
import           Control.Monad.IO.Class
import           Control.Monad
import           Data.Time
import           System.Time
import Data.Function (on)
import Data.List (sortBy,zip5)

--sortBy (compare `on` snd) [...]

draw p t = docTypeHtml $ do
    head $ do
        title (toHtml t)
        meta ! httpEquiv "Content-Type" ! content "text/html;charset=UTF-8"
        link ! rel "stylesheet" ! href "http://yui.yahooapis.com/pure/0.4.2/pure-min.css"
        meta ! name "viewport" ! content "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"
        link ! rel "stylesheet" ! href "http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700,300italic,400italic,500italic,700italic" ! type_ "text/css" 
        link ! rel "stylesheet" ! href "load.css"
    body $ do
        a ! href "/blog" $ "<- back"
        a ! href "javascript:window.print()" $ "print it!"
        (toHtml t)
        (preEscapedToHtml p)

main = do
  a <- getCurrentDirectory
  a1 <- liftIO $ getDirectoryContents a
  let a2 = Prelude.map FP.splitExtension a1
  let azz = filter ((`elem` [".md",".markdown",".mdown",".mkdn",".md",".mkd",".mdwn",".mdtxt",".mdtext",".text"]).snd) a2
  let first = Prelude.map fst azz
  let second = Prelude.map snd azz
  let fila = zipWith (++) first second
  dayOfYear <- mapM t fila
  dayOfMonth <- mapM Main.p fila
  month <- mapM Main.c fila
  year <- mapM Main.z fila
--  dataMare <- mapM Main.l fila
--  print first
--  let yearDay = Prelude.map ctYDay $ fmap toUTCTime mdUTC
  let sss = zip5 fila dayOfYear dayOfMonth month year
  print $ Prelude.map get2nd sss
  let sorted = reverse $ sortBy (compare `on` get2nd) sss
  print sorted
  forM_ azz $ \(a,b) -> do
    let file = a ++ b
    let mdUTC = getModificationTime file
    currentTime <- fmap show mdUTC
    md <- readFile file
    let parsed = parseMarkdown compatOptions $ D.pack md
    print parsed
    let output = a ++ ".html"
    C.writeFile output (renderHtml $ draw (D.unpack parsed) currentTime)
  C.writeFile "index.html" (renderHtml $ index sorted)

l x = do
  today <- fmap utctDay $ getModificationTime x
  return today

t x = do 
  today <- fmap utctDay $ getModificationTime x
  let (year, _, _) = toGregorian today
  let days = diffDays today (fromGregorian year 0 0)
  return days

p x = do 
  today <- fmap utctDay $ getModificationTime x
  let (_, _, day) = toGregorian today
  return day

c x = do 
  today <- fmap utctDay $ getModificationTime x
  let (_, month, _) = toGregorian today
  return month

z x = do 
  today <- fmap utctDay $ getModificationTime x
  let (year, _, _) = toGregorian today
  return year

index p = docTypeHtml $ do
    head $ do
        meta ! httpEquiv "Content-Type" ! content "text/html;charset=UTF-8"
        link ! rel "stylesheet" ! href "http://yui.yahooapis.com/pure/0.4.2/pure-min.css"
        meta ! name "viewport" ! content "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"
        link ! rel "stylesheet" ! href "http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700,300italic,400italic,500italic,700italic" ! type_ "text/css" 
        link ! rel "stylesheet" ! href "load.css"
    body ! id "red-noise" $ do
        forM_ p $ \(a,b,c,d,e) -> do
          div ! class_ "post" ! dataAttribute "yearDay" (toValue b) ! dataAttribute "month" (toValue c) ! dataAttribute "year" (toValue d) ! dataAttribute "day" (toValue e) $ do
            let title = fst $ FP.splitExtension a
            let link = title ++ ".html"
            h1 ! class_ (toValue title) $ "" 
            ul ! class_ "timeline" $ do
              li $ (toHtml e)
              li $ (toHtml d)
              li $ (toHtml c)
        script ! type_ "application/javascript" ! src "load.js" $ ""

get2nd (_,a,_,_,_) = a 