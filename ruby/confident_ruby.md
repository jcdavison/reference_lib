### A method has 4 key parts

1. Collecting Input
1. Performing Work
1. Delivering Output
1. Handling Failure

Writing a method in stripes that corresponsd to these parts is useful.

Confident Code is all about the messages being passed. 

Confident Code is code that sends messages that it is confident will be received and processed appropriately by the objects that receive them.

Confident Code must,

1. Identify the messages that want to be sent in order to accomplish the task at hand.

1. Identify the roles with correspond to these messages.

1. Enure a method's logic receives objects which are capable of playing these roles.

## COLLECTING INPUT

It is optimal to have input that properly map to the messages being passed and object receiving said messages.

3 Strategies for handling inputs in a 'defensive' fashion.

1. Coerce objects into the roles we need them to play.
1. Reject unexpected values with cannot play the needed roles.
1. Substitue known-good objects for unacceptable inputs.

Consider that if internally, a method gets called that expects a certain class or type of input, unconfident ruby would write excessive amounts of type checking code.  Confident ruby would assume that the inputs are of acceptable class, a conversion function is a good way to do that.  Ie, coerce an input into the required type and if conversion doesn't work, raise and error but don't write code that checks the class or type of an input as this code is unconcise and a hassle to maintain.

```ruby
inventory = ['apples', 17, 'oranges', 11, 'pears', 22]
Hash[*inventory]
# => {"apples"=>17, "oranges"=>11, "pears"=>22}
```

The above coerces string/array input into a hash

Below, we Arrayify inputs.

```ruby
Array("foo")                    # => ["foo"]
Array([1,2,3])                  # => [1, 2, 3]
Array([])                       # => []
Array(nil)                      # => []
Array({:a => 1, :b => 2})       # => [[:a, 1], [:b, 2]]
Array(1..5)                     # => [1, 2, 3, 4, 5]
```

If needed, an entire module can be built that converts inputs into whatever kind of object we care about and can be mixed into another class where it needs to be. Conversion functions need to be idempotent, ie, if we call the conversion function on something already converted, there are no consequences.

```ruby
module Graphics
  module Conversions
    module_function

    def Point(*args)
      case args.first
      when Point   then args.first
      when Array   then Point.new(*args.first)
      when Integer then Point.new(*args)
      when String  then Point.new(*args.first.split(':').map(&:to_i))
      else raise TypeError, "Cannot convert #{args.inspect} to Point"
      end
    end
  end

  Point = Struct.new(:x, :y) do
    def inspect
      "#{x}:#{y}"
    end
  end
end

include Graphics
include Graphics::Conversions

Point(Point.new(2,3))           # => 2:3
Point([9,7])                    # => 9:7
Point(3,5)                      # => 3:5
Point("8:10")                   # => 8:10
```

Using precondition checking seems pretty useful.  Ie, use a method to set an attribute on an object, the the input doens't pass a sanity check, raise and error and disallow the method creation.

```ruby
require 'date'
class Employee
  attr_accessor :name
  attr_reader :hire_date  

  def initialize(name, hire_date)
    @name          = name
    self.hire_date = hire_date
  end

  def hire_date=(new_hire_date)
    raise TypeError, "Invalid hire date" unless new_hire_date.is_a?(Date)
    @hire_date = new_hire_date
  end

  def due_for_tie_pin?
    ((Date.today - hire_date) / 365).to_i >= 10
  end

  def covered_by_pension_plan?
    hire_date.year < 2000
  end

  def bio
    "#{name} has been a Yoyodyne employee since #{hire_date.year}"
  end
end
```

Note that in the above, `hire_date=` gets run on init and raises an error if `new_hire_date` doesn't pass the conditional check.  Preconditions are a useful form of executable documentation as they tell the coder, as code is being executed, what the object expects to receive.

### Use `#fetch` to explicitly check presence of hash keys.

Consider between calling `hash[key]` and `hash.fetch key`.
```ruby
def test
  value = yield
  if value
    "truthy (#{value.inspect})"
  else
    "falsey (#{value.inspect})"
  end
rescue => error
  "error (#{error.class})"
end

h = { :a => 123, :b => false, :c => nil }

test{ h[:a] }                   # => "truthy (123)"
test{ h[:b] }                   # => "falsey (false)"
test{ h[:c] }                   # => "falsey (nil)"
test{ h[:x] }                   # => "falsey (nil)"

test{ h.fetch(:a) }             # => "truthy (123)"
test{ h.fetch(:b) }             # => "falsey (false)"
test{ h.fetch(:c) }             # => "falsey (nil)"
test{ h.fetch(:x) }             # => "error (KeyError)"

def add_user(attributes)
  login    = attributes.fetch(:login)
  password = attributes.fetch(:password) do
    raise KeyError, "Password (or false) must be supplied"
  end
  # ...
end
```

`#fetch` also accepts a block as the callback on raise error, allowing for more precise feedback messages to bubble up. Also very effective for setting default values.  Consider in the below, if the logger options is not set, the block will return the call to `Logger.new` and set the local variable `logger` to that object, very very explicity way to set a default vice `||` or `||=`.

