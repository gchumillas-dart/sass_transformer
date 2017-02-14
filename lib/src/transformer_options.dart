import 'dart:io';

/// Class to be used to parse sass transformer options coming from pubspec.yaml file
class TransformerOptions {
  /// include_path: /lib/sassIncludes - variable and mixims files
  final Set<String> includePaths;

  /// output: web/output.css - result file. If '' same as web/input.css
  final String output;

  /// executable: sassc - command to execute sassc  - NOT USED
  final String executable;

  /// Style of generated CSS
  final String style;

  /// Include compass
  final bool compass;

  /// Include line numbers in output
  final bool lineNumbers;

  /// Copy original .scss/.sass files to output directory
  final bool copySources;

  /// Verbosity mode
  final bool verbose;

  /// Creates [TransformerOptions] from options values
  TransformerOptions._(
      {this.includePaths,
      this.output,
      this.executable,
      this.style,
      this.compass,
      this.lineNumbers,
      this.copySources,
      this.verbose});

  /// Creates a [TransformerOptions] object from [configuration] Map
  factory TransformerOptions(Map configuration) {
    config(key, defaultValue) {
      var value = configuration[key];
      return value ?? defaultValue;
    }

    Set<String> readStringList(value, [defaultValue]) {
      if (value is List<String>) return new Set.from(value);
      if (value is String) return new Set.from([value]);
      return new Set.from(defaultValue);
    }

    return new TransformerOptions._(
        includePaths: readStringList(configuration['include_paths'], []),
        output: config('output', ''),
        executable: config('executable',
            (Platform.operatingSystem == "windows" ? "sass.bat" : "sass")),
        style: config("style", null),
        compass: config("compass", false),
        lineNumbers: config("line_numbers", false),
        copySources: config("copy_sources", false),
        verbose: config("verbose", false));
  }
}
