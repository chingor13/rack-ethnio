# Rack::Ethnio
This Rack middleware will easily integrate your Rack-based app with Ethnio's website recruiting feature.

If your request is a redirect, we will store the Ethnio id in the session and show it on the next available page.

## Usage

### Rails
Nothing, already set up via a Railtie.  We do provide a convience `show_ethnio!(ethnio_id)` in your controllers.

### Generic Rack app
In your `config.ru`:

```
require 'rack-ethnio'
use Rack::Ethnio
```

## Starting a recruiting screen
In your application:
```
env['rack.ethnio'] = <ethnio_id>
```


