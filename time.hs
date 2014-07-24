{-# LANGUAGE OverloadedStrings #-}

import Data.Time
import System.Directory

date = getCurrentTime
-- "2008-04-18 14:11:22.476894 UTC"
a = getModificationTime "load.css"
today = fmap utctDay a 

t = do today <- fmap utctDay $ getModificationTime "load.css"
       let (year, _, _) = toGregorian today
       let days = diffDays today (fromGregorian year 0 0)
       return days