-- Conway's Game of Life simulator
-- Author: Genji Ohara
-- Date: 2024-04-15
-- License: MIT

import System.IO
import System.Random
import Control.Concurrent

main :: IO ()
main = do
    putStrLn "Conway's Game of Life simulator"
    (rows, cols) <- getRowsAndCols
    gen <- getGeneration
    cells <- randomCells $ rows * cols
    hSetBuffering stdout $ BlockBuffering $ Just (rows * 2)
    mapM_ (`printCells` cols) $ simulate cells cols gen

getRowsAndCols :: IO (Int, Int)
getRowsAndCols = do
    putStrLn "Enter the size of the board (e.g., 10 10):"
    [rows, cols] <- map read . words <$> getLine
    return (rows, cols)

getGeneration :: IO Int
getGeneration = putStrLn "Enter the number of generations:" >> read <$> getLine

printCells :: [Bool] -> Int -> IO ()
printCells [] _ = putStrLn "" >> hFlush stdout >> threadDelay 400000
printCells cells cols = do
    let (row, rest) = splitAt cols cells
    putStrLn $ map (\b -> if b then 'O' else '.') row
    printCells rest cols

randomCells :: Int -> IO [Bool]
randomCells len = take len . randoms <$> newStdGen

countNeighbors :: [Bool] -> Int -> Int -> Int
countNeighbors cells cols idx = length $ filter id neighbors
    where
        neighbors = map (cells !!) $ filter valid [idx - cols - 1, idx - cols, idx - cols + 1, idx - 1, idx + 1, idx + cols - 1, idx + cols, idx + cols + 1]
        valid i = i >= 0 && i < length cells

nextGeneration :: [Bool] -> Int -> [Bool]
nextGeneration cells cols = map nextCell [0..length cells - 1]
    where
        nextCell idx
            | neighbors == 3 = True
            | neighbors == 2 = cells !! idx
            | otherwise = False
            where
                neighbors = countNeighbors cells cols idx

simulate :: [Bool] -> Int -> Int -> [[Bool]]
simulate _ _ 0 = []
simulate cells cols gen = cells : simulate (nextGeneration cells cols) cols (gen - 1)
