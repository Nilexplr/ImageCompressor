module Kmean
    ( applyKmean
    , Cluster(..)
    , Clustering(..)
    ) where

import DataImage
import Data.List

data Cluster = Cluster 
    { pos :: [Float]
    } deriving (Eq, Show)

data Clustering = Clustering
    { cluster :: Cluster
    , pixels :: [Pixel]
    } deriving (Eq, Show)


distance :: [Int] -> [Int] -> Float
distance x y = sqrt (x'*x' + y'*y' + z'*z')
    where
        x' = fromIntegral (x !! 0) - fromIntegral (y !! 0)
        y' = fromIntegral (x !! 1) - fromIntegral (y !! 1)
        z' = fromIntegral (x !! 2) - fromIntegral (y !! 2)

mean :: [Pixel] -> Cluster
mean pixel = Cluster { pos = [ sum r / y',  sum g / y',  sum b / y'] }
        where
            r = [fromIntegral (color (pixel !! i) !! 0) | i <- take y [0,1..]]
            g = [fromIntegral (color (pixel !! i) !! 1) | i <- take y [0,1..]]
            b = [fromIntegral (color (pixel !! i) !! 2) | i <- take y [0,1..]]
            y = length pixel - 1
            y' = fromIntegral (y + 1)

applyKmean :: [Pixel] -> [Cluster] -> [Clustering]
applyKmean a b =  take 1 (repeat Clustering { cluster = b !! 0, pixels = a})

linkKneighbor :: [Pixel] -> [Cluster] -> [Clustering]
linkKneighbor img clusterList = [createClustering img clusterList (clusterList !! i) | i <- take (length clusterList) [0,1..]]

createClustering :: [Pixel] -> [Cluster] -> Cluster -> [Clustering]
