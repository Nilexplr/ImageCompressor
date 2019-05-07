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
lineToPixel l = Pixel { position = (getPosition (word1Position, word2Position)), color = (getColor (word1Color, word2Color, word3Color)) }
        where   positionOnly    = (((words l) !! 0) \\ "()")
                colorOnly       = (((words l) !! 1) \\ "()")
                word1Position   = (words (map replaceComma positionOnly)) !! 0
                word2Position   = (words (map replaceComma positionOnly)) !! 1
                word1Color      = (words (map replaceComma colorOnly)) !! 0
                word2Color      = (words (map replaceComma colorOnly)) !! 1
                word3Color      = (words (map replaceComma colorOnly)) !! 2

getPosition :: ([Char], [Char]) -> [Int]
getPosition a = [(read (fst a) :: Int), (read (snd a) :: Int)]

getColor :: ([Char], [Char], [Char]) -> [Int]
getColor (a,b,c) = [(read a :: Int), (read b :: Int), (read c :: Int)]

replaceComma :: Char -> Char
replaceComma ','        = ' '
replaceComma c          = c