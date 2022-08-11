BEGIN {
    OPENING_BRACKETS = "{{";
    CLOSING_BRACKETS = "}}";
}

# Given a [text], this function returns the value of the
# parameter key given in [param_name].
# If [text] does not contain [param_name], the empty string
# is returned.
function get_parameter(text, param_name,  param, next_param_pos, template_end_pos, pos) {
    if (!match(text, param_name))
        return "";
    param_name = "|" param_name;
    param = substr(text, index(text, param_name) + length(param_name));
    sub("^ *=? *", "", param);

    next_param_pos = index(param, "|");
    template_end_pos = find_template_closing_pos(param);
    pos = (next_param_pos > 0 && next_param_pos < template_end_pos) ? next_param_pos : template_end_pos;

    param = substr(param, 0, pos - 1);
    sub(" *$", "", param);

    return param;
}


# Returns the position of the next closing brackets, that have not been opened as the given text in [line] was being
# consumed. Consider this example:
# apa |bepa={{cepa}} |depa={{epa}}}}
#
# For the above example, the number 33 will be returned, as that is the position of the next closing brackets that were
# not opened as the text was being consumed. Since '{{cepa}}' both openes and closes a pair of brackets, it will be
# ignored, and the same with '{{epa}}'. Stright after '{{epa}}', there is a pair of closing brackets, and its
# position (33) is returned.
#
# If no closing brackets are found, 0 will be returned.
function find_template_closing_pos(line,  result, max_depth) {
    max_depth = 256; # The depth is an arbitrary limit, preventing infinite call stacks
    result = recursively_find_template_closing_pos(line, 0, 0, max_depth);

    if (result == -1) {
        print_error("Unable to find closing template on line: " line);
        return 0;
    } else if (result == -2) {
        print_error("Performed more than " max_depth " recursive calls - giving up. Line: " line);
        return 0;
    } else {
        return result;
    }
}

# Function to recursively find the position of the next closing brackets.
# Returns the position if found.
# Returns -1 if no position is found.
# Returns -2 if the call stack limit has been exceeded (to prevent stack overflow).
function recursively_find_template_closing_pos(text, consumed_chars, opened_brackets, depth_left,  \
                                               open_pos, end_pos, consumed, bracket_diff) {
    open_pos = index(text, OPENING_BRACKETS);
    end_pos  = index(text, CLOSING_BRACKETS);

    if (end_pos <= 0)
        return -1;
    if (depth_left <= 0) {
        return -2;

    } else if (open_pos > 0 && open_pos < end_pos) {
        # New bracket opened
        consumed = open_pos + length(OPENING_BRACKETS);
        bracket_diff = 1;

    } else if (opened_brackets > 0) {
        # Bracket closed, but it is nested
        consumed = end_pos  + length(CLOSING_BRACKETS);
        bracket_diff = -1;

    } else {
        # End bracket found
        return consumed_chars + end_pos;
    }

    return recursively_find_template_closing_pos(\
        substr(text, consumed),                  \
        consumed_chars + consumed,               \
        opened_brackets + bracket_diff,          \
        depth_left - 1                           \
    );
}

# Trims away any whitespace (i.e. space, tab, newlines, carrige-returns) from the left and right of given [string]
function trim(string) {
    sub(/^[ \t\r\n]+/,  "", string);
    sub( /[ \t\r\n]+$/, "", string);
    return string;
}

# Prints [message] to stderr
function print_error(message) {
    print FILENAME ": " message > "/dev/stderr"
}

# Reads every line of the given [file] from disk and
# returns the content.
function read_file(file,  line, lines) {
    lines = "";
    while ((getline line < file) > 0) {
        if (lines == "")
            lines = line;
        else
            lines = lines "\n" line;
    }
    close(file);
    return lines;
}
