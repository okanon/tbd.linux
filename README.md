# tbd.linux

Convert Mach-O Libraries &amp; Frameworks to .tbd

## How to Build
`make` or `make C=gcc`

## How to Use

```
Usage: tbd [-p/--path] [path-options] [file-paths] [-o/--output] [output-options] [output-paths]
Main options:
    -h, --help,   Print this message
    -o, --output, Path to an output file (or directory for recursing/dyld_shared_cache files) to write converted tbd files.
                  If provided file(s) already exists, contents will be overridden.
                  Can also provide "stdout" to print to stdout
    -p, --path,   Path to a mach-o or dyld_shared_cache file to convert to a tbd file.
                  Can also provide "stdin" to use standard input.
    -u, --usage,  Print this message

Path options:
Usage: tbd [-p] [options] path
    -r, --recurse, Specify directory to recurse and find all mach-o library and dyld_shared_cache images
                   Two modes exist for recursing:
                       once, Recurse only the top-level directory. This is the default mode for recursing
                       all,  Recurse both the top-level directory and over all sub-directories

Write options:
Usage: tbd -o [options] path
        --preserve-subdirs,       Preserve the sub-directories of where files were found
                                  when recursing in relation to the actual provided recurse-path
        --no-overwrite,           Prevent overwriting of files when writing out
        --replace-path-extension, Replace the path-extension(s) of provided file(s) when
                                  writing out (Instead of simply appending .tbd)
        --combine-tbds,           Combine all tbds created (when recursing or with a dyld-shared-cache) into a
                                  single .tbd file

Both local and global options:
        --macho,                         Specify that the file(s) provided should only be parsed
                                         if the file is a mach-o file.
                                         This option can be used to limit the filetypes parsed
                                         while recursing
        --dsc,                           Specify that the file(s) provided should only be parsed
                                         if it is a dyld-shared-cache file.
                                         Providing --macho or --dsc limits filetypes parsed when recursing
               --filter-image-directory, Specify a directory to filter dyld_shared_cache images from
               --filter-image-filename,  Specify a filename to filter dyld_shared_cache images from
               --filter-image-number,    Specify the number of an dyld_shared_cache image to parse out.
                                         To get the numbers of all available images, use the option --list-dsc-images
               --image-path,             Specify the path of an image to parse out.
                                         To get the paths of all available images, use the option --list-dsc-images
        -v, --version,                   Specify version of .tbd files to convert to (default is v2).
                                         This applies to all files where tbd-version was not explicitly set.
                                         To get a list of all available versions, look at the options below, or use
                                         the option --list-tbd-versions
        -v1,                             Set version of .tbd files to version v1.
        -v2,                             Set version of .tbd files to version v2. (This is the default .tbd version)
        -v3,                             Set version of .tbd files to version v3.

Ignore options:
        --ignore-clients,               Ignore clients field
        --ignore-compatibility-version, Ignore compatibility-version field
        --ignore-current-version,       Ignore current-version field
        --ignore-objc-constraint,       Ignore objc-constraint field
        --ignore-parent-umbrella        Ignore parent-umbrella field
        --ignore-reexports,             Ignore re-expotrs field
        --ignore-swift-version,         Ignore swift-version field
        --ignore-undefineds,            Ignore undefineds field
        --ignore-uuids,                 Ignore uuids field

General ignore options:
        --ignore-requests,          Ignore any and all user requests (both a path and global option)
        --ignore-warnings,          Ignore any warnings (both a path and global option)
        --ignore-wrong-filetype,    Ignore any warnings about a mach-o file having the wrong
                                    filetype (both a path and global option)

Symbol options: (Both path and global options)
        --allow-private-objc-symbols,   Allow all non-external objc-symbols (classes, ivars, and ehtypes)
        --allow-private-objc-classes,   Allow all non-external objc-classes
        --allow-private-objc-ehtypes,   Allow all non-external objc-ehtypes.
                                        objc-ehtype symbols are only recognized for .tbd version v3
        --allow-private-objc-ivars,     Allow all non-external objc-ivars
        --use-symbol-table,             Use the symbol-table over the export-trie

Field options: (Both path and global options)
        --replace-archs,           Provide a list of architectures to replace the list found in the provided input file(s)
                                   A list of architectures can be found by using option --list-architectures.
                                   Replacing the list of architectures will automatically remove the uuids field.
                                   In addition, each exported symbol will have the replaced list of architectures
        --replace-current-version, Provide a current-version to replace the one found in the provided input file(s)
        --replace-compat-version,  Provide a compatibility-version to replace the one found in the provided input file(s)
        --replace-flags,           Provide flag(s) to replace flags found for .tbd files.
                                   A list of flags can be found by using option --list-tbd-flags
        --replace-objc-constraint, Provide an objc-constraint to replace the one found in the provided input file(s)
        --replace-platform,        Provide a platform to replace the one found for in the provided input file(s)
        --replace-swift-version,   Provide a swift-version to replace the one found for in the provided input file(s)

Ignore field warning options: (Both path and global options)
        --ignore-missing-exports,  Ignore error for when no symbols or reexpors to write out
                                   are found
        --ignore-missing-uuids,    Ignore error for when uuids are not found
        --ignore-non-unique-uuids, Ignore error for when uuids found are not unique among one another

List options:
        --list-architectures,    List all valid architectures for .tbd files.
                                 Also able to list architectures of a single mach-o file from a provided path
        --list-dsc-images,       List all images of a dyld_shared_cache from a path to a single dyld_shared_cache file
                                 One option exists for listing dsc-images:
                                     --ordered
                                         Order image-paths alphabetically before printing them.
                                         An image-path's listed number from the ordered list should not be provided
                                         for option --filter-image-number
        --list-objc-constraints, List all valid objc-constraints
        --list-platform,         List all valid platforms
        --list-tbd-flags,        List all valid flags for .tbd files
        --list-tbd-versions,     List all valid versions for .tbd files
```
