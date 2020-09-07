# macOS 10.15 "Catalina" has *issues*
if test (uname) = Darwin
    set -l darwin_version (uname -r | string split .)
    # macOS 15 is Darwin 19
    if test "$darwin_version[1]" = 19 -a "$darwin_version[2]" -le 6
        function __fish_describe_command; end
        exit
    end
end
