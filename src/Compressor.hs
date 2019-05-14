module Compressor
    ( imgCompressor
    ) where

import DataImage
import System.Random
import Kmean

imgCompressor :: ([Pixel], Int, Float) -> [Clustering] -> [Clustering]
imgCompressor (img, n, e) [] =  imgCompressor (img, n', e) (applyKmean img (newCluster img n'))
            where 
                n' = if n > x then x else n
                x = length img
imgCompressor (img, n, e) clustering
        | getConvergeance clustering newClustering e == False = imgCompressor (img, n, e) newClustering
        | otherwise = newClustering
            where
                newClustering = applyKmean img newCluster
                newCluster = [cluster (clustering !! i) | i <- take n [0,1..]]

getConvergeance :: [Clustering] -> [Clustering] -> Float -> Bool
getConvergeance old new e
        | length x == length old    = True
        | otherwise                 = False
            where
                x = [function i | i <- take (length old) [0,1..] , function i == True]
                function i = eqCluster (cluster (old !! i)) (cluster (new !! i)) e


eqCluster :: Cluster -> Cluster -> Float -> Bool
eqCluster clusterA clusterB e
        | x > e     = False
        | otherwise = True
            where
                a = pos clusterA
                b = pos clusterB
                x = distanceF a b

newCluster :: [Pixel] -> Int -> [Cluster]
newCluster img n = [mean (y !! i) | i <- take n [0,1..]]
    where
        y = chunks (length img `div` n) img
        

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n xs =
    let (ys, zs) = splitAt n xs
    in  ys : chunks n zs