```ruby
def emergency_puppies(options={})
  logger = options.fetch(:logger){ Logger.new($stderr) }
  # ...
end
```

To go deeper, the callback block can be defined as a Proc 'CONSTANT'

```ruby
DEFAULT_LOGGER = -> { Logger.new($stderr) }

def emergency_echidnas(options={})
  logger = options.fetch(:logger, &DEFAULT_LOGGER)
  # ...
end
```

Even deeper, `#fetch` with a declared second argument, ie, the first not being present gets substituted with second.  This is a problem because of eager evaluation, ie, the second argument could be a method or whatever that gets evaluated before the method is called, but in some cases since first param returns true, the eager evaluation of the 2nd arg is uncessesary.

```ruby
logger = options.fetch(:logger, Logger.new($stdout))
```

### Document Assumptions with Assertions

Consider data that comes back from an api, be very explicity and discreet in enforcing that expected data types don't diverge from actual data types.

```
class Account
  def refresh_transactions
    transactions = bank.read_transactions(account_number)
    transactions.is_a?(Array) or raise TypeError, "transactions is not an Array"
    transactions.each do |transaction|
      amount = transaction.fetch("amount")
      amount_cents = (Float(amount) * 100).to_i
      cache_transaction(:amount => amount_cents)
    end
  end
end
```

The above uses `Kernal#Float` to coerse the variables `amount` into a float and will raise an error, acting as a canary in the coal mine, when data from the api changes hopefully avoiding problems farther down the road in the program.

### Guard Clauses

Use guard clause to deal with certain issues.  Normally, `if` `else` logic should communicate that each state is possible.  

`return if @quiet` 

The above 'guards' in the case that things are `@quiet`.

```ruby
def log_reading(reading_or_readings))
  return if @quiet

  readings = Array(reading_or_readings))
  readings.each do |reading|
    puts "[READING] %3.2f" % reading.to_f
  end
end
```

## DELIVERING RESULTS

"Be conservative in what you send and liberal in what you accept."

Deliver results back to calling clients/coder/api in a kind and friendly manner.

### Write 'Total Functions'

A total function, according to mathy people, is a function that is defined for all possible inputs.  In programming, a total function is a method that never returns nil no matter the input.

Consider the below, `find_words` can return and Array, a String or Nil, this is not a total function and will force the calling scope to be ready to handle three different types of return values, ie, the calling scope can't be confident in what it will get back.

```ruby
def find_words(prefix)
  words = File.readlines('/usr/share/dict/words').
    map(&:chomp).reject{|w| w.include?("'") }
  matches = words.select{|w| w =~ /\A#{prefix}/}
  case matches.size
  when 0 then nil
  when 1 then matches.first
  else matches
  end
end

find_words('gnu')               # => ["gnu", "gnus"]
find_words('ruby')              # => "ruby"
find_words('fnord')             # => nil
```

Implement gaurd clauses and other code that is repsonsible for returning information back to the caller in a way the commits to 'total functionality'.

```ruby
def find_words(prefix)
  return [] if prefix.empty?
  magic_words = %w[klaatu barada nikto xyzzy plugh]
  words = File.readlines('/usr/share/dict/words').
    map(&:chomp).reject{|w| w =~ /'/}
  result = magic_words.include?(prefix) ? prefix : 
    words.select{|w| w =~ /\A#{prefix}/}
  Array(result)
end
```

### CallBack instead of return

Consider how frequently `if Object.do else Other.do` logic gets used in code.  Given that .do needs to return true/false, the method needs to have very very explicit boundaries about what is happening or else the intention of the code won't be clear.

```ruby
def import_purchase(date, title, user_email)
  user = User.find_by_email(user_email)
  if user.purchased_titles.include?(title)
    false
  else
    user.purchases.create(title: title, purchased_at: date)
    true
  end
end
# used as
if import_purchase(date, title, user_email)
  send_book_invitation_email(user_email, title)
end
# ...
```

In the above code, `import_purchase` doesn't clearly communicate what the `false` return meant it also violates CQS, command-query seperation, the idea that a method can call messages or return data but shouldn't do both.

A block as an argument can be very useful in this case, implement the execution of the callback inside `import_purchase` so that the calling scope doens't need the `if end` logic.  Import purchase has the wiring to know what to do when `.create` is successful.

```ruby
def import_purchase(date, title, user_email, &import_callback)
  user = User.find_by_email(user_email)
  unless user.purchased_titles.include?(title)
    purchase = user.purchases.create(title: title, purchased_at: date)
    import_callback.call(user, purchase)
  end
end

# called as

import_purchase(date, title, user_email) do |user, purchase|
  send_book_invitation_email(user.email, purchase.title)
end
```

### Represent failure with a benign value

Return a default value, like an empty string that will not interfere with the normal operastions of the caller.

