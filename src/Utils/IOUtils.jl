function printdict(dict, sequence=false)
    # Find longest key
    longestkey = " "
    maxchar = length(longestkey)
    for (key, value) in dict
        char = length(key)
        if char > maxchar
            maxchar = char
            longestkey = key
        end
    end
    # Print dict in a nice format
    println("\n")
    if sequence
        for i in 1:length(dict)
            key = string(i)
            value = dict[key]
            if key != longestkey
                spacediff = maxchar - length(key)
                space = " "^spacediff
                key = "    "*space*key
            else
                key = "    "*key
            end
            println(key, ": ", value)
        end
    else
        for (key, value) in dict
            if key != longestkey
                spacediff = maxchar - length(key)
                space = " "^spacediff
                key = "    "*space*key
            else
                key = "    "*key
            end
            println(key, ": ", value)
        end
    end
end
