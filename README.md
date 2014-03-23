# styoe (Start Your Engines!)

Start Your Engines™.

## Installation

```bash
$ gem install styoe
```

## Usage

Create a `.engines` file on your home directory, and write a yaml-formatted file
with the applications you would like to start:

```yaml
skype:        "/Applications/Skype.app/Contents/MacOS/Skype"
sublime-text: "/Applications/Sublime Text.app/Contents/MacOS/Sublime Text"
flint:        "/Applications/Flint.app/Contents/MacOS/Flint"
```

And then execute:

```bash
styoe
```

Your applications will be up and running in seconds. When you are done with them
just execute:

```bash
styoe --stop
```

And they will disappear. For other great functionalities, please check
[features](features).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
