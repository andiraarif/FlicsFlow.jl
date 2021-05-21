function getlines(file)
    # Get lines from the file
    f = open(file)
    lines = readlines(f)
    close(f)

    # Clean the elements from whitespaces
    cleanlines = []
    for i in 1:size(lines, 1)
        if lines[i] != " " && lines[i] != ""
            lines[i] = replace(lines[i], "\t" => "")
            lines[i] = strip(lines[i])
            push!(cleanlines, lines[i])
        end
    end
    return cleanlines
end

function getlistnums(lines)
    for i in 1:size(lines, 1)
        if lines[i] == "("
            return parse(Int64, lines[i - 1]), i + 1
        end
    end
end

function getfileitems(file)
    lines = getlines(file)
    listsize, liststart = getlistnums(lines)
    return lines, listsize, liststart
end

function linetolist(line)
    line = replace(line, "(" => "")
    line = replace(line, ")" => "")
    list = split(line, " ")
    return list
end

function linetokeyvalue(line)
    line = replace(line, ";" => "")
    kvlist = split(line, " ")
    return kvlist[1], kvlist[end]
end

function stringtofloatlist(line)
    list = linetolist(line)
    list = parse.(Float64, list)
    return list
end

function stringtointlist(line)
    list = linetolist(line)
    list = parse.(Int64, list)
    return list
end
