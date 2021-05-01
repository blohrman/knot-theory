dtToGauss :: String -> String
dtToGauss code = codeToString $ createGaussCode $ pairElemsWithOddNum code

createGaussCode :: [[Int]] -> [Int]
createGaussCode pairs = zipAll $ gaussHelper pairs code 1
  where code = replicate (length pairs * 2) 0

codeToString :: [Int] -> String
codeToString code = unwords [show val | val <- code]

zipAll :: [[Int]] -> [Int]
zipAll [arr] = arr
zipAll (arr:arrs) = zipWith (+) arr (zipAll arrs)

gaussHelper :: [[Int]] -> [Int] -> Int -> [[Int]]
gaussHelper [pair] code crossing = map (\x -> replaceAtIndex x crossing code) pair
gaussHelper (pair:pairs) code crossing = gaussHelper [pair] code crossing ++ gaussHelper pairs code (crossing + 1)

replaceAtIndex :: Int -> Int -> [Int] -> [Int]
replaceAtIndex index item arr = let (one, two) = splitAt index arr in init one ++ [item] ++ two

parseStringToIntArr :: String -> [Int]
parseStringToIntArr str = [read val :: Int | val <- words str]

pairElemsWithOddNum :: String -> [[Int]]
pairElemsWithOddNum code = pairHelper parsed 1
  where parsed = parseStringToIntArr code

pairHelper :: [Int] -> Int -> [[Int]]
pairHelper [val] oddNum = [[oddNum, val]]
pairHelper (val:code) oddNum = pairHelper [val] oddNum ++ pairHelper code (oddNum + 2)

main :: IO()
main = 
  print $ dtToGauss "4 6 2"