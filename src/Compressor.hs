module Compressor
    ( imgCompressor        
    ) where

import DataImage
import System.Random
import Kmean

imgCompressor :: ([Pixel], Int, Float) -> [Clustering] -> [Clustering]
imgCompressor (img, n, e) [] =  imgCompressor (img, n, e) (applyKmean img (take n (repeat newCluster)))
imgCompressor (img, n, e) clustering
        | getConvergeance clustering newClustering e = imgCompressor (img, n, e) newClustering
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
        | a' <= e && b' <= e && c' <= e = True
        | otherwise                     = False
            where
                a = pos clusterA
                b = pos clusterB
                a' = abs (a !! 0 - b !! 0)
                b' = abs (a !! 1 - b !! 1)
                c' = abs (a !! 2 - b !! 2)        

newCluster :: Cluster
newCluster = do
    let s1 = mkStdGen 42
    let (f1, s2) = randomR (0, 255 :: Float) s1
    let (f2, s3) = randomR (0, 255 :: Float) s2
    let (f3, _) = randomR (0, 255 :: Float) s3
    Cluster { pos = [f1 :: Float, f2 :: Float, f3 :: Float] }
    