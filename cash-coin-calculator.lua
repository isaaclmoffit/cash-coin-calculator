-- cash & coin calculator --

-- variables --

-- raw variations -- - -- raw data collected from the user. remains unchanged by formatting.
local cash_total = {0, 0} -- cash currencies added up.

local cash = { -- cash currencies.
    [1] = {0, 0,  100, "How many hundreds?        ", "hundreds:"}, -- count, value, worth, prompt, and label.
    [2] = {0, 0,   50, "How many fifties?         ", " fifties:"},
    [3] = {0, 0,   20, "How many twenties?        ", "twenties:"},
    [4] = {0, 0,   10, "How many tens?            ", "    tens:"},
    [5] = {0, 0,    5, "How many fives?           ", "   fives:"},
    [6] = {0, 0,    1, "How many ones?            ", "    ones:"}
}

local coin_total = {0, 0} -- coin currencies added up.

local coin = { -- coin currencies.
    [1] = {0, 0, 0.25, "How many quarters?        ", "quarters:"},
    [2] = {0, 0, 0.10, "How many dimes?           ", "   dimes:"},
    [3] = {0, 0, 0.05, "How many nickels?         ", " nickels:"},
    [4] = {0, 0, 0.01, "How many pennies?         ", " pennies:"}
}

local card = 0 -- bank balance.

local total_total = {0, 0} -- all currencies added up.
-- --- ---------- --

-- formatted variations -- - -- the result of formatting the raw data. this distinction is to allow for consistent comparisons.
local cashTotal = {"0", "0"}

local Cash = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {}
}

local coinTotal = {"0", "0"}

local Coin = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {}
}

local Card = "0"

local totalTotal = {"0", "0"}
-- --------- ---------- --
-- --------- --


-- functions --
function promptUser(prompt, input) -- prompt the user for input, and verify said input.
    repeat
        io.write(prompt) -- prompt the user with the text contained in that unit.
        input = tonumber(io.read()) -- assign whatever the user inputted to input.
        if type(input) ~= "number" then -- if input is NOT a number,
            print("    ERROR: Input isn't a number.") -- throw this error.
        elseif input % 1 ~= 0 then -- if the input is NOT an integer,
            print("    ERROR: Input isn't an integer.") -- throw this error.
        elseif input > 999 then -- if the input exceeds 999,
            print("    ERROR: Input exceeds maximum acceptable range.") -- throw this error.
        end
    until type(input) == "number" and input % 1 == 0 and input <= 999 -- repeat the above until the result meets this criteria.

    return input
end


function formatCount(input) -- format the 'count' value.
    local output = tostring(input) -- output equals input, converted to a string.

    if input >= 1000 then -- if input is greater than or equal to 1,000,
        output = string.sub(output, 1, 1) .. "," .. string.sub(output, 2) -- add a comma to output.
    end

    output = string.rep(" ", 5 - string.len(output)) .. output -- add padding to output.

    return output
end


function formatValue(input) -- format the 'value' value.
    local output = tostring(input) -- output equals input, converted to a string.

    output = string.format("%.2f", input) -- ensure 2 post-decimal digits in output.

    if input >= 100000 then -- if input is at least 100,000,
        output = string.sub(output, 1, 3) .. "," .. string.sub(output, 4) -- add a comma to output.
    elseif input >= 10000 then -- if input is at least 10,000,
        output = string.sub(output, 1, 2) .. "," .. string.sub(output, 3) -- add a comma to output.
    elseif input >= 1000 then -- if input is at least 1,000,
        output = string.sub(output, 1, 1) .. "," .. string.sub(output, 2) -- add a comma to output.
    end

    output = string.rep(" ", 10 - string.len(output)) .. output -- add padding to output.

    return output
end
-- --------- --


-- formatting --

-- cash
for i, v in ipairs(cash) do -- loop through cash currencies.
    local Unit = Cash[i] -- formatted.
    local unit = cash[i] -- raw.

    unit[1] = promptUser(unit[4], unit[1]) -- prompt the user for a count, using the 'prompt' value..
    unit[2] = unit[1] * unit[3] -- get unit value by multiplying unit count by unit worth.

    Unit[1] = formatCount(unit[1]) -- format count.
    Unit[2] = formatValue(unit[2]) -- format value.

    cash_total[1] = cash_total[1] + unit[1] -- add up total count.
    cash_total[2] = cash_total[2] + unit[2] -- add up total value.

    cashTotal[1] = formatCount(cash_total[1]) -- format total count.
    cashTotal[2] = formatValue(cash_total[2]) -- format total value.
