module Kmean
    ( distance
    , mean
    ) where

import DataImage
import Data.List

distance :: [Int] -> [Int] -> Float
distance x y = sqrt (x'*x' + y'*y' + z'*z')
    where
        x' = fromIntegral (x !! 0) - fromIntegral (y !! 0)
        y' = fromIntegral (x !! 1) - fromIntegral (y !! 1)
        z' = fromIntegral (x !! 2) - fromIntegral (y !! 2)

mean :: [Pixel] -> [Float]
mean pixel = [ sum r / y',  sum g / y',  sum b / y']
        where
            r = [fromIntegral (color (pixel !! i) !! 0) | i <- [0..y]]
            g = [fromIntegral (color (pixel !! i) !! 1) | i <- [0..y]]
            b = [fromIntegral (color (pixel !! i) !! 2) | i <- [0..y]]
            y = length pixel - 1
            y' = fromIntegral (y + 1)
