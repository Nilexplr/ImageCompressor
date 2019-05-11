module Compressor
    ( imgCompressor        
    ) where

import DataImage
import System.Random
 
data ClusterPixel = ClusterPixel
    { pixel :: Pixel
    , cluster :: Int
    } deriving Show

data Cluster = Cluster 
    { pos :: [Float]
    } deriving (Eq, Show)

imgCompressor :: ([Pixel], Int, Int) -> [Pixel]
imgCompressor (img, n, e) = img

-- applyCmp :: [Pixel] -> [Pixel] -> [Pixel]
-- applyCmp img cluster
--         | eqCluster cluster cluster' = img'
--         | otherwise = applyCmp img' cluster'
--             where
--                 img' = img
--                 cluster' = findNewCluster img' cluster

-- defineCluster :: [Pixel] -> Int -> [Pixel]
-- defineCluster tab n = [x | x <- tab]

-- eqCluster :: Cluster -> Cluster -> Bool
-- eqCluster a b
--         | a' !! 0 == b' !! 0 && a' !! 1 == b' !! 1  = True
--         | otherwise                                 = False
--             where
--                 a' = pos a
--                 b' = pos b

-- findNewCluster :: Cluster
-- findNewCluster = Cluster { pos = [red :: Float, green :: Float, blue :: Float] }
--     where
--         red     = head ( randoms :: [Float] )
--         green   = head ( randoms :: [Float] )
--         blue    = head ( randoms :: [Float] )
    