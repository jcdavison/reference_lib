## What is failure?

An 'error' is the presence in software of some element that does not satisfy its specification.

A 'failure' is the inability of software to satisfy its purpose.

An 'exception' is the occurrence of an abnormal condition during the execution of software.

The 'implicit contract'.

A method has an implicit contract with a call that sounds like 'based on expected inputs there are certain outputs and or processes that exepected to occur when whatever method is called'.

An error or failure is the inability of a method to fulfill this implicit contract.

## The life cycle of an exception

```ruby
begin
 fail "Oops";
rescue => error
  raise if error.message != "Oops"
end
```

`fail` and `raise` are synonymous though there is some cultural discussion around the nature of what intention `fail` vs `raise` communicate.

`raise [EXCEPTION_CLASS], [MESSAGE], [BACKTRACE]`

Rescue a specific class of Error.

```ruby
rescue StandardError => error
  # ...
end
```

Statement modifier, like trailing `if`, the below will in essense ignore errors that occure when attempting to open nonsuch.txt

```ruby
f = open("nonesuch.txt") rescue nil
```


Also possible to retry, maybe information changed? 

```ruby
tries = 0
begin
  tries += 1
  puts "Trying #{tries}..."
  raise "Didn't work"
rescue
  retry if tries < 3
  puts "I give up"
end
```

It is possibel wrap or nest exceptions.

```ruby
class MyError < StandardError
  attr_reader :original
   def initialize(msg, original=$!)
    super(msg)
    @original = original;
  end
end

begin
  begin
    raise "Error A"
  rescue => error
    raise MyError, "Error B"
  end
rescue => error
  puts "Current failure: #{error.inspect}"
  puts "Original failure:  #{error.original.inspect}"
end
```

Exception handling can be expensive, use it appropriately and don't make it a part of the core working of a methods implicit promise to deliver information/query/commands back to the caller.

### Responding to Failure

The first step if the failure isn't major, return a value or a flag to the caller, let the caller work it out.  `nil` is not an expressive value to return.

```ruby
def save
  # ...
rescue
  nil
end
# or 
begin
  response = HTTP.get_response(url)
  JSON.parse(response.body)
rescue Net::HTTPError
  {"stock_quote" => "<Unavailable>"}
end
```

Use a warning as an error

```ruby
module Kernel
  def warn(message)
    raise message
  end
end
```
`warn "uh oh"`

If ruby is run in debug mode, `ruby -d`, the warn will raise an error, otherwise, it will log to stdout. 


### Bulkhead

Consider that some systems shouldn't be able to pass failures to other systems, like a bulkhead on a ship.

The below will catch everything and log it, maybe not elegent but this will contain the errors and let someone look at the output.

```ruby
begin
  SomeExternalService.some_request
rescue Exception => error
  logger.error "Exception intercepted calling SomeExternalService"
  logger.error error.message
  logger.error error.backtrace.join("\n")
end
```