end

-- coin
print(" ")

for i, v in ipairs(coin) do -- the same for coin currencies.
    local Unit = Coin[i]
    local unit = coin[i]

    unit[1] = promptUser(unit[4], unit[1])
    unit[2] = unit[1] * unit[3]

    Unit[1] = formatCount(unit[1])
    Unit[2] = formatValue(unit[2])

    coin_total[1] = coin_total[1] + unit[1]
    coin_total[2] = coin_total[2] + unit[2]

    coinTotal[1] = formatCount(coin_total[1])
    coinTotal[2] = formatValue(coin_total[2])
end

-- card
print(" ")

repeat
    io.write("How much on your card?    ") -- prompt the user for bank balance.
    card = tonumber(io.read()) -- assign whatever the user inputted to card.
    if type(card) ~= "number" then -- if input is NOT a number,
        print("    ERROR: Input isn't a number.") -- throw this error.
    end
until type(card) == "number" -- repeat the above until the result is a number.

card = math.floor(card * 100) / 100 -- truncate any excess post-decimal digits.

Card = tostring(card) -- Card equals card, converted to a string.
Card = string.format("%.2f", card) -- ensures two post-decimal digits.

Card = string.rep(" ", 10 - string.len(Card)) .. Card -- add padding to Card.

-- total_total
total_total[1] = coin_total[1] + cash_total[1] -- adding up the total count.
total_total[2] = coin_total[2] + cash_total[2] + card -- adding up the total value.

totalTotal[1] = formatCount(total_total[1]) -- formatting the total count.
totalTotal[2] = formatValue(total_total[2]) -- formatting the total value.
-- ---------- --


-- documenting --
io.write("What would you like to name your file?    ") -- prompt the user for a file name.
local file = io.read()

file = string.lower(file) -- make all characters in file name lowercase..
file = string.gsub(file, " ", "-") -- ..replace any spaces with dashes.

file = file:gsub("-+", "-") -- collapse repeating dashes..
file = file:gsub("^-", "") -- ..if the first character is a dash, remove it..
file = file:gsub("-$", "") -- ..if the last character is a dash, remove it.
file = file .. ".txt"

local File, err = io.open(file, "w") -- create a new text file with the name the user gave.

File:write("cash     ", "        ", cashTotal[1], "    ", cashTotal[2], "\n") -- create the 'cash' header.

for i, v in ipairs(Cash) do -- fill the cash section.
    local Unit = Cash[i]
    local unit = cash[i]

    File:write("    ", unit[5], "    ", Unit[1], "    ", Unit[2], "\n")
end

File:write("\n", "coin     ", "        ", coinTotal[1], "    ", coinTotal[2], "\n") -- create the 'coin' header.

for i, v in ipairs(Coin) do -- fill the coin section.
    local Unit = Coin[i]
    local unit = coin[i]

    File:write("    ", unit[5], "    ", Unit[1], "    ", Unit[2], "\n")
end

File:write("\n", "total    ", "        ", totalTotal[1], "    ", totalTotal[2], "\n") -- create the 'total' header.
File:write("        cash:", "    ", cashTotal[1], "    ", cashTotal[2], "\n") -- cash
File:write("        coin:", "    ", coinTotal[1], "    ", coinTotal[2], "\n") -- coin
File:write("        card:", "    ", "     ", "    ", Card, "\n")              -- card

if not File then -- if attempt to create file failed,
    print("    ERROR: Failed to create file " .. "'" .. file .. "'" .. ".") -- throw this error,
    print("        REASON: " .. err) -- along with this reason.
    return
else -- if attempt to create file was successful,
    local fileSize = File:seek("end")
    print("'" .. file .. "' [" .. fileSize .. " bytes]" .. " successfully created.") -- let the user know.
end

File:close()
-- ----------- --
-- ---- - ---- ---------- --
