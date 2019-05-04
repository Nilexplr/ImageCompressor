module FileParsing
    ( parseFile
    ) where

import Data.String
import Data.List

import DataImage

parseFile :: String -> [Pixel]
parseFile s = map lineToPixel (removeEmptyLine (lines s))

removeEmptyLine :: [String] -> [String]
removeEmptyLine arr
        | containEmptyLine arr  = delete "" arr
        | otherwise             = arr

containEmptyLine :: [String] -> Bool
containEmptyLine []     = False
containEmptyLine (x:xs)
        | null x        = True
        | otherwise     = containEmptyLine xs

lineToPixel :: String -> Pixel
lineToPixel l = Pixel { position = [], color = [] }