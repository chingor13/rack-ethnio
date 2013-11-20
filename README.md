# Rack::Ethnio
This Rack middleware will easily integrate your Rack-based app with Ethnio's website recruiting feature.

## Usage

### Rails
In your `application.rb`:

```
config.middleware.use Rack::Ethnio
```

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


