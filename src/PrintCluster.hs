module PrintCluster
    ( printCluster
    ) where

import Text.Printf

import DataImage
import Kmean

printCluster :: [Clustering] -> IO ()
printCluster []     = return ()
printCluster (c:cs) = do printOneCluster c ; printCluster cs

printOneCluster :: Clustering -> IO ()
printOneCluster c = do
            printf "--\n(%.2f,%.2f,%.2f)\n-\n" (((pos (cluster c)) !! 0) :: Float) (((pos (cluster c)) !! 1) :: Float) (((pos (cluster c)) !! 2) :: Float)
            printClusterPixel (pixels c)

printClusterPixel :: [Pixel] -> IO ()
printClusterPixel []        = return ()
printClusterPixel (p:ps)    = do
            printf "(%d,%d) (%d,%d,%d)\n" ((position p) !! 0 :: Int) ((position p) !! 1 :: Int) ((color p) !! 0 :: Int) ((color p) !! 1 :: Int) ((color p) !! 2 :: Int)
            printClusterPixel ps