Consider the below, `latest_tweets(n) || ""` is an expression of unconfident code as we aren't sure if (3) will return a value.  

```ruby
def latest_tweets(number)
  # ...fetch tweets and construct HTML...
rescue Net::HTTPError
  nil
end

def render_sidebar
  html = ""
  html << "<h4>What we're thinking about...</h4>"
  html << "<div id='tweets'>"
  html << latest_tweets(3) || ""
  html << "</div>"
end
```

`Nil` is the worst possibel return value in the case of failure because it communicates nothing about the why of the failure but has the adverse effect of being able to destroy the happy operations of the calling scope.

Consider rewriting `latest_tweets(n)` to return a blank, sterile, benign value that can be mixed back into the calling scope without fear of mechanical rebuttal.

```ruby
def latest_tweets(number)
  # ...fetch tweets...
rescue Net::HTTPError
  ""
end
```

### Represent failure with a special case object

Consider that in the case there is no `User`, we may want a stand in.  `GuestUser` could inherit from `User` an override some of the more unique aspects of user, or it could be something like `Struct`.

```ruby
def current_user
  if session[:user_id]
    User.find(session[:user_id])
  else
    GuestUser.new(session)
  end
end
```

### Return a status object

In cases there the possible outcomes have more than a success/failure nature, an object that encapsulates the outcomes can be useful.  It allows the calling scope not to worry about non-standard return values while also givint the calling scope the ability to dig deeper for more information if necessary.

Consider...

```ruby
def import_purchase(date, title, user_email)
  user = User.find_by_email(user_email)
  if user.purchased_titles.include?(title)
    return false
  else
    purchase = user.purchases.create(title: title, purchased_at: date)
    return true
  end
end
```

In the above code, we aren't going to know much about how the true/false came to be.  Consider implementing an object...

```ruby

class ImportStatus
  def self.success() new(:success) end
  def self.redundant() new(:redundant) end
  def self.failed(error) new(:failed, error) end

  attr_reader :error

  def initialize(status, error=nil)
    @status = status
    @error  = error
  end

  def success?
    @status == :success
  end

  def redundant?
    @status == :redundant
  end

  def failed?
    @status == :failed
  end
end

def import_purchase(date, title, user_email)
  user = User.find_by_email(user_email)
  if user.purchased_titles.include?(title)
    ImportStatus.redundant
  else
    purchase = user.purchases.create(title: title, purchased_at: date)
    ImportStatus.success
  end
rescue => error
  ImportStatus.failed(error)
end
```

Notice in the above that all kinds of information can be managed with the `ImportStatus` object and it provides a lot of clarity to the logic in `import_purchase`.

### Yield a status object

Consider that in certain situations, the methods aren't returning a value persay, if the method was calling other messages, we want to know about the state of those messages.

Let's implement an Object that yields a block based on its own state.

```ruby
class ImportStatus
  def self.success() new(:success) end
  def self.redundant() new(:redundant) end
  def self.failed(error) new(:failed, error) end

  attr_reader :error

  def initialize(status, error=nil)
    @status = status
    @error  = error
  end

  def on_success
    yield if @status == :success
  end

  def on_redundant
    yield if @status == :redundant
  end

  def on_failed
    yield(error) if @status == :failed
  end
end
```

We can then use this in `import_purchase`..

```ruby
def import_purchase(date, title, user_email)
  user = User.find_by_email(user_email)
  if user.purchased_titles.include?(title)
    yield ImportStatus.redundant
  else
    purchase = user.purchases.create(title: title, purchased_at: date)
    yield ImportStatus.success
  end
rescue => error
  yield ImportStatus.failed(error)
end
```

An in production, code would look like, where a block gets passed to `on_success` or `on_redundant` and based on the logic implemented in `ImportStatus`, if the appropriate status applies, the block will be `yielded` and the code will execute.  This is a very expclit pattern that allows for a high degree of confidence that the code will behave.  Notice the use of `rescue` statement and the lack of any `.nil?` or `.empty?` or `.whatever?` unconfident code.

```ruby
import_purchase(date, title, user_email) do |result|
  result.on_success do
    send_book_invitation_email(user_email, title)
  end
  result.on_redundant do
    logger.info "Skipped #{title} for #{user_email}"
  end
  result.on_error do |error|
    logger.error "Error importing #{title} for #{user_email}: #{error}"
  end
end
```

## Handling Failure

Avdi thinks that BRE `begin/rescue/end` is the pink lawn flamingo of Ruby, a distraction and eye sore wherever it turns up!

It interrupts the flow of code and distracts the programmer from what they expected to be happening.

### Prefer top level rescue clause

```ruby
#shit
def foo
  # do some work...
  begin
    # do some more work...
  rescue
    # handle failure...
  end
  # do some more work...
end

#not shit

def bar
# happy path goes up here
rescue #---------------------------
# failure scenarios go down here
end
```

### Use checked methods for risky operations

Consider a large-ish method that has an inline BRE, consider breaking the BRE into a seperate method call that more appropriately deals with the failure/edge cases.
